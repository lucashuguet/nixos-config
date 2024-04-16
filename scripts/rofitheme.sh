#!/usr/bin/env bash

file=$(find ~/Pictures/wallpapers/ -name '*.png' -exec basename {} \; | sed "s/.png\$//g" | rofi -dmenu)

if [ $? == 1 ]; then	
  exit 0
fi

wal -qntes -i ~/Pictures/wallpapers/$file.png

source ~/.cache/wal/colors.sh

swww img $wallpaper -t none

black=$color0
red=$color1
green=$color2
yellow=$color3
blue=$color4
magenta=$color5
cyan=$color6
white=$color7

lblack=$color8
lred=$(getlightcolor $red)
lgreen=$(getlightcolor $green)
lyellow=$(getlightcolor $yellow)
lblue=$(getlightcolor $blue)
lmagenta=$(getlightcolor $magenta)
lcyan=$(getlightcolor $cyan)
lwhite=$(getlightcolor $white)

lforeground=$white
lbackground=$color2

colors_path=~/.config/colors

alacritty=$colors_path/alacritty.toml
qutebrowser=$colors_path/qutebrowser.yml
rofi=$colors_path/rofi.rasi
hyprland=$colors_path/hyprland.conf
waybar=$colors_path/waybar.css
dunst=$colors_path/dunst.toml

dunstc=~/.config/dunst/config.toml
dunstrc=~/.config/dunst/dunstrc

rm $alacritty
echo "[colors.primary]" | tee -a $alacritty
echo "background = '$background'" | tee -a $alacritty
echo "foreground = '$foreground'" | tee -a $alacritty
echo "[colors.normal]" | tee -a $alacritty
echo "black = '$black'" | tee -a $alacritty
echo "red = '$red'" | tee -a $alacritty
echo "green = '$green'" | tee -a $alacritty
echo "yellow = '$yellow'" | tee -a $alacritty
echo "blue = '$blue'" | tee -a $alacritty
echo "magenta = '$magenta'" | tee -a $alacritty
echo "cyan = '$cyan'" | tee -a $alacritty
echo "white = '$white'" | tee -a $alacritty
echo "[colors.bright]" | tee -a $alacritty
echo "black = '$lblack'" | tee -a $alacritty
echo "red = '$lred'" | tee -a $alacritty
echo "green = '$lgreen'" | tee -a $alacritty
echo "yellow = '$lyellow'" | tee -a $alacritty
echo "blue = '$lblue'" | tee -a $alacritty
echo "magenta = '$lmagenta'" | tee -a $alacritty
echo "cyan = '$lcyan'" | tee -a $alacritty
echo "white = '$lwhite'" | tee -a $alacritty

rm $qutebrowser
echo "colors:" | tee -a $qutebrowser
echo "  primary:" | tee -a $qutebrowser
echo "    background: '$background'" | tee -a $qutebrowser
echo "    foreground: '$foreground'" | tee -a $qutebrowser
echo "  normal:" | tee -a $qutebrowser
echo "    black: '$black'" | tee -a $qutebrowser
echo "    red: '$red'" | tee -a $qutebrowser
echo "    green: '$green'" | tee -a $qutebrowser
echo "    yellow: '$yellow'" | tee -a $qutebrowser
echo "    blue: '$blue'" | tee -a $qutebrowser
echo "    magenta: '$magenta'" | tee -a $qutebrowser
echo "    cyan: '$cyan'" | tee -a $qutebrowser
echo "    white: '$white'" | tee -a $qutebrowser
echo "  bright:" | tee -a $qutebrowser
echo "    black: '$lblack'" | tee -a $qutebrowser
echo "    red: '$lred'" | tee -a $qutebrowser
echo "    green: '$lgreen'" | tee -a $qutebrowser
echo "    yellow: '$lyellow'" | tee -a $qutebrowser
echo "    blue: '$lblue'" | tee -a $qutebrowser
echo "    magenta: '$lmagenta'" | tee -a $qutebrowser
echo "    cyan: '$lcyan'" | tee -a $qutebrowser
echo "    white: '$lwhite'" | tee -a $qutebrowser

rm $rofi
echo "* {" | tee -a $rofi
echo "    red: $(getrgba.py $red);" | tee -a $rofi
echo "    blue: $(getrgba.py $blue);" | tee -a $rofi
echo "    foreground: $(getrgba.py $foreground);" | tee -a $rofi
echo "    background: $(getrgba.py $background);" | tee -a $rofi
echo "    lightfg: $(getrgba.py $lbackground);" | tee -a $rofi
echo "    lightbg: $(getrgba.py $background);" | tee -a $rofi
echo "}" | tee -a $rofi

rm $hyprland
echo "general {" | tee -a $hyprland
echo "    col.active_border = rgba(${lforeground:1}ee)" | tee -a $hyprland
echo "    col.inactive_border = rgba(${lbackground:1}ee)" | tee -a $hyprland
echo "}" | tee -a $hyprland
echo "decoration {" | tee -a $hyprland
echo "    col.shadow = rgba(${background:1}ee)" | tee -a $hyprland
echo "}" | tee -a $hyprland

rm $waybar
echo "@define-color foreground $foreground;" | tee -a $waybar
echo "@define-color background $background;" | tee -a $waybar
echo "@define-color red $red;" | tee -a $waybar
echo "@define-color green $green;" | tee -a $waybar
echo "@define-color yellow $yellow;" | tee -a $waybar
echo "@define-color blue $blue;" | tee -a $waybar
echo "@define-color magenta $magenta;" | tee -a $waybar
echo "@define-color cyan $cyan;" | tee -a $waybar
echo "@define-color white $white;" | tee -a $waybar
echo "@define-color lblack $lblack;" | tee -a $waybar

rm $dunst
echo "[global]" | tee -a $dunst
echo "    frame_color = \"$lforeground\"" | tee -a $dunst
echo "[urgency_normal]" | tee -a $dunst
echo "    background = \"$background\"" | tee -a $dunst
echo "    foreground = \"$foreground\"" | tee -a $dunst

rm $dunstrc
cat $dunst | tee -a $dunstrc
cat $dunstc | tee -a $dunstrc

pkill waybar
pkill dunst

waybar &
dunst &
