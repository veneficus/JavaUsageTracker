# Following code is adopted from https://gist.github.com/marcelom/4218010 (Tiny Python Syslog Server)
# Thanks Bjorn Jorgensen 
# This is the Java Usage logging server that listens to Java Usage report sent from the clients via UDP on port 32139.
# You must configure each of your JRE instances to send usage report to this server. You can use the Powershell provided in this repository.


import logging
import socketserver

logFile = "javalog.txt" #Change the log file if you like
host = "127.0.0.1" #make sure to put server's IP address
port = 32139 #You can change the port if you like. This is the default JAVA config

logging.basicConfig(level=logging.INFO, format='%(message)s', datefmt='', filename=logFile, filemode='a')

class SyslogUDPHandler(socketserver.BaseRequestHandler):

    def handle(self):
        data = bytes.decode(self.request[0].strip())
        socket = self.request[1]
        print( "%s : " % self.client_address[0], str(data))
        logging.info(str(data))

if __name__ == "__main__":
    try:
        server = socketserver.UDPServer((host,port), SyslogUDPHandler)
        server.serve_forever(poll_interval=0.5)
    except (IOError, SystemExit):
        raise
    except KeyboardInterrupt:
        print ("Crtl+C Pressed. Shutting down.")
