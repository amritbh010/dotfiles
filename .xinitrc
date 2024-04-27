#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap



##################################################################################################################

while true; do
# Get current date and time
current_time=$(date +"%F %R")

# Get battery percentagebattery_percentage
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Fetch memory information
memory_info=$(free -m)

# Check if memory_info is empty or contains unexpected data
if [ -z "$memory_info" ] || ! echo "$memory_info" | grep -q "Mem:"; then
        memory_usage="N/A"
else
        # Extract total and used memory from memory_info
        total_memory=$(echo "$memory_info" | awk 'NR==2{print $2}')
        used_memory=$(echo "$memory_info" | awk 'NR==2{print $3}')

        # Calculate memory usage percentage
        if [ "$total_memory" -ne 0 ]; then
                memory_usage=$((used_memory * 100 / total_memory))
        else
                memory_usage="N/A"
        fi
fi

        # Update the status bar with time, memory usage, and battery percentage
xsetroot -name "$current_time | Memory : $memory_usage% | $battery_percentage%"

# Sleep for 5 seconds before updating again
sleep 5
done &


##################################################################################################################

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

##################################################################################################################

/home/void/.local/bin/newlook &
sxhkd &
wal -i /home/void/Downloads/wallpaperflare.com_wallpaper.jpg &
setsid xcompmgr &
feh --bg-fill /home/void/Downloads/wallpaperflare.com_wallpaper.jpg &
exec dwm


##################################################################################################################

