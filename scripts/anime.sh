#!/bin/sh

[ ! -d ~/.config/jerry ] && mkdir -p ~/.config/jerry
access_token=$(cat ~/.config/jerry/anilist_token.txt)
[ -z "$access_token" ] && printf "Paste your access token from this page:
https://anilist.co/api/v2/oauth/authorize?client_id=9857&response_type=token: " && read -r access_token &&
	echo "$access_token" > ~/.config/jerry/anilist_token.txt && access_token=$(cat ~/.config/jerry/anilist_token.txt)
  user_id=$(cat ~/.config/jerry/anilist_user_id.txt)
[ -z "$user_id" ] && 
  user_id=$(curl -s -X POST "https://graphql.anilist.co" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -H "Authorization: Bearer $access_token" \
    -d "{\"query\":\"query { Viewer { id } }\"}"|sed -nE "s@.*\"id\":([0-9]*).*@\1@p") &&
  echo "$user_id" > ~/.config/jerry/anilist_user_id.txt && user_id=$(cat ~/.config/jerry/anilist_user_id.txt)

history_file="$HOME/.cache/anime_history"

# launcher="tofi --require-match false --fuzzy-match true --prompt-text > "
launcher="fzf"
# launcher="wofi -d -i -W 20%"

choice=$(printf "Watch\nUpdate\nInfo\nWatch New"|$launcher)

nth() {
  stdin=$(cat)
  line=$(echo "$stdin"|awk -F '\t' "{ print NR, $1 }"|$launcher|cut -d\  -f1)
  [ -n "$line" ] && echo "$stdin"|sed "${line}q;d" || exit 1
}

get_anime_from_list() {
  anime_list=$(curl -s -X POST "https://graphql.anilist.co" \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $access_token" \
    -d "{\"query\":\"query(\$userId:Int,\$userName:String,\$type:MediaType){MediaListCollection(userId:\$userId,userName:\$userName,type:\$type){lists{name isCustomList isCompletedList:isSplitCompletedList entries{...mediaListEntry}}user{id name avatar{large}mediaListOptions{scoreFormat rowOrder animeList{sectionOrder customLists splitCompletedSectionByFormat theme}mangaList{sectionOrder customLists splitCompletedSectionByFormat theme}}}}}fragment mediaListEntry on MediaList{id mediaId status score progress progressVolumes repeat priority private hiddenFromStatusLists customLists advancedScores notes updatedAt startedAt{year month day}completedAt{year month day}media{id title{userPreferred romaji english native}coverImage{extraLarge large}type format status(version:2)episodes volumes chapters averageScore popularity isAdult countryOfOrigin genres bannerImage startDate{year month day}}}\",\"variables\":{\"userId\":$user_id,\"type\":\"ANIME\"}}")
  anime_choice=$(printf "%s" "$anime_list"|tr "\[|\]" "\n"|sed -nE "s@.*\"mediaId\":([0-9]*),\"status\":\"$1\",\"score\":(.*),\"progress\":([0-9]*),.*\"userPreferred\":\"([^\"]*)\".*\"status\":\"([^\"]*)\",\"episodes\":([0-9]*).*@\4 (\3/\6) \t[\2]\t[\1]@p"|
    nth "\$1,\$2")
  anime_title=$(printf "%s" "$anime_choice"|sed -E "s@(.*) \([0-9]*/[0-9]*\) \t.*@\1@")
  progress=$(printf "%s" "$anime_choice"|sed -nE "s@^([^\(]*)\(([0-9]*)\/([0-9]*)\).*@\2@p")
  episodes_total=$(printf "%s" "$anime_choice"|sed -nE "s@^([^\(]*)\(([0-9]*)\/([0-9]*)\).*@\3@p")
  score=$(printf "%s" "$anime_choice"|sed -nE "s@$anime_title \([0-9]*/[0-9]*\) \t\[([0-9]*)\].*@\1@p")
  media_id=$(printf "%s" "$anime_choice"|sed -nE "s@.*\[([0-9]*)\]@\1@p")
  [ -z "$anime_title" ] && exit 0
}

search_anime() {
  query=$(echo ""|$launcher)
  [ -z "$query" ] && exit 1 && notify-send -t 1000 "Error: No query provided"
  anime_list=$(curl -s -X POST "https://graphql.anilist.co" \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '"$access_token"'' \
    -d "{\"query\":\"query(\$page:Int = 1 \$id:Int \$type:MediaType \$isAdult:Boolean = false \$search:String \$format:[MediaFormat]\$status:MediaStatus \$countryOfOrigin:CountryCode \$source:MediaSource \$season:MediaSeason \$seasonYear:Int \$year:String \$onList:Boolean \$yearLesser:FuzzyDateInt \$yearGreater:FuzzyDateInt \$episodeLesser:Int \$episodeGreater:Int \$durationLesser:Int \$durationGreater:Int \$chapterLesser:Int \$chapterGreater:Int \$volumeLesser:Int \$volumeGreater:Int \$licensedBy:[Int]\$isLicensed:Boolean \$genres:[String]\$excludedGenres:[String]\$tags:[String]\$excludedTags:[String]\$minimumTagRank:Int \$sort:[MediaSort]=[POPULARITY_DESC,SCORE_DESC]){Page(page:\$page,perPage:20){pageInfo{total perPage currentPage lastPage hasNextPage}media(id:\$id type:\$type season:\$season format_in:\$format status:\$status countryOfOrigin:\$countryOfOrigin source:\$source search:\$search onList:\$onList seasonYear:\$seasonYear startDate_like:\$year startDate_lesser:\$yearLesser startDate_greater:\$yearGreater episodes_lesser:\$episodeLesser episodes_greater:\$episodeGreater duration_lesser:\$durationLesser duration_greater:\$durationGreater chapters_lesser:\$chapterLesser chapters_greater:\$chapterGreater volumes_lesser:\$volumeLesser volumes_greater:\$volumeGreater licensedById_in:\$licensedBy isLicensed:\$isLicensed genre_in:\$genres genre_not_in:\$excludedGenres tag_in:\$tags tag_not_in:\$excludedTags minimumTagRank:\$minimumTagRank sort:\$sort isAdult:\$isAdult){id title{userPreferred}coverImage{extraLarge large color}startDate{year month day}endDate{year month day}bannerImage season seasonYear description type format status(version:2)episodes duration chapters volumes genres isAdult averageScore popularity nextAiringEpisode{airingAt timeUntilAiring episode}mediaListEntry{id status}studios(isMain:true){edges{isMain node{id name}}}}}}\",\"variables\":{\"page\":1,\"type\":\"ANIME\",\"sort\":\"SEARCH_MATCH\",\"search\":\"$query\"}}"|
    tr "\[|\]" "\n"|sed -nE "s@.*\"id\":([0-9]*),.*\"userPreferred\":\"(.*)\"\},\"coverImage\".*\"episodes\":([0-9]*).*@\2 (\3 episodes)\t[\1]@p"|nth "\$1"|sed -nE "s@(.*) \(([0-9]*) episodes\).*\[([0-9]*)\]@\1\t\2\t\3@p")
  anime_title=$(printf "%s" "$anime_list"|cut -f1)
  episodes_total=$(printf "%s" "$anime_list"|cut -f2)
  media_id=$(printf "%s" "$anime_list"|cut -f3)
}

update_episode() {
  curl -s -X POST "https://graphql.anilist.co" \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $access_token" \
    -d "{\"query\":\"mutation(\$id:Int \$mediaId:Int \$status:MediaListStatus \$score:Float \$progress:Int \$progressVolumes:Int \$repeat:Int \$private:Boolean \$notes:String \$customLists:[String]\$hiddenFromStatusLists:Boolean \$advancedScores:[Float]\$startedAt:FuzzyDateInput \$completedAt:FuzzyDateInput){SaveMediaListEntry(id:\$id mediaId:\$mediaId status:\$status score:\$score progress:\$progress progressVolumes:\$progressVolumes repeat:\$repeat private:\$private notes:\$notes customLists:\$customLists hiddenFromStatusLists:\$hiddenFromStatusLists advancedScores:\$advancedScores startedAt:\$startedAt completedAt:\$completedAt){id mediaId status score advancedScores progress progressVolumes repeat priority private hiddenFromStatusLists customLists notes updatedAt startedAt{year month day}completedAt{year month day}user{id name}media{id title{userPreferred}coverImage{large}type format status episodes volumes chapters averageScore popularity isAdult startDate{year}}}}\",\"variables\":{\"status\":\"$3\",\"progress\":$(( $1 + 1 )),\"mediaId\":$2}}"
  [ "$3" = "COMPLETED" ] && notify-send -t 5000 "Completed $anime_title" && sed -i "/$media_id/d" "$history_file" && exit
}

update_episode_from_list() {
  status_choice=$(printf "CURRENT\nCOMPLETED\nPAUSED\nDROPPED\nPLANNING"|$launcher)
  # status_choice="CURRENT"
  get_anime_from_list "$status_choice"
  notify-send -t 5000 "Enter new progress for: $anime_title"
  notify-send -t 5000 "Current progress: $progress/$episodes_total episodes watched"
  case $launcher in
    fzf) printf "> " && read -r new_episode_number ;;
    *) new_episode_number=$(printf ""|$launcher)
  esac
  [ -z "$new_episode_number" ] && exit 0
  notify-send -t 3000 "Updating progress for $anime_title..."
  [ "$new_episode_number" -eq "$episodes_total" ] && status="COMPLETED" || status="CURRENT"
  response=$(update_episode "$((new_episode_number - 1))" "$media_id" "$status")
  notify-send -t 3000 "New progress: $new_episode_number/$episodes_total episodes watched"
  [ "$new_episode_number" -eq "$episodes_total" ] && notify-send -t 3000 "Completed $anime_title"
}

update_status() {
  status_choice=$(printf "CURRENT\nCOMPLETED\nPAUSED\nDROPPED\nPLANNING"|$launcher)
  get_anime_from_list "$status_choice"
  notify-send -t 5000 "Choose a new status for $anime_title"
  new_status=$(printf "CURRENT\nCOMPLETED\nPAUSED\nDROPPED\nPLANNING"|$launcher)
  [ -z "$new_status" ] && exit 0
  notify-send -t 3000 "Updating status for $anime_title..."
  response=$(update_episode "$((progress - 1))" "$media_id" "$new_status")
  if printf "%s" "$response"|grep -q "errors"; then
    notify-send -t 3000 "Failed to update status for $anime_title"
  else
    notify-send -t 3000 "New status: $new_status"
  fi
}

update_score() {
  status_choice=$(printf "CURRENT\nCOMPLETED\nPAUSED\nDROPPED\nPLANNING"|$launcher)
  get_anime_from_list "$status_choice"
  notify-send -t 5000 "Enter new score for: \"$anime_title\""
  notify-send -t 5000 "Current score: $score"
  case $launcher in
    fzf) printf "> " && read -r new_score ;;
    *) new_score=$(printf ""|$launcher)
  esac
  [ -z "$new_score" ] && exit 0
  notify-send -t 3000 "Updating score for $anime_title..."
  response=$(curl -s -X POST "https://graphql.anilist.co" \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $access_token" \
    -d "{\"query\":\"mutation(\$id:Int \$mediaId:Int \$status:MediaListStatus \$score:Float \$progress:Int \$progressVolumes:Int \$repeat:Int \$private:Boolean \$notes:String \$customLists:[String]\$hiddenFromStatusLists:Boolean \$advancedScores:[Float]\$startedAt:FuzzyDateInput \$completedAt:FuzzyDateInput){SaveMediaListEntry(id:\$id mediaId:\$mediaId status:\$status score:\$score progress:\$progress progressVolumes:\$progressVolumes repeat:\$repeat private:\$private notes:\$notes customLists:\$customLists hiddenFromStatusLists:\$hiddenFromStatusLists advancedScores:\$advancedScores startedAt:\$startedAt completedAt:\$completedAt){id mediaId status score advancedScores progress progressVolumes repeat priority private hiddenFromStatusLists customLists notes updatedAt startedAt{year month day}completedAt{year month day}user{id name}media{id title{userPreferred}coverImage{large}type format status episodes volumes chapters averageScore popularity isAdult startDate{year}}}}\",\"variables\":{\"score\":$new_score,\"mediaId\":$media_id}}")
  if printf "%s" "$response"|grep -q "errors"; then
    notify-send -t 3000 "Failed to update score for $anime_title"
  else
    notify-send -t 3000 "New score: $new_score"
  fi
}

watch_anime() {
    anime_json=$(curl -s "https://api.consumet.org/meta/anilist/info/${media_id}"|tr "{|}" "\n"|
      sed -nE "s@.*\"id\":\"([^\"]*)\",\"title\":\"(.*)\",\"description\".*\"number\":$((progress + 1)),.*@\1\t\2@p")
    [ -z "$anime_json" ] && notify-send -t 3000 "Error: $anime_title episode $((progress + 1))/$episodes_total not found" && exit 1
    episode_id=$(printf "%s" "$anime_json"|cut -f1)
    episode_title=$(printf "%s" "$anime_json"|cut -f2|sed "s@\\\@@g")

    episode_links=$(curl -s "https://api.consumet.org/meta/anilist/watch/${episode_id}")
    [ -z "$episode_links" ] && notify-send -t 1000 "Error: no links found for $anime_title episode $((progress + 1))/$episodes_total" && exit 1

    [ "$((progress + 1))" -eq "$episodes_total" ] && status="COMPLETED" || status="CURRENT"
    notify-send -t 3000 "Watching $anime_title - Ep: $((progress + 1)) $episode_title"

    referrer=$(printf "%s" "$episode_links"|tr "{|}" "\n"|sed -nE "s@\"Referer\":\"([^\"]*)\"\$@\1@p")
    video_link=$(printf "%s" "$episode_links"|tr "{|}" "\n"|sed -nE "s@\"url\":\"([^\"]*)\".*\"quality\":\"1080p\"\$@\1@p")

    [ -f "$history_file" ] && history=$(grep -E "^$media_id" "$history_file")
    [ -n "$history" ] && resume_from=$(printf "%s" "$history"|cut -f2)
    [ -n "$resume_from" ] && notify-send -t 3000 "Resuming from saved progress: $resume_from%"

    [ -z "$resume_from" ] && opts="" || opts="--start=${resume_from}%"
    stopped_at=$(mpv --fs --referrer="$referrer" --force-media-title="$anime_title - Ep: $((progress + 1)) $episode_title" "$opts" "$video_link" 2>&1|grep AV|
                tail -n1|sed -nE 's_.*AV: ([^ ]*) / ([^ ]*) \(([0-9]*)%\).*_\3_p' &)

    if [ "$stopped_at" -gt 85 ]; then
      response=$(update_episode "$progress" "$media_id" "$status")
      if printf "%s" "$response"|grep -q "errors"; then
        notify-send "Error updating progress"
      else
        notify-send -t 3000 "Updated progress to $((progress + 1))/$episodes_total episodes watched"
        [ -n "$history" ] && sed -i "/^$media_id/d" "$history_file"
      fi
    else
      notify-send -t 3000 "Current progress: $progress/$episodes_total episodes watched"
      notify-send -t 3000 "Your progress has not been updated"
      grep -sv "$media_id" "$history_file" > "$history_file.tmp"
      printf "%s\t%s" "$media_id" "$stopped_at" >> "$history_file.tmp"
      mv "$history_file.tmp" "$history_file"
      notify-send -t 5000 "Stopped at: $stopped_at%"
    fi
}

case "$choice" in
  "Watch")
    get_anime_from_list "CURRENT"
    [ -z "$anime_title" ] && exit 0
    notify-send -t 1000 "Loading $anime_title..."
    watch_anime
    ;;
  "Update")
    update_choice=$(printf "Change Episodes Watched\nChange Status\nChange Score"|$launcher)
    case "$update_choice" in
      "Change Episodes Watched") update_episode_from_list ;;
      "Change Status") update_status ;;
      "Change Score") update_score ;;
    esac
    ;;
  "Info") 
    search_anime
    anime_info="$(curl -s -X POST "https://graphql.anilist.co" \
      -H 'Content-Type: application/json' \
      -H 'Authorization: Bearer '"$access_token"'' \
      -d "{\"query\":\"query media(\$id:Int,\$type:MediaType,\$isAdult:Boolean){Media(id:\$id,type:\$type,isAdult:\$isAdult){id title{userPreferred romaji english native}coverImage{extraLarge large}bannerImage startDate{year month day}endDate{year month day}description season seasonYear type format status(version:2)episodes duration chapters volumes genres synonyms source(version:3)isAdult isLocked meanScore averageScore popularity favourites isFavouriteBlocked hashtag countryOfOrigin isLicensed isFavourite isRecommendationBlocked isFavouriteBlocked isReviewBlocked nextAiringEpisode{airingAt timeUntilAiring episode}relations{edges{id relationType(version:2)node{id title{userPreferred}format type status(version:2)bannerImage coverImage{large}}}}characterPreview:characters(perPage:6,sort:[ROLE,RELEVANCE,ID]){edges{id role name voiceActors(language:JAPANESE,sort:[RELEVANCE,ID]){id name{userPreferred}language:languageV2 image{large}}node{id name{userPreferred}image{large}}}}staffPreview:staff(perPage:8,sort:[RELEVANCE,ID]){edges{id role node{id name{userPreferred}language:languageV2 image{large}}}}studios{edges{isMain node{id name}}}reviewPreview:reviews(perPage:2,sort:[RATING_DESC,ID]){pageInfo{total}nodes{id summary rating ratingAmount user{id name avatar{large}}}}recommendations(perPage:7,sort:[RATING_DESC,ID]){pageInfo{total}nodes{id rating userRating mediaRecommendation{id title{userPreferred}format type status(version:2)bannerImage coverImage{large}}user{id name avatar{large}}}}externalLinks{id site url type language color icon notes isDisabled}streamingEpisodes{site title thumbnail url}trailer{id site}rankings{id rank type format year season allTime context}tags{id name description rank isMediaSpoiler isGeneralSpoiler userId}mediaListEntry{id status score}stats{statusDistribution{status amount}scoreDistribution{score amount}}}}\",\"variables\":{\"id\":$media_id,\"type\":\"ANIME\"}}"|
      tr '{|}' '\n'|sed -nE "s@.*\"description\":\"(.*)\",\"season\".*@\1@p"|sed "s@\\\@@g")"
    notify-send "$anime_info" -t 10000
    ;;
  "Watch New")
    search_anime
    progress="0"
    notify-send -t 1000 "You need to finish the first episode before you can update your progress"
    watch_anime
    ;;
esac
