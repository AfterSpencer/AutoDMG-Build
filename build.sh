#!/bin/sh

NO_ARGS=0 
E_OPTERROR=85
vflag=0
sflag=0
eflag=0
srflag=0
erflag=0

function imagebuild {

echo `date` "- Mavericks_"$image".hfs.dmg build started" >> /Users/user/Desktop/ImageBuilding/Logfile/images.log

time /Applications/AutoDMG.app/Contents/MacOS/AutoDMG -r -L 7 -l /Users/user/Desktop/ImageBuilding/Logfile/build.log build /Users/user/Desktop/ImageBuilding/AutoDMG\ Templates/Mavericks_"$image".plist 

if (($? == 0 )); then

echo `date` "- Mavericks_"$image".hfs.dmg build finished" >> /Users/user/Desktop/ImageBuilding/Logfile/images.log

echo `date` "- Mavericks_"$image".hfs.dmg permissions repair started" >> /Users/user/Desktop/ImageBuilding/Logfile/images.log

# Mount as writable
hdiutil attach -owners on /Users/user/Desktop/Images/Mavericks_Working.hfs.dmg -shadow

# Repair Permissions
diskutil repairpermissions /Volumes/Macintosh\ HD\ 1/

# Unmount drive
while [ -e /Volumes/Macintosh\ HD\ 1 ]
do
sleep 30
hdiutil eject /Volumes/Macintosh\ HD\ 1
done

# Combine images into one
hdiutil convert -format UDZO -o /Users/user/Desktop/Images/new.dmg /Users/user/Desktop/Images/Mavericks_Working.hfs.dmg -shadow

# Scan for restore
asr imagescan -source /Users/user/Desktop/Images/new.dmg

# Rename image file
mv /Users/user/Desktop/Images/new.dmg /Users/user/Desktop/Images/Mavericks_"$image".hfs.dmg

# Remove shadow file and old image
rm /Users/user/Desktop/Images/Mavericks_Working.hfs.dmg
rm /Users/user/Desktop/Images/Mavericks_Working.hfs.dmg.shadow

echo `date` "- Mavericks_"$image".hfs.dmg permissions repair finished" >> /Users/user/Desktop/ImageBuilding/Logfile/images.log

else

echo `date` "- Mavericks_"$image".hfs.dmg build failed" >> /Users/user/Desktop/ImageBuilding/Logfile/images.log

exit 1

fi

}

function buildvanilla {
if [ $vflag == 0 ]
then
image=Vanilla
imagebuild
vflag=1
fi
}

function buildsec {
if [ $sflag == 0 ]
then
image=Sec
imagebuild
sflag=1
fi
}

function secrefresh {
if [ $srflag == 0 ]
then
image=Sec_Refresh
imagebuild
mv /Users/user/Desktop/Images/Mavericks_"$image".hfs.dmg /Users/user/Desktop/Images/Mavericks_Sec.hfs.dmg
srflag=1
fi
}

function buildelem {
if [ $eflag == 0 ]
then
image=Elem
imagebuild
eflag=1
fi
}

function elemrefresh {
if [ $erflag == 0 ]
then
image=Elem_Refresh
imagebuild
mv /Users/user/Desktop/Images/Mavericks_"$image".hfs.dmg /Users/user/Desktop/Images/Mavericks_Elem.hfs.dmg
erflag=1
fi
}

if [ $# -eq "$NO_ARGS" ]    # Script invoked with no command-line args?
then
  echo "Usage: `basename $0` options (-vseaSER)"
  echo "-v                  Build Mavericks_Vanilla.hfs.dmg"
  echo "-s                  Build Mavericks_Sec.hfs.dmg"
  echo "-e                  Build Mavericks_Elem.hfs.dmg"
  echo "-a                  Build Mavericks_Vanilla, Sec, and Elem"
  echo "-S                  Sec Refresh"
  echo "-E                  Elem Refresh"
  echo "-R                  Sec Refresh, Elem Refresh"
  exit $E_OPTERROR          # Exit and explain usage.
                            # Usage: scriptname -options
                            # Note: dash (-) necessary
fi  

while getopts ":vseaESR" Option
do
  case $Option in
    v     ) echo "Build Mavericks_Vanilla"; 
buildvanilla
;;
    s     ) echo "Build Mavericks_Secondary"; 
buildsec
;;
    e     ) echo "Build Mavericks_Elementary"; 
buildelem
;;
    a     ) echo "Build All"; 
buildvanilla
buildsec
buildelem
;;
    S     ) echo "Refresh Secondary"; 
secrefresh
;;
    E     ) echo "Refresh Elementary"; 
elemrefresh
;;
    R     ) echo "Refresh All"; 
secrefresh
elemrefresh
;;
    *     ) echo "Unimplemented option chosen.";;   # Default.
  esac
done

shift $(($OPTIND - 1))
#  Decrements the argument pointer so it points to next argument.
#  $1 now references the first non-option item supplied on the command-line
#+ if one exists.

exit $?




