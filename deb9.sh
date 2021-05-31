#!/bin/bash
#VPS Script By   : Darknet
#Contact Me FB   : Lollipop

# Check Root
if [ "${EUID}" -ne 0 ]; then
echo "You need to run this script as root"
exit 1
fi

# Check System
if [ "$(systemd-detect-virt)" == "openvz" ]; then
echo "OpenVZ is not supported"
exit 1
fi

# Colours
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

# Requirement
apt update -y
apt upgrade -y
update-grub
apt install -y bzip2 gzip coreutils curl
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1

# Script Access 
MYIP=$(wget -qO- icanhazip.com);
echo -e "${green}CHECKING SCRIPT ACCESS${NC}"
IZIN=$( curl https://raw.githubusercontent.com/window22/redoxxovpn/main/ipvps | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}ACCESS GRANTED...${NC}"
else
echo -e "${green}ACCESS DENIED...${NC}"
exit 1
fi

# Subdomain Settings
mkdir /var/lib/premium-script;
echo -e "${green}ENTER THE VPS SUBDOMAIN/HOSTNAME, IF NOT AVAILABLE, PLEASE CLICK ENTER${NC}"
read -p "Hostname / Domain: " host
echo "IP=$host" >> /var/lib/premium-script/ipvps.conf
echo "$host" >> /root/domain
echo -e ""
echo -e "========================="
echo -e "| Installing Ruby . . . |"
echo -e "-------------------------"
echo -e ""
apt-get install ruby
echo -e ""

# Checking Ruby Version
echo -e "==============================="
echo -e "| Checking Ruby Version . . . |"
echo -e "-------------------------------"
echo -e ""
ruby --version
echo -e ""

# Download & Install Lolcat
echo -e "==================================="
echo -e "| Download & Install Lolcat . . . |"
echo -e "-----------------------------------"
echo -e ""
wget https://github.com/busyloop/lolcat/archive/master.zip
unzip master.zip
cd lolcat-master/bin
gem install lolcat
echo -e ""
echo "-----------=[ Redoxxo Malaysian Vps Script ]=-----------" | lolcat
echo "-----------=[ Pakya Malay Telco Vpn Trick  ]=-----------" | lolcat
echo -e ""

# Confirm to Install Script
read -p "Do you want to install this script ? [Y/n] " Answer
echo -e ""
if [[ $Answer =~ ^([yY])$ ]]
        then
		
# Remove Repository
rm -rf okkay

# Install nginx
apt-get -y install nginx php-fpm php-cli

# Get the "public" interface from the default route
NIC=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)
  # initializing var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sysctl -p
# Create Folder for IP Tables
mkdir -p /etc/iptables

# Install OpenVPN
apt-get install -y openvpn easy-rsa iptables openssl ca-certificates gnupg
apt-get install -y net-tools
cp -r /usr/share/easy-rsa /etc/openvpn
cd /etc/openvpn
cd easy-rsa


cp openssl-1.0.0.cnf openssl.cnf
source ./vars
./clean-all
source vars
rm -rf keys
./clean-all
./build-ca
./build-key-server server
./pkitool --initca
./pkitool --server server
./pkitool client
./build-dh
cp keys/ca.crt /etc/openvpn
cp keys/server.crt /etc/openvpn
cp keys/server.key /etc/openvpn
cp keys/dh2048.pem /etc/openvpn
cp keys/client.key /etc/openvpn
cp keys/client.crt /etc/openvpn

# Create openvpn.conf On Server

echo 'port 1194
proto tcp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
persist-key
persist-tun
keepalive 10 120
duplicate-cn
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
client-cert-not-required
username-as-common-name
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
comp-lzo
status server-tcp-1194.log
verb 3' >/etc/openvpn/server-tcp-1194.conf

echo 'port 9994
proto tcp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
persist-key
persist-tun
keepalive 10 120
duplicate-cn
server 10.9.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
client-cert-not-required
username-as-common-name
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
comp-lzo
status server-tcp-9994.log
verb 3' >/etc/openvpn/server-tcp-9994.conf

echo 'port 25000
proto udp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh2048.pem
persist-key
persist-tun
keepalive 10 120
duplicate-cn
server 20.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
client-cert-not-required
username-as-common-name
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
comp-lzo
status server-udp-25000.log
verb 3' >/etc/openvpn/server-udp-25000.conf

# Enable OpenVPN
systemctl enable openvpn

# Restart OpenVPN
service openvpn restart

cd

# Create Config OpenVPN For Client

echo "client
dev tun
proto tcp
remote $MYIP 1194
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3

" >/var/www/html/client-tcp-1194.ovpn

echo "client
dev tun
proto tcp
remote $MYIP 9994
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3

" >/var/www/html/client-tcp-9994.ovpn

echo "client
dev tun
proto udp
remote $MYIP 25000
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3

" >/var/www/html/client-udp-25000.ovpn

echo "client
dev tun
proto tcp
remote $MYIP 2905
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3

" >/var/www/html/client-ssl-2905.ovpn

echo "client
dev tun
proto tcp
remote $MYIP 9443
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3

" >/var/www/html//var/www/html/client-ssl-9443.ovpn

echo "client
dev tun
proto tcp
remote $MYIP 1194
http-proxy $MYIP 8080
http-proxy-option CUSTOM-HEADER CONNECT HTTP/1.1
http-proxy-option CUSTOM-HEADER Host m.instagram.com
http-proxy-option CUSTOM-HEADER X-Online-Host m.instagram.com
http-proxy-option CUSTOM-HEADER X-Forward-Host m.instagram.com
http-proxy-option CUSTOM-HEADER Connection Keep-Alive
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3

" >/var/www/html/instagram.ovpn


cd

apt-get install -y zip
cd /var/www/html

# Add Cert to OpenVPN Client
{
echo "<ca>"
cat "/etc/openvpn/ca.crt"
echo "</ca>"
} >>client-tcp-1194.ovpn

{
echo "<ca>"
cat "/etc/openvpn/ca.crt"
echo "</ca>"
} >>client-tcp-9994.ovpn

{
echo "<ca>"
cat "/etc/openvpn/ca.crt"
echo "</ca>"
} >>client-ssl-9443.ovpn

{
echo "<ca>"
cat "/etc/openvpn/ca.crt"
echo "</ca>"
} >>client-ssl-2905.ovpn

{
echo "<ca>"
cat "/etc/openvpn/ca.crt"
echo "</ca>"
} >>client-udp-25000.ovpn

{
echo "<ca>"
cat "/etc/openvpn/ca.crt"
echo "</ca>"
} >>instagram.ovpn


# Make ZIP Config OpenVPN Client

zip client-config.zip client-tcp-1194.ovpn client-tcp-9994.ovpn client-ssl-9443.ovpn client-ssl-2905.ovpn client-udp-25000.ovpn instagram.ovpn

apt-get install -y iptables iptables-persistent netfilter-persistent

iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o $NIC -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/24 -o $NIC -j MASQUERADE
iptables -t nat -A POSTROUTING -s 20.8.0.0/24 -o $NIC -j MASQUERADE
iptables-save > /etc/iptables/rules.v4

service openvpn restart

# Detail Company Profile

country=ID
state=Malaysia
locality=Kuala_Lumpur
organization=Redoxxovpn
organizationalunit=RedVpn
commonname=xShin
email=redoxxo@gmail.com

# Common Password

git clone https://github.com/window22/redoxxovpn
cd /root/okkay/common
mv common /etc/pam.d/
chmod +x /etc/pam.d/common-password

# go to root

cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

chmod +x /etc/rc.local

# Enable rc local

systemctl enable rc-local
systemctl start rc-local.service

#update

apt-get update -y

# install wget and curl

apt-get install -y wget curl

# remove unnecessary files

apt -y autoremove
apt -y autoclean
apt -y clean

# set time GMT +7

ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

# set locale

sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

# set repo
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
apt install gnupg gnupg1 gnupg2 -y
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc

# update
apt-get update -y

# Install Web Server Nginx

apt-get install -y nginx

# Install Neofetch

apt-get update -y
apt-get -y install gcc
apt-get -y install make
apt-get -y install cmake
apt-get -y install git
apt-get -y install screen
apt-get -y install unzip
apt-get -y install curl
apt-get -y install net-tools
git clone https://github.com/dylanaraps/neofetch
cd neofetch
make install
make PREFIX=/usr/local install
make PREFIX=/boot/home/config/non-packaged install
make -i install
apt-get -y install neofetch
cd
rm -rf neofetch

# update repo
apt-get -y update

# Change Default File Nginx

cd
rm /etc/nginx/sites-enabled/default

cd okkay/nginx/
mv default /etc/nginx/sites-enabled/

cd

/etc/init.d/nginx restart
systemctl restart nginx

# install badvpn
cd

cd okkay/badvpn/
mv badvpn-udpgw /usr/bin/

cd

sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500

cd
rm -rf okkay
git clone https://github.com/window22/redoxxovpn

cd okkay/badvpn/
mv badvpn-udpgw /usr/bin/

sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500

cd

# Sett Port OpenSSH

sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 843' /etc/ssh/sshd_config
service ssh restart

# Install Dropbear

apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 142"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# Install Squid Proxy

cd
apt-get -y install squid3

echo "#acl manager proto cache_object
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst $MYIP-$MYIP/255.255.255.255
http_access allow SSH
http_access allow manager localhost
http_access deny manager
http_access allow localhost
http_access deny all
http_port 8080
http_port 3128
coredump_dir /var/spool/squid3
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
refresh_pattern . 0 20% 4320
visible_hostname cvpn.ovh
" >/etc/squid/squid.conf

service squid restart

# Setting Vnstat
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install 
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz 
rm -rf /root/vnstat-2.6

# Install Webmin

apt install webmin -y
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
/etc/init.d/webmin restart

wget -o webmin "https://raw.githubusercontent.com/window22/redoxxovpn/main/menu/webmin.sh"

# Install Stunnel

apt-get install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 943
connect = 127.0.0.1:142

[dropbear]
accept = 2905
connect = 127.0.0.1:9994

[openvpn]
accept = 992
connect = 127.0.0.1:1194

END

# Make a Certificate

openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
rm -f key.pem
rm -f cert.pem

# Configure Stunnel

sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

# Install Fail2ban

cdLEDinstall fail2ban
apt-get -y install fail2ban

# Instal DDOS Flate

if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

# xml parser

cd
apt-get install -y libxml-parser-perl

# Add Banner

cd redoxxovpn/banner
mv issue.net /etc/

cd

sed -i 's@#Banner@Banner@g' /etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

#Install pptp/l2tp
# Debian 9 & 10 64bit
VPN_IPSEC_PSK='redoxxovpn'
VPN_USER='marlo'
VPN_PASSWORD='1'
NET_IFACE=$(ip -o $NET_IFACE -4 route show to default | awk '{print $5}');
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
source /etc/os-release
OS=$ID
ver=$VERSION_ID
bigecho() { echo; echo "## $1"; echo; }
bigecho "VPN setup in progress... Please be patient."

# Create and change to working dir
mkdir -p /opt/src
cd /opt/src

bigecho "Trying to auto discover IP of this server..."
PUBLIC_IP=$(wget -qO- ifconfig.co);

bigecho "Installing packages required for the VPN..."
if [[ ${OS} == "centos" ]]; then
epel_url="https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E '%{rhel}').noarch.rpm"
yum -y install epel-release || yum -y install "$epel_url" 

bigecho "Installing packages required for the VPN..."

REPO1='--enablerepo=epel'
REPO2='--enablerepo=*server-*optional*'
REPO3='--enablerepo=*releases-optional*'
REPO4='--enablerepo=PowerTools'

yum -y install nss-devel nspr-devel pkgconfig pam-devel \
  libcap-ng-devel libselinux-devel curl-devel nss-tools \
  flex bison gcc make ppp 

yum "$REPO1" -y install xl2tpd 


if [[ $ver == '7' ]]; then
  yum -y install systemd-devel iptables-services 
  yum "$REPO2" "$REPO3" -y install libevent-devel fipscheck-devel 
elif [[ $ver == '8' ]]; then
  yum "$REPO4" -y install systemd-devel libevent-devel fipscheck-devel 
fi
else
apt install openssl iptables iptables-persistent -y
apt-get -y install libnss3-dev libnspr4-dev pkg-config \
  libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev \
  libcurl4-nss-dev flex bison gcc make libnss3-tools \
  libevent-dev ppp xl2tpd pptpd
fi
bigecho "Compiling and installing Libreswan..."

SWAN_VER=3.32
swan_file="libreswan-$SWAN_VER.tar.gz"
swan_url1="https://github.com/libreswan/libreswan/archive/v$SWAN_VER.tar.gz"
swan_url2="https://download.libreswan.org/$swan_file"
if ! { wget -t 3 -T 30 -nv -O "$swan_file" "$swan_url1" || wget -t 3 -T 30 -nv -O "$swan_file" "$swan_url2"; }; then
  exit 1
fi
/bin/rm -rf "/opt/src/libreswan-$SWAN_VER"
tar xzf "$swan_file" && /bin/rm -f "$swan_file"
cd "libreswan-$SWAN_VER" || exit 1
cat > Makefile.inc.local <<'EOF'
WERROR_CFLAGS = -w
USE_DNSSEC = false
USE_DH2 = true
USE_DH31 = false
USE_NSS_AVA_COPY = true
USE_NSS_IPSEC_PROFILE = false
USE_GLIBC_KERN_FLIP_HEADERS = true
EOF
if ! grep -qs IFLA_XFRM_LINK /usr/include/linux/if_link.h; then
  echo "USE_XFRM_INTERFACE_IFLA_HEADER = true" >> Makefile.inc.local
fi
if [[ ${OS} == "debian" ]]; then
if [ "$(packaging/utils/lswan_detect.sh init)" = "systemd" ]; then
  apt-get -y install libsystemd-dev
  fi
elif [[ ${OS} == "ubuntu" ]]; then
if [ "$(packaging/utils/lswan_detect.sh init)" = "systemd" ]; then
  apt-get -y install libsystemd-dev
fi
fi
NPROCS=$(grep -c ^processor /proc/cpuinfo)
[ -z "$NPROCS" ] && NPROCS=1
make "-j$((NPROCS+1))" -s base && make -s install-base

cd /opt/src || exit 1
/bin/rm -rf "/opt/src/libreswan-$SWAN_VER"
if ! /usr/local/sbin/ipsec --version 2>/dev/null | grep -qF "$SWAN_VER"; then
  exiterr "Libreswan $SWAN_VER failed to build."
fi

bigecho "Creating VPN configuration..."

L2TP_NET=192.168.42.0/24
L2TP_LOCAL=192.168.42.1
L2TP_POOL=192.168.42.10-192.168.42.250
XAUTH_NET=192.168.43.0/24
XAUTH_POOL=192.168.43.10-192.168.43.250
DNS_SRV1=8.8.8.8
DNS_SRV2=8.8.4.4
DNS_SRVS="\"$DNS_SRV1 $DNS_SRV2\""
[ -n "$VPN_DNS_SRV1" ] && [ -z "$VPN_DNS_SRV2" ] && DNS_SRVS="$DNS_SRV1"

# Create IPsec config
cat > /etc/ipsec.conf <<EOF
version 2.0

config setup
  virtual-private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12,%v4:!$L2TP_NET,%v4:!$XAUTH_NET
  protostack=netkey
  interfaces=%defaultroute
  uniqueids=no

conn shared
  left=%defaultroute
  leftid=$PUBLIC_IP
  right=%any
  encapsulation=yes
  authby=secret
  pfs=no
  rekey=no
  keyingtries=5
  dpddelay=30
  dpdtimeout=120
  dpdaction=clear
  ikev2=never
  ike=aes256-sha2,aes128-sha2,aes256-sha1,aes128-sha1,aes256-sha2;modp1024,aes128-sha1;modp1024
  phase2alg=aes_gcm-null,aes128-sha1,aes256-sha1,aes256-sha2_512,aes128-sha2,aes256-sha2
  sha2-truncbug=no

conn l2tp-psk
  auto=add
  leftprotoport=17/1701
  rightprotoport=17/%any
  type=transport
  phase2=esp
  also=shared

conn xauth-psk
  auto=add
  leftsubnet=0.0.0.0/0
  rightaddresspool=$XAUTH_POOL
  modecfgdns=$DNS_SRVS
  leftxauthserver=yes
  rightxauthclient=yes
  leftmodecfgserver=yes
  rightmodecfgclient=yes
  modecfgpull=yes
  xauthby=file
  ike-frag=yes
  cisco-unity=yes
  also=shared

include /etc/ipsec.d/*.conf
EOF

if uname -m | grep -qi '^arm'; then
  if ! modprobe -q sha512; then
    sed -i '/phase2alg/s/,aes256-sha2_512//' /etc/ipsec.conf
  fi
fi

# Specify IPsec PSK
cat > /etc/ipsec.secrets <<EOF
%any  %any  : PSK "$VPN_IPSEC_PSK"
EOF

# Create xl2tpd config
cat > /etc/xl2tpd/xl2tpd.conf <<EOF
[global]
port = 1701

[lns default]
ip range = $L2TP_POOL
local ip = $L2TP_LOCAL
require chap = yes
refuse pap = yes
require authentication = yes
name = l2tpd
pppoptfile = /etc/ppp/options.xl2tpd
length bit = yes
EOF

# Set xl2tpd options
cat > /etc/ppp/options.xl2tpd <<EOF
+mschap-v2
ipcp-accept-local
ipcp-accept-remote
noccp
auth
mtu 1280
mru 1280
proxyarp
lcp-echo-failure 4
lcp-echo-interval 30
connect-delay 5000
ms-dns $DNS_SRV1
EOF

if [ -z "$VPN_DNS_SRV1" ] || [ -n "$VPN_DNS_SRV2" ]; then
cat >> /etc/ppp/options.xl2tpd <<EOF
ms-dns $DNS_SRV2
EOF
fi

# Create VPN credentials
cat > /etc/ppp/chap-secrets <<EOF
"$VPN_USER" l2tpd "$VPN_PASSWORD" *
EOF

VPN_PASSWORD_ENC=$(openssl passwd -1 "$VPN_PASSWORD")
cat > /etc/ipsec.d/passwd <<EOF
$VPN_USER:$VPN_PASSWORD_ENC:xauth-psk
EOF

# Create PPTP config
cat >/etc/pptpd.conf <<END
option /etc/ppp/options.pptpd
logwtmp
localip 192.168.41.1
remoteip 192.168.41.10-100
END
cat >/etc/ppp/options.pptpd <<END
name pptpd
refuse-pap
refuse-chap
refuse-mschap
require-mschap-v2
require-mppe-128
ms-dns 8.8.8.8
ms-dns 8.8.4.4
proxyarp
lock
nobsdcomp 
novj
novjccomp
nologfd
END

bigecho "Updating IPTables rules..."
service fail2ban stop >/dev/null 2>&1
iptables -t nat -I POSTROUTING -s 192.168.43.0/24 -o $NET_IFACE -j MASQUERADE
iptables -t nat -I POSTROUTING -s 192.168.42.0/24 -o $NET_IFACE -j MASQUERADE
iptables -t nat -I POSTROUTING -s 192.168.41.0/24 -o $NET_IFACE -j MASQUERADE
if [[ ${OS} == "centos" ]]; then
service iptables save
iptables-restore < /etc/sysconfig/iptables 
else
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
fi

bigecho "Enabling services on boot..."
systemctl enable xl2tpd
systemctl enable ipsec
systemctl enable pptpd

for svc in fail2ban ipsec xl2tpd; do
  update-rc.d "$svc" enable >/dev/null 2>&1
  systemctl enable "$svc" 2>/dev/null
done

bigecho "Starting services..."
sysctl -e -q -p
chmod 600 /etc/ipsec.secrets* /etc/ppp/chap-secrets* /etc/ipsec.d/passwd*

mkdir -p /run/pluto
service fail2ban restart 2>/dev/null
service ipsec restart 2>/dev/null
service xl2tpd restart 2>/dev/null
wget -O /usr/bin/addl2tp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/addl2tp.sh && chmod +x /usr/bin/addl2tp
wget -O /usr/bin/dell2tp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/dell2tp.sh && chmod +x /usr/bin/dell2tp
wget -O /usr/bin/xp-l2tp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/xp-l2tp.sh && chmod +x /usr/bin/xp-l2tp
wget -O /usr/bin/addpptp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/addpptp.sh && chmod +x /usr/bin/addpptp
wget -O /usr/bin/delpptp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/delpptp.sh && chmod +x /usr/bin/delpptp
wget -O /usr/bin/xp-pptp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/xp-pptp.sh && chmod +x /usr/bin/xp-pptp
wget -O /usr/bin/renewpptp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/renewpptp.sh && chmod +x /usr/bin/renewpptp
wget -O /usr/bin/renewl2tp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/renewl2tp.sh && chmod +x /usr/bin/renewl2tp
cat > /okkay/vpn/id.txt
cat > /okkay/vpn/id.txt
rm -f /root/ipsec.sh
echo "0 0 * * * root xp-pptp" >> /etc/crontab
echo "0 0 * * * root xp-l2tp" >> /etc/crontab

cd okkay/menu
mv addl2tp.sh addl2tp
mv dell2tp.sh dell2tp

cd

echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot


cd okkay/vpn
#copy file to usr/bin
cp -R addl2tp /usr/bin
cp -R dell2tp /usr/bin

#change mode script 
chmod +x /usr/bin/addl2tp
chmod +x /usr/bin/dell2tp

#Install Sstp
MYIP=$(wget -qO- ifconfig.co);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NIC=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
OS=$ID
ver=$VERSION_ID
if [[ $OS == 'ubuntu' ]]; then
if [[ "$ver" = "18.04" ]]; then
yoi=Ubuntu18
elif [[ "$ver" = "20.04" ]]; then
yoi=Ubuntu20
fi
elif [[ $OS == 'debian' ]]; then
if [[ "$ver" = "9" ]]; then
yoi=Debian9
elif [[ "$ver" = "10" ]]; then
yoi=Debian10
fi
fi
mkdir /home/sstp
cat /home/sstp/sstp_account
cat /var/lib/data-user-sstp
#detail nama perusahaan
country=MY
state=Malaysia
locality=Malaysia
organization=PakyaDomain
organizationalunit=PakyaDomain
commonname=PakyaDomain
email=PakyaDomain@gmail.com

#install sstp
apt install openssl iptables iptables-persistent -y
apt-get install -y build-essential cmake gcc linux-headers-`uname -r` git libpcre3-dev libssl-dev liblua5.1-0-dev ppp
git clone https://github.com/accel-ppp/accel-ppp.git /opt/accel-ppp-code
mkdir /opt/accel-ppp-code/build
cd /opt/accel-ppp-code/build/
cmake -DBUILD_IPOE_DRIVER=TRUE -DBUILD_VLAN_MON_DRIVER=TRUE -DCMAKE_INSTALL_PREFIX=/usr -DKDIR=/usr/src/linux-headers-`uname -r` -DLUA=TRUE -DCPACK_TYPE=$yoi ..
make
cpack -G DEB
dpkg -i accel-ppp.deb
mv /etc/accel-ppp.conf.dist /etc/accel-ppp.conf
wget -O /etc/accel-ppp.conf "https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/accel.conf"
sed -i $MYIP2 /etc/accel-ppp.conf
chmod +x /etc/accel-ppp.conf
systemctl start accel-ppp
systemctl enable accel-ppp
#gen cert sstp
cd /home/sstp
openssl genrsa -out ca.key 4096
openssl req -new -x509 -days 3650 -key ca.key -out ca.crt \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
openssl genrsa -out server.key 4096
openssl req -new -key server.key -out ia.csr \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
openssl x509 -req -days 3650 -in ia.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt
cp /home/sstp/server.crt /home/vps/public_html/server.crt
iptables -t nat -A POSTROUTING -o $NIC -j MASQUERADE
iptables-save > /etc/iptables.up.rules
chmod +x /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

#input perintah sstp
wget -O /usr/bin/addsstp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/addsstp.sh && chmod +x /usr/bin/addsstp
wget -O /usr/bin/delsstp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/delsstp.sh && chmod +x /usr/bin/delsstp
wget -O /usr/bin/ceksstp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/ceksstp.sh && chmod +x /usr/bin/ceksstp
wget -O /usr/bin/xp-sstp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/xp-sstp.sh && chmod +x /usr/bin/xp-sstp
wget -O /usr/bin/renewsstp https://raw.githubusercontent.com/window22/redoxxovpn/main/vpn/renewsstp.sh && chmod +x /usr/bin/renewsstp
rm -f /root/sstp.sh
echo "0 0 * * * root xp-sstp" >> /etc/crontab

#Install Shadowsocks
source /etc/os-release
OS=$ID
ver=$VERSION_ID

#Install_Packages
echo "#############################################"
echo "Install Paket..."
apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake -y
echo "Install Paket Selesai."
echo "#############################################"


#Install_Shadowsocks_libev
echo "#############################################"
echo "Install Shadowsocks-libev..."
apt-get install software-properties-common -y
if [[ $OS == 'ubuntu' ]]; then
apt install shadowsocks-libev -y
apt install simple-obfs -y
elif [[ $OS == 'debian' ]]; then
if [[ "$ver" = "9" ]]; then
echo "deb http://deb.debian.org/debian stretch-backports main" | tee /etc/apt/sources.list.d/stretch-backports.list
apt update
apt -t stretch-backports install shadowsocks-libev -y
apt -t stretch-backports install simple-obfs -y
elif [[ "$ver" = "10" ]]; then
echo "deb http://deb.debian.org/debian buster-backports main" | tee /etc/apt/sources.list.d/buster-backports.list
apt update
apt -t buster-backports install shadowsocks-libev -y
apt -t buster-backports install simple-obfs -y
fi
fi
echo "Install Shadowsocks-libev Selesai."
echo "#############################################"

#Server konfigurasi
echo "#############################################"
echo "Konfigurasi Server."
cat > /etc/shadowsocks-libev/config.json <<END
{   
    "server":"0.0.0.0",
    "server_port":8488,
    "password":"tes",
    "timeout":60,
    "method":"aes-256-cfb",
    "fast_open":true,
    "nameserver":"1.1.1.1",
    "mode":"tcp_and_udp",
}
END
echo "#############################################"

#mulai ~shadowsocks-libev~ server
echo "#############################################"
echo "mulai ss server"
systemctl enable shadowsocks-libev.service
systemctl start shadowsocks-libev.service
echo "#############################################"

#buat client config
echo "#############################################"
echo "buat config obfs"
cat > /etc/shadowsocks-libev.json <<END
{
    "server":"127.0.0.1",
    "server_port":8388,
    "local_port":1080,
    "password":"",
    "timeout":60,
    "method":"chacha20-ietf-poly1305",
    "mode":"tcp_and_udp",
    "fast_open":true,
    "plugin":"/usr/bin/obfs-local",
    "plugin_opts":"obfs=tls;failover=127.0.0.1:1443;fast-open"
}
END
chmod +x /etc/shadowsocks-libev.json
echo "#############################################"

touch /etc/shadowsocks-libev/akun.conf

echo "#############################################"
echo "Menambahkan Perintah Shadowsocks-libev"
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2443:3543 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2443:3543 -j ACCEPT
ip6tables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2443:3543 -j ACCEPT
ip6tables -I INPUT -m state --state NEW -m udp -p udp --dport 2443:3543 -j ACCEPT
iptables-save > /etc/iptables.up.rules
ip6tables-save > /etc/ip6tables.up.rules
cd /usr/bin
wget -O addss "https://raw.githubusercontent.com/window22/redoxxovpn/main/menu/addss.sh"
wget -O cekss "https://raw.githubusercontent.com/window22/redoxxovpn/main/menu/cekss.sh"
wget -O delss "https://raw.githubusercontent.com/window22/redoxxovpn/main/menu/delss.sh"
wget -O xp-ss "https://raw.githubusercontent.com/window22/redoxxovpn/main/menu/xp-ss.sh"
wget -O renewss "https://raw.githubusercontent.com/window22/redoxxovpn/main/menu/renewss.sh"
chmod +x addss
chmod +x cekss
chmod +x delss
chmod +x xp-ss
chmod +x renewss
cd
rm -f /root/ss.sh
echo "0 0 * * * root xp-ss" >> /etc/crontab


cd okkay/menu

# Delete Ekstenstion File
mv menu.sh menu
mv usernew.sh usernew
mv trial.sh trial
mv member.sh member
mv delete.sh delete
mv cek.sh cek
mv restart.sh restart
mv speedtest.py speedtest
mv info.sh info
mv about.sh about
mv live.sh live
mv perpanjang.sh perpanjang
mv cekmemory.py cekmemory
mv cekport.sh cekport
mv port.sh port
mv success.sh success
mv statport.sh statport
mv update.sh update
mv contact.sh contact
mv webmin.sh webmin
mv addss.sh addss
mv cekss.sh cekss
mv delss.sh delss
mv xp-ss.sh xp-ss
mv renewss.sh renewss

cd

echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot

cd redoxxovpn/menu

# Copy File To /usr/bin
cp -R menu /usr/bin
cp -R usernew /usr/bin
cp -R trial /usr/bin
cp -R member /usr/bin
cp -R delete /usr/bin
cp -R cek /usr/bin
cp -R restart /usr/bin
cp -R speedtest /usr/bin
cp -R info /usr/bin
cp -R about /usr/bin
cp -R live /usr/bin
cp -R cekmemory /usr/bin
cp -R cekport /usr/bin
cp -R port /usr/bin
cp -R success /usr/bin
cp -R statport /usr/bin
cp -R update /usr/bin
cp -R contact /usr/bin
cp -R webmin /usr/bin
cp -R addss /usr/bin
cp -R cekss /usr/bin
cp -R delss /usr/bin
cp -R xp-ss /usr/bin
cp -R renewss /usr/bin

# Change Mode Script
chmod +x /usr/bin/menu
chmod +x /usr/bin/usernew
chmod +x /usr/bin/trial
chmod +x /usr/bin/member
chmod +x /usr/bin/delete
chmod +x /usr/bin/cek
chmod +x /usr/bin/restart
chmod +x /usr/bin/speedtest
chmod +x /usr/bin/info
chmod +x /usr/bin/about
chmod +x /usr/bin/live
chmod +x /usr/bin/cekmemory
chmod +x /usr/bin/cekport
chmod +x /usr/bin/port
chmod +x /usr/bin/success
chmod +x /usr/bin/statport
chmod +x /usr/bin/update
chmod +x /usr/bin/contact
chmod +x /usr/bin/webmin
chmod +x /usr/bin/addss
chmod +x /usr/bin/cek-ss
chmod +x /usr/bin/del-ss
chmod +x /usr/bin/xp-ss
chmod +x /usr/bin/renew-ss

# Install Script
# download script
cd /usr/local/bin
https://raw.githubusercontent.com/window22/redoxxovpn/main/menu/menu.sh && chmod +x menu.sh && ./menu.sh

# finishing
cd
systemctl restart nginx
service openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/sshd restart
service dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/webmin restart
/etc/init.d/stunnel4 restart
service squid restart
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500

echo "clear" >> .profile
echo 'echo -e ""' >> .profile
echo 'echo -e ""' >> .profile
echo -e "######################PakyaScriptPremium#######################" | lolcat' >> .profile
echo -e "######################TelcoScriptPremium#######################" | lolcat' >> .profile
echo 'echo -e ""' >> .profile
echo 'echo -e "Whats New On V.1.3 ?" | lolcat' >> .profile
echo 'echo -e ""' >> .profile
echo 'echo -e "* Fixed Bug On Squid Proxy" | lolcat' >> .profile
echo 'echo -e "* Fixed Bug On OpenVPN" | lolcat' >> .profile
echo 'echo -e "* Fixed Bug On Check Port" | lolcat' >> .profile
echo 'echo -e "* Add New Fitur : contact, statport & update" | lolcat' >> .profile
echo 'echo -e "* Update README.md on Github Repo With Minimalist" | lolcat' >> .profile
echo 'echo -e "* Added Lolcat" | lolcat' >> .profile
echo 'echo -e "* Added Confirm Before Create Account" | lolcat' >> .profile
echo 'echo -e "* Added Config OpenVPN Instagram" | lolcat' >> .profile
echo 'echo -e ""' >> .profile
echo 'echo -e "For reporting bug or issues chat me on Telegram : t.me//anakjati567" | lolcat' >> .profile
echo 'echo -e ""' >> .profile

rm -rf /root/redoxxovpn
rm /root/deb9.sh
port
success
restart ~/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile

# Confirm Install Script
else
                echo -e ""
fi
