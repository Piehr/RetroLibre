#!/bin/bash
_now=$(date +"%m_%d_%Y_%H_%M_%S")
BACKUPDIR="/storage/backup/"$_now"/"
DATFILESBACKUPDIR="dat_files/"
DATFILESMASTERDIR="dat_files/"
DATFILESDIR="/storage/.kodi/userdata/addon_data/plugin.program.iarl/dat_files/"

BIOSBACKUPDIR="bios/"
BIOSMASTERDIR="roms/bios/"

BIOSDIR="/storage/roms/bios/"

CONFMASTERDIR="conf/"

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

		check_arch=$(uname -m);
		
		
		case $check_arch in
			"x86_64" )
			dat_files_conf=${PWD}/$CONFMASTERDIR"x86_update_config.conf";;
			* )
			dat_files_conf=${PWD}/$CONFMASTERDIR"pi_update_config.conf";;
		esac
		
		echo "Architecture: $check_arch - $dat_files_conf will be used.";
		
		

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
					mkdir $BACKUPDIR$DATFILESBACKUPDIR && cp -rf $DATFILESDIR* $BACKUPDIR$DATFILESBACKUPDIR &&
					wait
					
					
					
					cp -rf $DATFILESDIR* $BACKUPDIR$DATFILESBACKUPDIR &&
					wait 
					echo "Done. Your old dat_files are located in $BACKUPDIR$DATFILESBACKUPDIR";
					echo "Copying Master dat_files... "
					
					
					rm -rf $DATFILESDIR* && wait
					
					
					#Read Master dat_files and check the config file for inclusion
					for f in ${PWD}/$DATFILESMASTERDIR*; do
						wfile=`basename "$f"`;
						#search in the config file
						current_dat_file="";
						while read line; do
							current_dat_file=$line;
							test_file=${current_dat_file%	*}
							
							if [[ "$wfile" == "$test_file" ]]; then
								break;
							fi				
						done < $dat_files_conf;
						
							if [ ! -z "$current_dat_file" ]; then
								dat_check=${current_dat_file#*	}
								
								if [ $dat_check -eq 1 ]; then
									echo -n "Copy of $wfile... ";
									cp -rf ${PWD}/$DATFILESMASTERDIR"$wfile" $DATFILESDIR && wait
									echo "done.";
								else
									echo "Copy of $wfile skipped (Disabled in conf file)";
									
								fi
							fi
					done 
					
					echo "dat_files successfully updated"; 	
				break;;
				[Nn]* )
					echo "Your dat_files have not been updated."
					
				break;;
				 * ) echo "Please answer yes or no.";;
			 	esac
		done
		
		while true; do
			        read -p "Do you want to replace your BIOS roms by the Master ones?[y/n]" yn
				case $yn in
				[Yy]* )
					#backing-up dat files 
					echo -n "Backing up your BIOS roms... "
					if [ ! -d "$BIOSDIR" ]; then 
						echo "ERROR: $BIOSDIR NOT FOUND";
					exit; 
					fi
					mkdir $BACKUPDIR$BIOSBACKUPDIR &&
					cp -rf $BIOSDIR* $BACKUPDIR$BIOSBACKUPDIR &&
					wait
					echo "done. Your old BIOS roms are located in $BACKUPDIR$BIOSBACKUPDIR";
					echo -n "Copying Master BIOS roms... "
					rm -rf $BIOSDIR* &&
					cp -rf ${PWD}/$BIOSMASTERDIR* $BIOSDIR &&
				       	wait
					echo "done"; 	
				break;;
				[Nn]* )
					echo "Your BIOS roms have not been updated."
					
				break;;
				 * ) echo "Please answer yes or no.";;
			 	esac
		done
		
		#Check if Transmission is running
		ps -ef | grep transmission | grep -v grep > /dev/null
		if [ $?  -eq "0" ]; then
			transmission_check=0;
		else
			transmission_check=1;
		fi
				
		if [ $transmission_check -eq 0 ]; then
			while true; do
			        read -p "Transmission Daemon is running - Do you want to disable it ? [y/n]" yn
				case $yn in
				[Yy]* )
					systemctl disable transmission.service && systemctl stop transmission && wait
					echo "Transmission Daemon disabled."
				break;;
				[Nn]* )
					echo "Transmission Daemon configuration skipped."
				break;;
				 * ) echo "Please answer yes or no.";;
			 	esac
			 done
				
		else
			while true; do
			        read -p "Transmission Daemon is not running. Do you want to install it? [y/n]" yn
				case $yn in
				[Yy]* )
					systemctl enable transmission.service && systemctl start transmission && wait
					echo "Transmission Daemon installed and running."
					echo "Download directory: /storage/downloads/";
					echo "For more settings, please check /storage/.config/transmission-daemon/settings.json";
				break;;
				[Nn]* )
					echo "Transmission Daemon configuration skipped."
					
				break;;
				 * ) echo "Please answer yes or no.";;
			 	esac
		done
		fi
		
		echo "Update process complete. Enjoy!"
		exit
		break;;
	[Nn]* ) echo "See you Space Cowboy...";exit;;
	 * ) echo "Please answer yes or no.";;
	esac
done
