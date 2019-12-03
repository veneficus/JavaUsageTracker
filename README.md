# JavaUsageTracker
This is a basic tracker that tracks the usage of Java Runtime Environment (JRE) in your environment. 

Oracle now requires companies to pay for the Java updates. A lot of organizations have Java installations in their environment but they do not know what is actually used. This solution is an easy to deploy, lightweight solution that is aimed to collect Java usage from the systems across your environment. The data then can be analyzed with your favorite analysis tools. 

### This solution has two parts:
1. Configuration Deployment Script
2. Python UDP Server that collects usage data and saves it to a flat file

### Configuration deployment script
This is a PowerShell script that installs the necessary config files to each JRE instance it detects on the client system. It is currently windows only but the concept and the configuration is the same for Linux/Mac. 

### Python UDP Server
This is a simple UDP listener server that listens UDP port 32139. JRE sends a comma delimited data to this port directly when it detects usage. The data is then written to a log file. See limitations for limitations of this approach.

## Installation
1. Open the javalog.py and change the host variable to match the IP address of the server you are going to install the listener application. Run the javalog.py to start listening UDP communications.
2. Open the usagetracker.properties file and update the IP address to match the server's IP address. Deploy the configuration script with your favorite deployment tool. Please make sure that the deployment script has access to the configuration file. 

That's all. Upon the competion of the script deployment JRE will be configures to forward its usage logs to the server you defined. 

## Limitations
This first iteration is designed to deploy quickly to get understanding of the current usage. It does not support concurrent connections, so it does not scale well to more than 10,000 clients. 

## More Information
- https://docs.oracle.com/javacomponents/usage-tracker/overview/
- https://www.oracle.com/assets/java-se-subscription-pricelist-5028356.pdf
