#!/bin/sh
#shellcheck disable=all

##########################
#         RICING         #
##########################

. "${XDG_CONFIG_HOME:-$HOME/.config}/ytfzf/style.sh"

##########################
#      STATUS VARS       #
##########################

[ "$NVIM" ] && PRIVATE_in_nvim=1 || PRIVATE_in_nvim=0

[ -z "$PRIVATE_do_on_no_thumbnail" ] && export PRIVATE_do_on_no_thumbnail=0

##########################
#    CUSTOM FUNCTIONS    #
##########################

##################
#  URL HANDLERS  #
##################

get_frame_at_s() {
	: "${PRIVATE_frame_dir:="${YTFZF_CONFIG_DIR}/video-frames"}"
	mkdir -p "$PRIVATE_frame_dir"
	echo "$PRIVATE_nth_frame"
	ffmpeg -ss "${PRIVATE_nth_frame:-$((RANDOM % 1200))}" -i "$1" -frames 1 -r 1/1 "${PRIVATE_frame_dir}/%03d.png"
}

##################
#     MENUS      #
##################

search_prompt_menu_ext() {
	_search="$(
		tac "$search_hist_file" | rofi -dmenu -width 1500 -p "Search" |
			cut -f2-
	)"
}

external_menu() {
	remove_ansi_escapes | column -t -s "$tab_space" -o ' ' | tr -d "$tab_space" | rofi -dmenu -i -width 1500 -p "$1" | awk '{print $NF}'
}

##################
#FORMAT SELECTION#
##################

#Same as simple, but if there are multiple of a specific quality, open a menu to select
#a specific one
get_video_format_simple_extra() {
	# select format if flag given
	formats=$(${ytdl_path} -F "$1")
	line_number=$(printf "$formats" | grep -n '.*extension  resolution.*' | cut -d: -f1)
	quality=$(printf "$formats \n1 2 xAudio" | awk -v lineno=$line_number 'FNR > lineno {print $3}' | sort -n | awk -F"x" '{print $2 "p"}' | uniq | sed -e "s/Audiop/Audio/" -e "/^p$/d" | quick_menu_wrapper "video quality" | sed "s/p//g")
	if printf "%s" "$formats" | grep -q "audio only"; then
		video_format_no=$(printf "%s" "$formats" | grep -F "x$quality")
		if [ "$(printf "%s\n" "$video_format_no" | wc -l)" -gt 1 ]; then
			video_format_no="$(printf "%s" "$video_format_no" | quick_menu_wrapper "There are multiple options for this quality, choose one, (if you are unsure, just press enter)")"
		fi
		video_format_no="${video_format_no%% *}"
		[ "$quality" = Audio ] && is_audio_only=1 ||
			ytdl_pref="$video_format_no+bestaudio/bestaudio"
	else
		[ "$quality" = Audio ] && is_audio_only=1 ||
			ytdl_pref="best[height=$quality]/best[height<=?$quality]/bestaudio"
	fi
	unset max_quality quality
}

##################
#    SCRAPERS    #
##################

#scrapes $HOME/.local/share/osu-stable/Songs
scrape_osu_dir() {
	download_thumbnails() {
		for line in "$@"; do
			line="${line#file://}"
			location="${line%%;*}"
			id="${line##*;}"
			cp "$(printf "%s" "$location" | sed 's/_ytfzf_sPaCe/ /g')" "$thumb_dir/$id.jpg" 2>/dev/null
		done
	}

	video_player() {
		thumbnail="$(jq -r --arg url "$1" ".[]|select(.url==\$url).thumbs" <"$ytfzf_video_json_file")"
		title="$(jq -r --arg url "$1" ".[]|select(.url==\$url).title" <"$ytfzf_video_json_file")"
		thumbnail="${thumbnail#file://}"
		location="${1#file://}"
		location="$(printf "%s" "$location" | sed 's/_ytfzf_sPaCe/ /g')"
		thumbnail="$(printf "%s" "$thumbnail" | sed 's/_ytfzf_sPaCe/ /g')"
		#mpv "${location//%20/ }"
		ffmpeg -y -i "$(printf "%s" "$location" | sed 's/%20/ /g')" -i "${thumbnail}" -f flv - </dev/null | mpv -
	}

	output_json_file=$2
	_osu_dir_jsonl_file="${session_temp_dir}/osu.jsonl"
	print_info "Scraping: osu directory\n"
	_start_series_of_threads
	while read -r line; do
		{
			print_info "Scraping song: $line\n"
			thumb=$(find "${XDG_SHARE_HOME:-$HOME/.local/share}/osu-stable/Songs/${line}" -maxdepth 1 -iregex '.*\.\(png\|jpg\)' | head -n 1)
			thumb="${thumb%%${new_line}*}"
			audio=$(find "${XDG_SHARE_HOME:-$HOME/.local/share}/osu-stable/Songs/${line}" -maxdepth 1 -iname '*.mp3' | head -n 1)
			audio="${audio%%${new_line}*}"
			echo "{\"ID\": \"${line%% *}\", \"url\": \"file://$(printf "%s" "$audio" | sed 's/ /_ytfzf_sPaCe/g')\", \"title\": \"${line}\", \"thumbs\": \"file://$(printf "%s" "$thumb" | sed 's/ /_ytfzf_sPaCe/g')\"}" >>"$_osu_dir_jsonl_file"
		} &
		_thread_started "$!"
	done <<EOF
    $(ls -1 "${XDG_SHARE_HOME:-$HOME/.local/share}/osu-stable/Songs")
EOF
	wait
	jq -s <"$_osu_dir_jsonl_file" >>"$output_json_file"
}

##################
#   SEARCH SRC   #
##################

#basically just list files in the osu dir
get_search_from_osu() {
	_search=$(ls -1 "${XDG_SHARE_HOME:-$HOME/.local/share}/osu-stable/Songs" | cut -d ' ' -f2- | quick_menu_wrapper)
}

#get a random word
get_search_from_random() {
	_search=$(shuf <"$HOME/Documents/words.txt" | head -n1)
}

##################
#   RQSTD INFO   #
##################

get_requested_info_title() {
	jq -r '.[] | if( [.url] | inside('"$urls"')) then .title else "" end' <"$ytfzf_video_json_file"

}

##########################
#     EVENT LISTENERS    #
##########################

# if in tty
[ "$XDG_SESSION_TYPE" = "tty" ] && {
	if [ "$url_handler" = "mpv" ]; then
		#drm plays *directly* on the screen
		url_handler_opts="$url_handler_opts --vo=drm"
	fi
	load_thumbnail_viewer catimg
	notify_playing=1
	#bit of a hack to listen when the url handler is opened
	handle_playing_notifications() {
		#i forget exactly why i need to clear the screen, but here we are
		clear
	}
}

#alt-n shortcut
handle_keypress_alt_n() {
	read -r url <"$ytfzf_selected_urls"
	#play the next video
	YTFZF_CHECK_VARS_EXISTS=1 exec ytfzf -u "$url_handler" -cvideo-recommended "$url"
	return 3
}

#alt-r shortcut
#is the same as -IR
handle_keypress_alt_r() {
	urls="[$(sed 's/^\(.*\)$/"\1",/' "$ytfzf_selected_urls")"
	urls="${urls%,}]"
	jq -r '.[] | if( [.url] | inside('"$urls"')) then "\(.title)\t|\(.channel)\t|\(.duration)\t|\(.views)\t|\(.date)\t|\(.url)" else "" end' <"$ytfzf_video_json_file" | { command_exists "column" && column -s "$tab_space" -t; }

}

#alt-b shortcut
#open in browser
handle_keypress_alt_b() {
	url_handler=$BROWSER
}

on_opt_parse() {
	case "$1" in
	a | r | A | S)
		enable_back_button=0
		is_loop=0
		;;
	c)
		case "$2" in
		sI)
			set_scrape "SI"
			is_sort=1
			search_result_type=videos
			return 1
			;;
		SI | S)
			is_sort=1
			search_result_type=videos
			;;
		pictures)
			load_url_handler "ffplay"
			;;
		ani-gogohd-link) export PRIVATE_do_on_no_thumbnail=0 ;;
		ani | ani-category)
			export PRIVATE_do_on_no_thumbnail=1
			;;
		esac
		;;
	pl)
		set_scrape "p"
		search="$HOME/.config/ytfzf/playlists/$2.ytfzfpl"
		return 1
		;;
	search)
		set_scrape ddg
		return 1
		;;
	update)
		shift $((OPTIND - 1))
		ytfzfctl update "$@"
		exit
		;;
	comments)
		$0 -ccomments --thumb-viewer=null "$(ytfzfctl video-info url)"
		exit
		;;
	vi | info | video-info)
		$0 -cvideo-info --thumb-viewer=null "$(ytfzfctl video-info url)"
		exit
		;;
	esac
}

on_opt_parse_mon() {
	export mpvpaper_mon="${optarg:-HDMI-A-1}"
	return 1
}

#runs when a website is about to be scraped
ext_on_search() {
	case "$curr_scrape" in
	S | SI)
		PRIVATE_old_search_result_type="$search_result_type"
		search_result_type=videos
		;;
	esac

	case "$1" in
	:exit) exit 0 ;;
	u://*)
		expr "$curr_scrape" : "u\|U\| url" >/dev/null || curr_scrape=U
		_search=${_search#u://}
		;;
	y://*)
		curr_scrape=Y
		_search="${_search#y://}"
		;;
	o://*)
		curr_scrape=O
		_search="${_search#o://}"
		;;
	p://*)
		curr_scrape=P
		_search="${_search#p://}"
		;;
	pics://)
		set_scrape pictures
		source_scrapers
		curr_scrape=pictures
		_search=""
		;;
	ytfzf://*)
		_search="${1#ytfzf://}"
		_search="$(printf "%s" "$_search" | tr '+' ' ')"
		;;
	esac
}

[ -f "$HOME/.local/state/tv-mode" ] && url_handler_opts="${url_handler_opts} --fullscreen"

on_opt_parse_frame_at_second() {
	PRIVATE_nth_frame="$1"
	return 1
}
on_opt_parse_frame_dir() {
	PRIVATE_frame_dir="$1"
	return 1
}

on_opt_parse_term_size() {
	printf "COLS: %d\nLINES: %d\n" "$TTY_COLS" "$TTY_LINES"
	exit 0
}

on_opt_parse_term() {
	url_handler_opts="--vo='sixel' --quiet"
	return 1
}
