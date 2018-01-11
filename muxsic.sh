#!/data/data/com.termux/files/usr/bin/bash
# MuxSic [ Termux Music ]
# Version: 1.0-beta
# Author: Bagaz Mukti
# Github: github.com/BagazMukti/
# Website: bagaz.org
# Contact: me@bl33dz.me

trap '' 2
export DIR="$HOME/Music"

echo -e " _  _  _  _  _  _      ____  __  ___
( \/ )/ )( \( \/ )___ / ___)(  )/ __)
/ \/ \) \/ ( )  ((___)\___ \ )(( (__
\_)(_/\____/(_/\_)    (____/(__)\___)
[ Termux Music ~ v1.0-beta ]\n"

loop=true

while $loop; do
	read -p "muxsic> " cmd
	if [ "$cmd" = "help" ]; then
		echo -e "List of commands:
> list           show playlist
> play <number>  play music
> play all       play all music on playlist
> chdir          change playlist directory (current: $DIR)
> help           show this help
> exit           exit from this program\n"
	elif [ "$cmd" = "list" ]; then
		getlist=$(ls $DIR | grep mp3)
		replace=${getlist// /%%}
		n=1
		for music in $replace; do
			echo "[$n] ${music//%%/ }"
			((n++))
		done
		echo
	elif echo "$cmd" | grep -q "play"; then
		arg=$(echo "$cmd" | cut -d " " -f 2)
		if [ "$arg" = "all" ]; then
			mpv --playlist="$DIR" --loop-playlist
		else
			getlist=$(ls $DIR | grep mp3)
			replace=${getlist// /%%}
			list=()
			for m in $replace; do
				list+=("$m")
			done
			music=${list[(($arg-1))]}
			mpv "$DIR/${music//%%/ }"
		fi
		echo
	elif echo "$cmd" | grep -q "chdir"; then
		export DIR="$(echo "$cmd" | cut -d " " -f 2)"
		echo "Directory changed!"
		echo
	elif [ "$cmd" = "exit" ]; then
		loop=false
	else
		echo "W000t?? please type \"help\""
	fi
done
