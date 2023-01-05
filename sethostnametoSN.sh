#################################################################################################################
###This Script should get computer serial number and set computer hostname with NT prefix.
###
### 
###
###
###
### Note: This can be re-writeen to use script options/parameters for easily updating the PWs
##################################################################################################################


#!/bin/bash

#Set API Variables

#apiUser=Admin
#apiPassword=Admin PW here
#serverAddress=http:Jamf Server address here

#Set prefix
#Name=$Name

#Get Computer Serial number
SerialNumber=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')

#Set ComputerName using variables created above
/usr/sbin/scutil set key ComputerName $Name-$SerialNumber

#Set Hostname
/usr/sbin/scutil set key HostName $Name-$SerialNumber

#Set LocalHostName
/usr/sbin/scutil set key LocalHostName $Name-$SerialNumber

#Set ComputerName in Jamf PRO 
curl -fsku ${apiUser}:${apiPassword} -H "CONTEXT-TYPE:text/xml"
${serverAddress}/JSSResource/computers/serialnumber/${SerialNumber} -X PUT -d "<computer><general>
<name>${serialNumber}</name></general></computer>"

jamf setComputerName -useSerialNumber