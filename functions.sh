#!/usr/bin/env zsh
# shell functins to source into my laptop environment to interact with my server

alias v='vultr'
alias vultr='ssh vultr'
alias vlogs='vultr "~/vps/logs"'
alias vultr_logs='vultr "~/vps/logs"'
alias remsync-public='REMSYNC_PUBLIC=1 remsync' # to push to /p/ (public index)
# to use ranger to quickly remove/add files
alias remsync-ranger='ranger "${HOME}/Files/remsync" && remsync'
alias remsync-public-ranger='ranger "${HOME}/Files/remsync_public" && remsync-public'
alias print-new-comments='approve_comments --print-new-comments'
alias page-hits="curl -s 'https://sean.fish/api/page_hit' | jq '.count'"
alias gb-comments="curl 'https://sean.fish/api/gb_comment' | jq 'reverse'"
gb-comments-pretty() {
	gb-comments |
		jq '.[]' -c |
		localize-datetimes -k at |
		jq '"# \(.name)\n```\n\(.comment)\n```\n\(.at)"' -r |
		glow -
}
# print/select open shortened urls
# https://github.com/seanbreckenridge/no-db-shorturl
alias shorturls="ssh vultr 'ls shorturls'"
alias shz="shorturls | fzf | sed -e 's|^|https://sean.fish/s/|' | tee /dev/tty | clipcopy"
remsync-html-from-stdin() {
	local tmpf
	# https://sean.fish/d/pipehtml?redirect
	tmpf="$(pipehtml "$*")"
	remsync "$tmpf"
	rm -f "$tmpf"
}
remsync-text-from-stdin() {
	text2html | html-head-all | remsync-html-from-stdin "$*"
}

__deploy() {
	local targets
	# call 'deploy compdef' to generate completion
	targets="$(VPS_DEPLOY_COMPDEF=1 deploy)"
	_arguments "1:targets:(${targets})"
}

compdef __deploy deploy
