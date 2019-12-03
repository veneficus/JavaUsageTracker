# JavaUsageTracker
This is a basic tracker that tracks the usage of Java Runtime Environment (JRE) in your environment. 

Oracle now requires companies to pay for the Java updates. A lot of organizations have Java installations in their environment but they do not know what is actually used. This solution is an easy to deploy, lightweight solution that is aimed to collect Java usage from the systems across your environment. The data then can be analyzed with your favorite analysis tools. 

## This solution has two parts:

1. Configuration Deployment Script
2. Python Server that collects usage data and saves it to a flat file


## Configuration deployment script
This is a PowerShell script that installs the necessary config files to each JRE instance it detects on the client system. It is currently windows only but the concept and the configuration is the same for Linux/Mac. 
