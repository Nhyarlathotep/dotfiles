#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""

pgrep -x redshift &> /dev/null
if [[ $? -eq 0 ]]; then
    #temp=$(redshift -p 2>/dev/null | grep temp | cut -d' ' -f3)#us
    temp=$(redshift -p 2>/dev/null | grep Temp | cut -d' ' -f4)
    temp=${temp//K/}
fi

#OPTIONAL: Append ' ${temp}K' after $icon
if [[ -z $temp ]]; then
    echo "%{u#D08770 +u} %{F#65737E}$icon%{F-} %{u-}"       # Greyed out (not running)
elif [[ $temp -ge 5000 ]]; then
    echo "%{u#D08770 +u} %{F#8FA1B3}$icon%{F-} %{u-}"       # Blue
elif [[ $temp -ge 4000 ]]; then
    echo "%{u#D08770 +u} %{F#EBCB8B}$icon%{F-} %{u-}"       # Yellow
else
    echo "%{u#D08770 +u} %{F#D08770}$icon%{F-} %{u-}"       # Orange
fi
