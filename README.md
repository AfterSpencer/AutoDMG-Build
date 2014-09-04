AutoDMG-Build
=============

Build script for AutoDMG templates


This script it meant to work with [AutoDMG](https://github.com/MagerValp/AutoDMG) to build Mac images for Deployment.

The script is intended to be used with templates and existing images. The image feature only works with AutoDMG 1.14, which as of this writing is still in beta.

AutoDMG templates are plist files which can be nested. Creation of templates is documented in the AutoDMG wiki [here](https://github.com/MagerValp/AutoDMG/wiki/Templates).

Though it may not be strictly required, there is a portion of the script that repairs permissions on the disk. If this is not desired comment out or remove the section starting at line 27 and ending at line 50. 

AutoDMG doesn't like to apply updates when running as root. It stores the updates under ~/Library/Application Support/AutoDMG/ and will not download them from the command line. To deal with this open the GUI on occasion and have it download the updates. This script will sync the updates to /var/root/Library/Application Support/AutoDMG. If this is how the script will be used line 5 will need to be updated with the home folder of the GUI user. Alternatively, use sudo -s instead of sudo su, though updates will still need to be downloaded from the GUI.


