#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# statusbar loop

while true; do

	xsetroot -name "$( date +"%F %R" ) | $(cat /sys/class/power_supply/BAT0/capacity)%"
	sleep 1m    # update every minute
done &

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


sxhkd &
setsid xcompmgr &
#~/.local/bin/newlook &
xdotool &
wal -i /home/void/Downloads/wallpaperflare.com_wallpaper.jpg &
feh --bg-fill /home/void/Downloads/wallpaperflare.com_wallpaper.jpg &
exec dwm

