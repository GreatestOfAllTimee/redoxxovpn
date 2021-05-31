#!/bin/bash
#Menu
#Licensed to RedoxxoVpn
#Script by RedoxxoVpn

if [[ -e /etc/debian_version ]]; then
	OS=debian
	RCLOCAL='/etc/rc.local'
elif [[ -e /etc/centos-release || -e /etc/redhat-release ]]; then
	OS=centos
	RCLOCAL='/etc/rc.d/rc.local'
	chmod +x /etc/rc.d/rc.local
else
	echo "It looks like you are not running this installer on Debian, Ubuntu or Centos system"
	exit
fi
color1='\e[031;1m'
color2='\e[34;1m'
color3='\e[0m'
echo "-----------=[ System Malaysian Vps Script ]=-----------"
echo ""
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
swap=$( free -m | awk 'NR==4 {print $2}' )
up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')
echo -e "\e[032;1mCPU Model:\e[0m $cname"
echo -e "\e[032;1mNumber Of Cores:\e[0m $cores"
echo -e "\e[032;1mCPU Frequency:\e[0m $freq MHz"
echo -e "\e[032;1mTotal Amount Of RAM:\e[0m $tram MB"
echo -e "\e[032;1mTotal Amount Of Swap:\e[0m $swap MB"
echo -e "\e[032;1mSystem Uptime:\e[0m $up"
echo "-----------=[ Redoxxo Malaysian Vps Script ]=-----------"
echo "-----------=[ Grenade Malay Telco Vpn Trick  ]=-----------"
echo ""
echo -e "-----=[ SSH & OpenVPN Section ]=-----"
echo -e "${color1}1${color3}.Create User Account (${color2}add-ssh${color3})"
echo -e "${color1}3${color3}.Create Trial Account (${color2}trial-ssh${color3})"
echo -e "${color1}4${color3}.Renew User Account  (${color2}renew-ssh${color3})"
echo -e "${color1}6${color3}.Delete User Account (${color2}del-ssh${color3})"
echo -e "${color1}7${color3}.User Account Details (${color2}cek-ssh${color3})"
echo -e "${color1}8${color3}.Display User Lists (${color2}list-ssh${color3})"
echo -e "${color1}9${color3}.Delete Expired User (${color2}delete${color3})"
echo -e "${color1}10${color3}.Autokill Multi Login (${color2}autokill${color3})"
echo -e "${color1}10${color3}.Log Multi Login (${color2}mulog${color3})"
echo -e " "
echo -e "-----=[ Wireguard Section ]=-----"
echo -e "${color1}11${color3}.Create Wireguard Account (${color2}add-wg${color3})"
echo -e "${color1}12${color3}.Delete Wireguard (${color2}del-wg${color3})"
echo -e "${color1}13${color3}.Check Wireguard (${color2}cek-wg${color3})"
echo -e "${color1}14${color3}.Renew Wireguard (${color2}renew-wg${color3})"
echo -e "${color1}14${color3}.Show Wireguard (${color2}wg show${color3})"
echo -e " "
echo -e "-----=[ Ssr Vpn Section ]=-----"
echo -e "${color1}11${color3}.Create Ss Account (${color2}add-ss${color3})"
echo -e "${color1}12${color3}.Delete Ss (${color2}del-ss${color3})"
echo -e "${color1}14${color3}.Renew Ss (${color2}renew-ss${color3})"
echo -e "${color1}14${color3}.Check Ss (${color2}cek-ss${color3})"
echo -e " "
echo -e "-----=[ Ss Vpn Section ]=-----"
echo -e "${color1}11${color3}.Create Ssr Account (${color2}add-ssr${color3})"
echo -e "${color1}12${color3}.Delete Ssr (${color2}del-ssr${color3})"
echo -e "${color1}14${color3}.Renew Ssr (${color2}renew-ssr${color3})"
echo -e "${color1}14${color3}.Show Ssr (${color2}ssr${color3})"
echo -e " "
echo -e "-----=[ V2ray/Vmess Section ]=-----"
echo -e "${color1}11${color3}.Create Vmess WS Account (${color2}add-ws${color3})"
echo -e "${color1}12${color3}.Delete Vmess WS Account (${color2}del-ws${color3})"
echo -e "${color1}13${color3}.Renew Vmess WS Account (${color2}renew-ws${color3})"
echo -e "${color1}14${color3}.Check Vmess WS Login (${color2}cek-ws${color3})"
echo -e "${color1}14${color3}.Renew V2ray Certificate (${color2}certv2ray${color3})"
echo -e " "
echo -e "-----=[ V2ray/Vless Section ]=-----"
echo -e "${color1}15${color3}.Create Vless WS Account (${color2}add-vless${color3})"
echo -e "${color1}16${color3}.Delete Vless WS Account (${color2}del-vless${color3})"
echo -e "${color1}17${color3}.Renew Vless WS Account (${color2}renew-vless${color3})"
echo -e "${color1}18${color3}.Check Vless WS Login (${color2}cek-vless${color3})"
echo -e " "
echo -e "-----=[ Trojan Section ]=-----"
echo -e "${color1}15${color3}.Create Trojan Account (${color2}add-tr${color3})"
echo -e "${color1}16${color3}.Delete Trojan Account (${color2}del-tr${color3})"
echo -e "${color1}17${color3}.Renew Trojan Account (${color2}renew-tr${color3})"
echo -e "${color1}18${color3}.Check Trojan Login (${color2}cek-tr${color3})"
echo -e " "
echo -e "-----=[ VPS Section ]=-----"
echo -e "${color1}19${color3}.Add/Change Subdomain (${color2}add-host${color3})"
echo -e "${color1}20${color3}.Set Auto Reboot Vps (${color2}auto-reboot${color3})"
echo -e "${color1}28${color3}.Edit Server Port (${color2}change-port${color3})"
echo -e "${color1}29${color3}.Auto Backup (${color2}autobackup${color3})"
echo -e "${color1}29${color3}.Backup Vps (${color2}backup${color3})"
echo -e "${color1}29${color3}.Restore Vps Data (${color2}restore${color3})"
echo -e "${color1}29${color3}.Menu Webmin (${color2}webmin${color3})"
echo -e "${color1}30${color3}.Reboot VPS(${color2}reboot${color3})"
echo -e "${color1}31${color3}.Check Vps Bandwidth (${color2}vnstat${color3})"
echo -e "${color1}29${color3}.Check Ram Usage (${color2}ram${color3})"
echo -e "${color1}29${color3}.Check server Speed (${color2}speedtest${color3})"
echo -e " "
echo -e "-----=[ Others ]=-----"
echo -e "${color1}32${color3}.View Installation Log (${color2}info${color3})"
echo -e "${color1}35${color3}.About AutoScript (${color2}about${color3})"
echo -e "${color1}37${color3}.Exit Menu (${color2}exit${color3})"
echo -e "-------------------------------------"
read -p "Choose an option from (1-37): " x
if test $x -eq 1; then
add-ssh
elif test $x -eq 2; then
trial-ssh
elif test $x -eq 3; then
renew-ssh
elif test $x -eq 4; then
del-ssh
elif test $x -eq 5; then
cek-ssh
elif test $x -eq 6; then
list-ssh
elif test $x -eq 7; then
delete
elif test $x -eq 8; then
autokill
elif test $x -eq 9; then
mulog
elif test $x -eq 10; then
add-wg
elif test $x -eq 11; then
del-wg
elif test $x -eq 12; then
cek-wg
elif test $x -eq 13; then
renew-wg
elif test $x -eq 14; then
wg show
elif test $x -eq 15; then
add-ssr
elif test $x -eq 16; then
del-ssr
elif test $x -eq 17; then
renew-ssr
elif test $x -eq 18; then
ssr
elif test $x -eq 19; then
add-ss
elif test $x -eq 20; then
del-ss
elif test $x -eq 21; then
renew-ss
elif test $x -eq 22; then
cek-ss
elif test $x -eq 23; then
add-ws
elif test $x -eq 24; then
del-ws
elif test $x -eq 25; then
renew-ws
elif test $x -eq 26; then
cek-ws
elif test $x -eq 27; then
certv2ray
elif test $x -eq 28; then
add-vless
elif test $x -eq 29; then
del-vless
elif test $x -eq 30; then
renew-vless
elif test $x -eq 31; then
cek-vless
elif test $x -eq 32; then
add-tr
elif test $x -eq 33; then
del-tr
elif test $x -eq 34; then
renew-tr
elif test $x -eq 35; then
cek-tr
elif test $x -eq 36; then
add-host
elif test $x -eq 38; then
auto-reboot
elif test $x -eq 39; then
change-port
elif test $x -eq 40; then
autobackup
elif test $x -eq 41; then
backup
elif test $x -eq 42; then
restore
elif test $x -eq 43; then
webmin
elif test $x -eq 44; then
vnstat
elif test $x -eq 45; then
ram
elif test $x -eq 46; then
reboot
elif test $x -eq 47; then
speedtest
elif test $x -eq 37; then
info
elif test $x -eq 48; then
about
elif test $x -eq 49; then
exit
elif test $x -eq 50; then
echo " "
echo "GOODBYE!!!"
echo "SCRIPT BY RedoxxoVpn"
echo " "
exit
else
echo "Options Not Available In Menu."
echo " "
exit
fi
© 2021 GitHub, Inc.
