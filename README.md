# dtc-show-ip

## Provide interface to my website that shows your IPs. Useful for embedded devices without monitors. Auto upload IP when the network/interface is ready

## Go to my personal website to see your IPs
www.huanlezhang.com/interface.php

## Files:

1. dtc-show-ip.sh:
	* main function, can run alone
	* E.g., ./dtc-show-ip.sh "your message"
2. 90-dtcShowIp:
	* put this file under /etc/hotplug.d/iface/
	* change the interface that triggers your IP uploading, and the path to dtc-show-ip.sh


## Note: 

1. message length must be less than 20 characters
	
2. tested using bash

## The server side implementation is also released. See my [Github](https://github.com/dtczhl/Personal-website).
