#!/bin/bash

##Enable Developer group in macOS and add the current logged in user to the group


##Get Logged in user
LoggedInUser=$(who | awk '/console/{print $1}')

##Activate Developer mode
/usr/sbin/DevToolsSecurity -enable

##Add User to group
/usr/bin/dscl . append /Groups/_developer GroupMembership $LoggedInUser
