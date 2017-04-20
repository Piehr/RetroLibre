#!/bin/bash
BACKUPDIR="/storage/backup/preinstall/"
DATFILESBACKUPDIR="dat_files/"
DATFILESDIR="/storage/.kodi/userdata/addon_data/plugin.program.iarl/dat_files/"
echo "!!!WARNING!!!
You're about to install our up-to-date Git Package (https://github.com/Piehr/RetroLibre) on this computer, updating its content on your system."
while true; do
	read -p "ARE YOU OK TO PROCEED?[y/n]" yn
	case $yn in
	[Yy]* ) 
		if [ -d "$BACKUPDIR" ]; then
			echo "Stage 0 - cleaning $BACKUPDIR location..."
			rm -rf $BACKUPDIR &&
			wait
			echo "cleaning done"

		fi

		#backing-up dat files 
		echo -n "Backing up your dat_files..."
		if [ ! -d "$DATFILESDIR" ]; then 
			echo" "
			echo "ERROR: $DATFILESDIR NOT FOUND";
			exit; 
		fi
		mkdir $BACKUPDIR && 
		mkdir $BACKUPDIR$DATFILESBACKUPDIR &&
		cp -rf $DATFILESDIR $BACKUPDIR$DATFILESBACKUPDIR &&
		wait
		echo "done";
		break;;
	[Nn]* ) echo "See you Space Cowboy...";exit;;
	 * ) echo "Please answer yes or no.";;
	esac
done
