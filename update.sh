#!/bin/bash
_now=$(date +"%m_%d_%Y_%H_%M_%S")
BACKUPDIR="/storage/backup/"$_now"/"
DATFILESBACKUPDIR="dat_files/"
DATFILESMASTERDIR="dat_files/"
DATFILESDIR="/storage/.kodi/userdata/addon_data/plugin.program.iarl/dat_files/"
BIOSDIR="/storage/roms/bios/"
echo "!!!WARNING!!!
You're about to install our up-to-date Git Package (https://github.com/Piehr/RetroLibre) on this computer, updating its content on your system."
while true; do
	read -p "ARE YOU OK TO PROCEED?[y/n]" yn
	case $yn in
	[Yy]* ) 
		if [ -d "$BACKUPDIR" ]; then
			echo -n "Cleaning $BACKUPDIR location... "
			rm -rf $BACKUPDIR &&
			wait
			echo "done";

		fi
		
		mkdir $BACKUPDIR && wait


		while true; do
			        read -p "Do you want to replace your dat_files by the Master ones?[y/n]" yn
				case $yn in
				[Yy]* )
					#backing-up dat files 
					echo -n "Backing up your dat_files... "
					if [ ! -d "$DATFILESDIR" ]; then 
						echo "ERROR: $DATFILESDIR NOT FOUND";
					exit; 
					fi
					mkdir $BACKUPDIR$DATFILESBACKUPDIR &&
					cp -rf $DATFILESDIR* $BACKUPDIR$DATFILESBACKUPDIR &&
					wait
					echo "done. Your old dat_files are located in $BACKUPDIR$DATFILESBACKUPDIR";
					echo -n "Copying Master dat_files... "
					rm -rf $DATFILESDIR* &&
					cp -rf ${PWD}/$DATFILESMASTERDIR* $DATFILESDIR &&
				       	wait
					echo "done"; 	
				break;;
				[Nn]* )
					echo "Your dat_files have not been updated."
					
				break;;
				 * ) echo "Please answer yes or no.";;
			 	esac
		done
		
		
		echo "Update process complete. Enjoy!"
		exit
		break;;
	[Nn]* ) echo "See you Space Cowboy...";exit;;
	 * ) echo "Please answer yes or no.";;
	esac
done
