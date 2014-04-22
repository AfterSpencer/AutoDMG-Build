AutoDMG-Build
=============

Build script for AutoDMG templates


This script it meant to work with [AutoDMG](https://github.com/MagerValp/AutoDMG) to build Mac images for Deployment.

The script is intended to be used with templates and existing images. The image feature only works with AutoDMG 1.14, which as of this writing is still in beta.

AutoDMG templates are plist files which can be nested. Creation of templates is documented in the AutoDMG wiki [here](https://github.com/MagerValp/AutoDMG/wiki/Templates).

Though it may not be strictly required, there is a portion of the script that repairs permissions on the disk. If this is not desired comment out or remove the section starting at line 23 and ending at line 47. 

---

Future versions will better standardize locations for variables such as template and log locations to be changed by people who are not me.
