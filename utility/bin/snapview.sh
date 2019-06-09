#!/bin/sh
# conf font for dmenu output
set -e
font=$(echo "Monospace-12:normal")
# select and store a chosen config from a dmenu list
config=$(snapper list-configs | awk 'FNR>2{print $1}' | dmenu -l 20 -b -y 14 -fn $font)
# select and store a chosen snapshot id from snapshot list
backupinfo=$(snapper -c $config list | dmenu -l 20 -b -y 17 -p "snapshots for $config" -fn $font)
backupid=$(echo $backupinfo | awk '{print $1}')
filepath=$(echo $(snapper -c $config status 0..$backupid | grep -v -i Cache | grep -v -i logs | dmenu -l 20 -b -y 17 -fn $font | awk '{print $2}'))
choice=$(echo $(echo -e "view\ndiff\nreplace" | dmenu -l 20 -b -y 17 -fn $font -p "$filepath"))

case "$choice" in
	view)
		;;
	diff)
		files=$(snapper -c $config diff --diff-cmd diff -x -y  0..$backupid $filepath)
		#echo $files | dmenu -l 20 -b -y 17 -fn $font
		echo "$files" > $HOME/.diflogs.txt
		echo "Col 1: current	Col 2: backup" >> $HOME/.diflogs.txt
		st sh -c 'cat $HOME/.diflogs.txt; sh'
		;;
	*)
		exit 1
esac

#dunstify -a "$config" "'$files'"

