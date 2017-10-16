#!/bin/bash

# Display your IP at my website

# Huanle Zhang
# www.huanlezhang.com

my_website="http://www.huanlezhang.com/interface.php"

check_requirements(){
	# check if the required tools/programs installed

	required_commands=( 'ifconfig' 'grep' 'cut' 'curl' )
	for i in "${required_commands[@]}"; do
		if ! command -v $i 1>/dev/null 2>&1 ; then
			echo "    You need to install ${i}"
			echo "        and then run this script"
			exit 1
		fi
	done
	
}


# main starts here

check_requirements 

your_IPs=$(ifconfig | grep -Eo 'inet addr:([0-9]{1,3}\.){3}[0-9]{1,3}' | cut -d ':' -f 2 | grep -v '127.0.0.1')


web_response=$(curl -s -i \
	-H "Accept: application/json" \
	-H "Content-Type:application/json" \
	-X POST --data "${your_IPs}" "${my_website}" )

ip_response=$(echo ${web_response} | grep -Eo "DTC_IP_update=[0-9];" )

if [ "${ip_response}" == "" ]; then
	echo "    Cannot get right response format"
	echo "        Check, e.g., URL, data format, ..."
	exit 1
fi

echo $ip_response

echo "" # new line
