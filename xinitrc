#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# so all binaries are visible in dmenu_run
export PATH="$PATH:$HOME/.i3/bin:$HOME/.bin:$HOME/bin"

# use xresources
xrdb -merge ~/.i3/xresources

# multiple screen setup
[ -e ~/.screen_setup ] && source ~/.screen_setup

# background
[ -e ~/.fehbg ] && source ~/.fehbg

# pulse audio session
#start-pulseaudio-x11

# keyboard layout
xmodmap ~/.i3/xmodmap
[ -e ~/.xmodmap_local ] && xmodmap ~/.xmodmap_local

# color temperature adjustment, set for Gdańsk
redshift -l 54.35:18.65 -m randr -t 5500:4500 -g 0.75:0.75:0.75 &

# notification
dunst -config ~/.i3/dunstrc &

# terminal server
urxvtd &

# gpg agent
export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
gpg-connect-agent updatestartuptty /bye

# composition manager
compton --config ~/.i3/compton.conf &

# Network Manager applet
>> /dev/null which nm-applet && nm-applet &
>> /dev/null which blueman--applet && blueman-applet &

xcape

i3

true
