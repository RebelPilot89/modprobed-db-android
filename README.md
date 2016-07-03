#Modprobed-db
Modprobed-db will keep a running list of ALL modules ever probed on a system and allow for easy recall on demand. This is very useful for users wishing to build a minimal kernel via the make localmodconfig script which simply takes every module currently probed and switches everything BUT them off in the .config for a kernel resulting in smaller kernel packages and reduced compilation times.

SETUP

    $ make
Running a `make install` as root will distribute the files to the filesystem.

    # make install

Edit $HOME/.config/modprobed-db.conf and select a path where the database will reside (default is $HOME/.config)
and optionally add some modules you wish to ignore to the ignore array. Some common ones are included in the PKG by default.

USAGE

The most convenient method to use the script is to simply add an entry your user's crontab to invoke
/usr/bin/modprobed-db store at some regular interval.

Example running the script once every 20 minutes:

	$ crontab -e
	*/20 * * * *   /usr/bin/modprobed-db store &> /dev/null

Systemd users not wishing to use cron may use the included user modprobed-db.service which will run modprobed-db in store
mode once per hour, and at boot and on shutdown. Invoke it like so:

	$ systemctl --user enable modprobed-db.service
	$ systemctl --user start modprobed-db.service

Status of the service and of the timer can be queried like any service and timer:

	$ systemctl --user status modprobed-db
	$ systemctl --user list-timers

DATA RECALL

After the module database has been adequately populated, simply invoke /usr/bin/modprobed-db recall prior to compiling a kernel to load all modules followed by the make localmodconfig to do the magic.

#Links
AUR Package: https://aur.archlinux.org/packages/modprobed-db
