# dtc-show-ip

## Provide interface to my website that shows your IPs. Useful for embedded devices without monitors

## Go to my personal website to see your IPs
www.huanlezhang.com/interface.php

## Run:
```
./dtc-show-ip "your_message"
```
Note: 

1. message length must be less than 20 characters
	
2. tested using bash

## Better call this script periodically using Crontab or at startup time.

For example, run this script after booting, put a startup script under /etc/rc.d/, with 

```
#!/bin

/bin/bash path_of_dtc-show-ip.sh "your message"
```
## The server side implementation is also released. See my [Github](https://github.com/dtczhl/Personal-website).
