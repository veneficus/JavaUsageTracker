# JRE Usage Tracker Configuration Deployment Script v1.00
# Coded by Levent Unal (www.unal.org) 
# Installs the configuration file for tracking JRE usage over UDP
# More information can be found at https://docs.oracle.com/javacomponents/usage-tracker/overview/
# You can use the Python listener javalog.py included here

# usagetracker.properties FILE SHOULD CONTAIN
#
# com.oracle.usagetracker.logToUDP = <IP ADDRESS OF THE LISTENER>:32139
# com.oracle.usagetracker.separator = ,
# com.oracle.usagetracker.quote = "
# com.oracle.usagetracker.innerquote = '

# Define the source location of the usagetracker file below.
# This script will install the configuration file to each version of JRE found on the system. (if the default target directory is not modified)
#
$usageTrackerFile = "usagetracker.properties"


function installJavaTracker($curPath){
    if (Test-Path $curPath){
        Write-Host "$curPath found"
        $confPath = $curPath + '\conf'
        if (!(Test-Path $confPath)){
            Write-Host "Creating folder $confPath"
            new-item -path $confPath -ItemType Directory
        }
        $filePath = $confPath + "\usagetracker.properties"
        Write-Host "Copying config file to $filePath"
        Copy-Item  $usageTrackerFile $filePath -Force
    
        #Check for sub paths with JRE
        $jreSearch = $curPath + "\jre*"
        $jres = Get-ChildItem -path $jreSearch
        foreach($jrePath in $jres){
            Write-Host "Detected: $jrePath"
            $mgmntPath = $jrePath.FullName + "\lib\management"
            #Write-Host $mgmntPath
            if(!(Test-Path $mgmntPath)){
                Write-Host "Creating folder $mgmntPath"
                New-Item -Path $mgmntPath -ItemType Directory
            }
    
            $filePath = $mgmntPath + "\usagetracker.properties"
            Write-Host "Copying config file to $filePath"
            Copy-Item $usageTrackerFile $filePath -Force
        }
    }
}
Write-Host
Write-host "Starting JRE Usage Tracker Configuration Deployment Script v1.00 by Levent Unal"

$curPath = 'C:\Program Files (x86)\java'
installJavaTracker($curPath)

$curPath = 'C:\Program Files\java'
installJavaTracker($curPath)

Write-host "DONE!"
Write-Host