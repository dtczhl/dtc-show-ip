#!/bin/bash

# Display your IP at my website

# Huanle Zhang
# www.huanlezhang.com

my_website="http://localhost/json/dtc-show-ip.php"

your_IPs=""
web_response=""
json_string=""

check_requirements(){
	# check if the required tools/programs installed

	required_commands=( 'ifconfig' 'grep' 'cut' 'curl' 'tr' )
	for i in "${required_commands[@]}"; do
		if ! command -v $i 1>/dev/null 2>&1 ; then
			echo "    You need to install ${i}"
			echo "        and then run this script"
			exit 1
		fi
	done
	
}

get_ips(){
	# get ip

	your_IPs=$(ifconfig | grep -Eo 'inet addr:([0-9]{1,3}\.){3}[0-9]{1,3}' | cut -d ':' -f 2 | grep -v '127.0.0.1')
	# remove newline
	your_IPs=$(echo ${your_IPs} | tr -d '\n')
}

send_json(){
	# send json to website

	if [ $# -ne 1 ]; then
		echo "Error in send_json, require a string to send"
		exit -1
	fi

	web_response=$(curl -s -i \
		-H "Accept: application/json" \
		-H "Content-Type:application/json" \
		-X POST --data "${1}" "${my_website}" ) #| grep -Eo 'dtcResponse=[0-9];')
}

build_json_string(){
	# easy way to build json

	json_string=$(cat <<EOF
{
	"your_IPs": "${your_IPs}"
}
EOF
)


}

# main starts here

check_requirements 
get_ips 

build_json_string

send_json "${json_string}"

echo $web_response

if [ "${ip_response}" == "" ]; then
	echo "    Cannot get right response format"
	echo "        Check, e.g., URL, data format, ..."
	exit 1
fi


echo "" # new line
