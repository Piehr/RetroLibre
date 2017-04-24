# RetroLibre
Needed configuration files to deploy a full video/gaming streaming machine on LibreElec 8 Community Build.
!!New!! Transmission daemon now configurable with standard configuration.

Based on:
- LibreElec 8 Community Build: https://github.com/escalade/LibreELEC.tv
- Internet Archive ROM Launcher : https://github.com/zach-morris/plugin.program.iarl

Updating from your actual RetroLibre:

For now, the package is only proposing to replace your BIOS roms and dat_files by the Master ones, creating backup in /storage/backup/. :)

To proceed :
Get the last package:
- wget https://codeload.github.com/Piehr/RetroLibre/zip/master
- unzip master
- cd RetroLibre-master/
- ./update.sh
