#!/bin/env bash

prelock() {
        pkill -u "$USER" -USR1 dunst
}

lock() {
        #$1 image path
        letterEnteredColor=d23c3dff
        letterRemovedColor=d23c3dff
        passwordCorrect=00000000
        passwordIncorrect=d23c3dff
        background=00000000
        foreground=ffffffff
        i3lock \
                -t -n -i "$1" \
                --timepos="x-90:h-ch+30" \
                --datepos="tx+24:ty+25" \
                --clock --datestr "Type password to unlock..." \
                --insidecolor=$background --ringcolor=$foreground --line-uses-inside \
                --keyhlcolor=$letterEnteredColor --bshlcolor=$letterRemovedColor --separatorcolor=$background \
                --insidevercolor=$passwordCorrect --insidewrongcolor=$passwordIncorrect \
                --ringvercolor=$foreground --ringwrongcolor=$foreground --indpos="x+280:h-70" \
                --radius=20 --ring-width=4 --veriftext="" --wrongtext="" \
                --textcolor="$foreground" --timecolor="$foreground" --datecolor="$foreground" \
                --force-clock
}

postlock() {
        pkill -u "$USER" -USR2 dunst
}

img=/tmp/screenlock.png

scrot -z $img
convert $img -level 0%,100% \
	-filter Gaussian \
        -resize 20% \
        -define filter:sigma=0.8 \
	-resize 500% \
	$img

#	 ~/.config/polybar/doge.png -gravity center -composite \
#        -font "Noto-Sans" -pointsize 40 -gravity center \

prelock
lock $img
postlock
