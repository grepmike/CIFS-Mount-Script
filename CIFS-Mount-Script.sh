#! /bin/bash

# =========================================================== #
# Bash script to mount your xdrive to your user /media/xdrive #
# =========================================================== #

# ====================================================================== #
#                                                                        #
# REQUIRED - fstab entry for network share.                              #
# /etc/fstab entry should be as follows:                                 #
# //server.com/file/share/path  /media/xdrive cifs noauto,users 0 0      #
#                                                                        #
# ---------------------------------------------------------------------- #
#                                                                        #
# IMPORTANT - unmount /media/xdrive after you leave your machine         #
#       failing to do so will disallow other users on that machine       #
#       to use the drive for themselves without forcing an unmount       #
#       which requires sudo access.                                      #
#                                                                        #
# ====================================================================== #

# First conditional check that checks to see if directory exists

if [ -d /media/xdrive ]; then

# Second conditional check that checks to see if directory is empty
# If so, then the xdrive is mounted with read/write permissions
# It will ask for your Universal password and spits out ls if successful

    if [ ! "$(ls -A /media/xdrive)" ]; then

        echo
        echo "GOOD NEWS - xdrive directory exists and is empty."
        echo
	echo "ACTION - Attempting to mount to /media/xdrive."
        echo

        echo "PROMPT - Please enter your SMB share-related password when prompted."
        mount /media/xdrive
        echo

        if [ "$(ls -A /media/xdrive)" ]; then
       	    echo "SUCCESS."
	    echo
            echo "ACTION - Listing xdrive sub-directories:"
            ls /media/xdrive
	    echo
        else
            echo "ERROR - Wrong username/password combination (probably)."
	    echo
        fi

# If second conditional check fails then it will echo out saying what may be wrong

    else
        echo
        echo "ERROR - xdrive directory is not empty."
        echo
	echo "ADVICE - Please check to see if the directory is already mounted."
        echo
    fi

# If first conditional check fails then it will echo out saying so and ask the user to make the appropriate changes in /etc/fstab

else
    echo
    echo "ERROR - Entry in /etc/fstab for /media/xdrive has not been created."
    echo "ADVICE - Contact your local server administrator to do so for you."
    echo
fi
