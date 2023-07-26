#!/bin/bash
# SPSDEV-3285 Script for moving client's (custom) spatialmap configuration
# Run this script on Windows in a Git Bash Terminal.
# Param SITE_DIR should be the root of the Git repository
# Remember to do a commit before moving so changes can be rolled back

#site dir (will not work outside GIT Bash)
SITE_DIR=/e/spatialsuite/sites/spike

#webapp dir
WEBAPP_DIR=$SITE_DIR/appbase/spatialmap/WEB-INF

#config dir
CONFIG_DIR=$WEBAPP_DIR/config

#client dir
SPATIALMAP_CONFIG_DIR=$SITE_DIR/config/spatialmap

if [ -d $SPATIALMAP_CONFIG_DIR ]; then
    echo "New config Directory exists .. cleaning up"
    rm -rf $SPATIALMAP_CONFIG_DIR/*
else
    mkdir --parents --verbose $SPATIALMAP_CONFIG_DIR
fi

# make subdir for modules
mkdir $SPATIALMAP_CONFIG_DIR/modules/

# make a new "custom" module out of the old custom configuration files
# in Sweco demo the custom configuration is demo01
MNAME=demo01

# handle demo01 modules configuration
mv $CONFIG_DIR/demo/modules_demo01.xml $SPATIALMAP_CONFIG_DIR/modules/
mv $CONFIG_DIR/demo/modules_local.xml $SPATIALMAP_CONFIG_DIR/modules/

mkdir $SPATIALMAP_CONFIG_DIR/modules/$MNAME
mkdir $SPATIALMAP_CONFIG_DIR/modules/$MNAME/datasources
mkdir $SPATIALMAP_CONFIG_DIR/modules/$MNAME/lang
mkdir $SPATIALMAP_CONFIG_DIR/modules/$MNAME/misc
mkdir $SPATIALMAP_CONFIG_DIR/modules/$MNAME/pages
mkdir $SPATIALMAP_CONFIG_DIR/modules/$MNAME/presentations
mkdir $SPATIALMAP_CONFIG_DIR/modules/$MNAME/profiles
mkdir $SPATIALMAP_CONFIG_DIR/modules/$MNAME/profiles/include
mkdir $SPATIALMAP_CONFIG_DIR/modules/$MNAME/queries
mkdir $SPATIALMAP_CONFIG_DIR/modules/$MNAME/themes
mkdir $SPATIALMAP_CONFIG_DIR/modules/$MNAME/tools
mkdir $SPATIALMAP_CONFIG_DIR/modules/$MNAME/xsl

# move all custom modules
mv $CONFIG_DIR/modules/custom/* $SPATIALMAP_CONFIG_DIR/modules/

# move third party modules
mv $CONFIG_DIR/modules/thirdparty $SPATIALMAP_CONFIG_DIR/modules/

# remove custom modules dir
rm -r $CONFIG_DIR/modules/custom 

# handle custom configuration. Note: In case of demo01 the configuration is inconsistently in a subfolder...
mv $CONFIG_DIR/datasources/custom/$MNAME/* $SPATIALMAP_CONFIG_DIR/modules/$MNAME/datasources/
mv $CONFIG_DIR/misc/custom/* $SPATIALMAP_CONFIG_DIR/modules/$MNAME/misc/
mv $CONFIG_DIR/pages/custom/* $SPATIALMAP_CONFIG_DIR/modules/$MNAME/pages/
mv $CONFIG_DIR/presentations/custom/$MNAME/* $SPATIALMAP_CONFIG_DIR/modules/$MNAME/presentations/
mv $CONFIG_DIR/queries/custom/$MNAME/* $SPATIALMAP_CONFIG_DIR/modules/$MNAME/queries/
mv $CONFIG_DIR/themes/custom/$MNAME/* $SPATIALMAP_CONFIG_DIR/modules/$MNAME/themes/
mv $CONFIG_DIR/tools/custom/* $SPATIALMAP_CONFIG_DIR/modules/$MNAME/tools/
mv $CONFIG_DIR/xsl/custom/* $SPATIALMAP_CONFIG_DIR/modules/$MNAME/xsl/

# remove custom directories
rm -r $CONFIG_DIR/datasources/custom
rm -r $CONFIG_DIR/misc/custom
rm -r $CONFIG_DIR/pages/custom
rm -r $CONFIG_DIR/presentations/custom
rm -r $CONFIG_DIR/queries/custom
rm -r $CONFIG_DIR/themes/custom
rm -r $CONFIG_DIR/tools/custom
rm -r $CONFIG_DIR/xsl/custom

# move profile include related to the new module
# here profiles/includes/demo01_*
mv $CONFIG_DIR/profiles/includes/custom/$MNAME_* $SPATIALMAP_CONFIG_DIR/modules/$MNAME/profiles/include/

#remove custom profile includes
rm -r $CONFIG_DIR/profiles/includes/custom

# handle subdir for profiles
mkdir $SPATIALMAP_CONFIG_DIR/profiles

# move the profiles but not standard includes
mv $CONFIG_DIR/profiles/*.xml $SPATIALMAP_CONFIG_DIR/profiles/

# in the case of texts there is a standardtext and customtext cbinfo param set. 
# We don't need embedding in a module and it would require renaming the texts
mv $CONFIG_DIR/lang/custom/* $SPATIALMAP_CONFIG_DIR/lang/

# remove custom lang dir
rm -r $CONFIG_DIR/lang/custom

# move custom cbinfo param file
mv $CONFIG_DIR/cbinfo_custom.xml $SPATIALMAP_CONFIG_DIR/
