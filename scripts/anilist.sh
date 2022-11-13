#!/bin/sh

token=$(cat ~/.config/jerry/anilist_token.txt)

content=$(curl -s 'https://graphql.anilist.co' \
  -X POST -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:106.0) Gecko/20100101 Firefox/106.0' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $token" \
  -d '{"query":"query($isFollowing:Boolean = true,$hasReplies:Boolean = false,$activityType:ActivityType,$page:Int){Page(page:$page,perPage:25){pageInfo{total perPage currentPage lastPage hasNextPage}activities(isFollowing:$isFollowing type:$activityType hasRepliesOrTypeText:$hasReplies type_in:[TEXT,ANIME_LIST,MANGA_LIST]sort:ID_DESC){... on TextActivity{id userId type replyCount text isLocked isSubscribed isLiked likeCount createdAt user{id name donatorTier donatorBadge moderatorRoles avatar{large}}}... on ListActivity{id userId type status progress replyCount isLocked isSubscribed isLiked likeCount createdAt user{id name donatorTier donatorBadge avatar{large}}media{id type status isAdult title{userPreferred}bannerImage coverImage{large}}}}}}","variables":{"page":1,"type":"following","filter":"all"}}'|
  jq -r '.data[].activities[] | "\(.user.name) \(.status) \(.progress) \(.media.title.userPreferred)"'|sed -e 's/ null//g')

echo "$content"|bat

