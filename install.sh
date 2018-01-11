#!/data/data/com.termux/files/usr/bin/bash
echo -n "checking mpv package... "
if mpv --version | grep -q "mpv/MPlayer/mplayer2"; then
	echo "ok"
else
	echo "err"
	echo "installing mpv... "
	apt install --force-yes mpv
	if mpv --version | grep -q "mpv/MPlayer/mplayer2"; then
		echo "mpv installed... "
	else
		echo "can't install mpv... exit"
		exit
	fi
fi
_path=$(echo $PATH | cut -d ":" -f 1)
echo "$ cp music.sh $_path/muxsic"
cp muxsic.sh $_path/muxsic
echo "$ chmod +x $_path/muxsic"
chmod +x $_path/muxsic
echo "$ termux-fix-shebang $_path/muxsic"
termux-fix-shebang $_path/muxsic
echo "> muxsic installed..."
echo "> type \"muxsic\" and enter to run..."
