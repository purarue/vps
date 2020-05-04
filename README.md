# vps

Scripts used for installing/managing/restarting/monitoring processes on my server (and my server).

Uses [supervisord](http://supervisord.org/) to manage processes.

[My fork of superhooks](https://github.com/seanbreckenridge/superhooks) notifies me in discord whenever one of my processes dies, as does [netdata](https://www.netdata.cloud/) if there are any outliers in the hundreds of metrics it takes.

* Puts application code into `~/code`
* Centralizes logs in `~/logs`

This runs on an Debian server, but it should be OS agnostic. `vps_install` will throw a fatal error before starting if I'm missing any required commands. My server runs `nginx`, lots of the log based commands assume that.

* [`vps_install`](./vps_install) clones and sets up environments for each application. Checks that you have corresponding commands/packages installed and that required credential/files are in the right location, installs virtual environments/packages for each application.
* [`super`](./super) lets me interact with the underlying `supervisord`/`supervisorctl` processes with my environment variables/configuration.
* [`logs`](./logs) streams the logs from all applications
* [`glogs`](./glogs) uses [goaccess](https://goaccess.io/) to visualize nginx logs. `glogs html` generates a html summary, putting output at `~/.goaccess_html/index.html`, which is served with an nginx `alias`. Password protection for that route created in `vps_install`. That filters out any IPs already in `/etc/nginx/blacklist.conf`
* [`backup`](./backup) copies cache/token files to a tar.gz so they can be backed up. [run every few hours w/ cron](https://gist.github.com/seanbreckenridge/191556c41f0ebd86e7dbec8a8e929fbf)
* [`generate_static_sites`](./generate_static_sites) builds my static websites and places them in `/var/www/html`.
* [`remsync`](./remsync) is a script thats run on my machine, which rsyncs files from a local directory to the server. That directory is served with nginx, so I can sync something to the server from my CLI and send someone a link. [example output](https://gist.github.com/seanbreckenridge/2b11729859d248069a0eabf2e91e2800).
* [`directories`](./directories) is a helper script sourced at the top of other scripts that defines common application location environment variables

### Applications:

- https://github.com/seanbreckenridge/glue
- https://github.com/seanbreckenridge/mal-id-cache
- https://github.com/seanbreckenridge/mal-notify-bot
- https://github.com/seanbreckenridge/discord-countdown-bot
- https://github.com/seanbreckenridge/mal-unapproved
- https://github.com/seanbreckenridge/docker-jikan
- https://github.com/seanbreckenridge/wca_userinfo
- [github.com/seanbreckenridge/albums](https://github.com/seanbreckenridge/albums) (server)
- https://github.com/seanbreckenridge/xqc-dvd
- https://github.com/seanbreckenridge/xkcd-favorites
- https://github.com/seanbreckenridge/animeshorts
