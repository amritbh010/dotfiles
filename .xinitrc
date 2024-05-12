#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

#while true; do
#        clock="$(sh ~/.local/bin/clock)"
#       volume="$(sh ~/.local/bin/volume)"
#        battery="$(sh ~/.local/bin/battery)"
#
#xsetroot -name "$clock | $volume | $battery"
#sleep 0
#done &


while true; do
                volume=$(amixer get Master | grep -oE '[0-9]{1,3}?%' | head -n1)
                time="$(date +"%I:%M %p")"
                dte="$(date +"%a, %B %d")"
                battery=$(cat /sys/class/power_supply/BAT0/capacity)
                xsetroot -name "[ 📅 $dte ][ 🧭 $time ][ 📢 $volume ][ 💀 $battery% ]"
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
picom &
/home/void/.local/bin/newlook &
wal -i /home/void/Downloads/1.jpg &
feh --bg-fill /home/void/Downloads/1.jpg &
exec dwm
