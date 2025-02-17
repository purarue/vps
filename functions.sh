#!/usr/bin/env zsh
# shell functions to source into my laptop environment to interact with my server

alias vultr='retry ssh vultr'
alias vlogs='vultr "~/vps/logs"'
alias vultr_logs='vultr "~/vps/logs"'
alias remsync-public='REMSYNC_PUBLIC=1 remsync' # to push to /p/ (public index)
# to use ranger to quickly remove/add files
alias remsync-ranger='ranger "${XDG_DOCUMENTS_DIR}/remsync" && remsync'
alias remsync-public-ranger='ranger "${HOME}/Files/remsync_public" && remsync-public'
alias print-new-comments='approve-comments --print-new-comments'
alias page-hits="curl -s 'https://purarue.xyz/api/page_hit' | jq '.count'"
alias gb-comments="curl 'https://purarue.xyz/api/gb_comment' | jq 'reverse'"
gb-comments-pretty() {
	gb-comments |
		jq '.[]' -c |
		localize-datetimes -k at |
		jq '"# \(.name)\n```\n\(.comment)\n```\n\(.at)"' -r |
		glow -
}
# print/select open shortened urls
# https://github.com/purarue/no-db-shorturl
alias shorturls="ssh vultr 'ls shorturls'"
alias shz="shorturls | fzf | sed -e 's|^|https://purarue.xyz/s/|' | tee /dev/tty | clipcopy"
remsync-html-from-stdin() {
	local tmpf
	# https://purarue.xyz/d/pipehtml?redirect
	tmpf="$(pipehtml "$*")"
	remsync "$tmpf"
	rm -f "$tmpf"
}
remsync-text-from-stdin() {
	text2html | html-head-all | remsync-html-from-stdin "$*"
}
alias sy='vps_sync_ttally'

__deploy() {
	local targets
	# call 'deploy compdef' to generate completion
	targets="$(VPS_DEPLOY_COMPDEF=1 deploy)"
	_arguments "1:targets:(${targets})"
}

compdef __deploy deploy
