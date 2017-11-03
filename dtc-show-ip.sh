#!/bin/bash

# Display your IP at my website

# Huanle Zhang
# www.huanlezhang.com

my_website="http://www.huanlezhang.com/json/dtc-show-ip.php"

your_IPs=""
your_message=""
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
		-X POST --data "${1}" "${my_website}" | grep -Eo 'dtcResponse=[0-9];')
}

build_json_string(){
	# easy way to build json

	json_string=$(cat <<EOF
{
	"your_IPs": "${your_IPs}",
	"your_message": "${your_message}"
}
EOF
)


}

# main starts here

if [ $# -ne 1 ]; then
	echo "Error: "
	echo "    Format: ./dtc-show-ip \"your_message\""
	exit
fi

your_message=$1

check_requirements 
get_ips 

build_json_string

send_json "${json_string}"

if [ -n $web_response ]; then
	
	responseCode=$( echo $web_response | tr ';=' '::' | cut -d ':' -f 2 )
	case $responseCode in 
		
		'0')
			echo 'IP update OK'
			;;
		'1')
			echo 'IP strings too long'
			;;
		*)
			echo 'Error in response code' 1>&2 
			;;
	esac
fi # check reponse code

