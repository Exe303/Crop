#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
############MDX NETWORK#############
GitUser="perizinan" 
# // MY IPVPS 
export MYIP=$(curl -sS ipv4.icanhazip.com) 
 
# // GETTING 
VALIDITY () { 
    today=date -d "0 days" +"%Y-%m-%d" 
    Exp1=$(curl -sS https://raw.githubusercontent.com/Exe303/izin/main/ipvps.conf | grep $MYIP | awk '{print $3}') 
    if [[ $today < $Exp1 ]]; then 
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m" 
    else 
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m"; 
    echo -e "\e[31mPlease renew your ipvps first\e[0m" 
    exit 0 
fi 
} 
IZIN=$(curl -sS https://raw.githubusercontent.com/Exe303/izin/main/ipvps.conf | awk '{print $2}' | grep $MYIP) 
if [ $MYIP = $IZIN ]; then 
echo -e "\e[32mPermission Accepted...\e[0m" 
VALIDITY 
else 
echo -e "\e[31mPermission Denied!\e[0m"; 
echo -e "\e[31mPlease buy script first\e[0m" 
exit 0 
fi 
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
#System version number
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
mkdir -p /etc/xray

echo -e "[ ${tyblue}NOTES${NC} ] AUTO INSTALL SCRIPT.... "
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] Multi path, Multi port, support debian 10 , Ubuntu 20-18"
sleep 2
echo -e "[ ${green}INFO${NC} ] BY KANG MARDHEX"
sleep 1
echo -e "[ ${green}INFO${NC} ] WWW.MDXCLOUD.NET"
sleep 1
echo -e "[ ${green}INFO${NC} ] https://t.me/mdxdev"
sleep 1
echo -e "[ ${green}INFO${NC} ] Whatsapp : 085233695295"
sleep 1

secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1

coreselect=''
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
END
chmod 644 /root/.profile

echo -e "[ ${green}INFO${NC} ] Preparing the install file ðŸ› "
apt install git curl -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] Alright good ... installation file is ready ðŸ“¡"
sleep 2
echo -ne "[ ${green}INFO${NC} ] Check permission : success..!!!"
sleep 3
mkdir -p /etc/mdxnetwork
mkdir -p /etc/mdxnetwork/theme
mkdir -p /var/lib/mdxnetwork-pro >/dev/null 2>&1
echo "IP=" >> /var/lib/mdxnetwork-pro/ipvps.conf

if [ -f "/etc/xray/domain" ]; then
echo ""
echo -e "[ ${green}INFO${NC} ] Script Already Installed"
echo -ne "[ ${yell}WARNING${NC} ] Do you want to install again ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
rm setup.sh
sleep 10
exit 0
else
clear
fi
fi

echo ""
wget -q https://raw.githubusercontent.com/Exe303/Crop/main/FILE/dependencies.sh;chmod +x dependencies.sh;./dependencies.sh
rm dependencies.sh
clear

yellow "Add Your Domain"
echo " "
read -rp "Input your domain : " -e pp
echo "$pp" > /root/domain
echo "$pp" > /root/scdomain
echo "$pp" > /etc/xray/domain
echo "$pp" > /etc/xray/scdomain
echo "IP=$pp" > /var/lib/mdxnetwork-pro/ipvps.conf

#THEME RED
cat <<EOF>> /etc/mdxnetwork/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
#THEME BLUE
cat <<EOF>> /etc/mdxnetwork/theme/blue
BG : \E[40;1;44m
TEXT : \033[0;34m
EOF
#THEME GREEN
cat <<EOF>> /etc/mdxnetwork/theme/green
BG : \E[40;1;42m
TEXT : \033[0;32m
EOF
#THEME YELLOW
cat <<EOF>> /etc/mdxnetwork/theme/yellow
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
#THEME MAGENTA
cat <<EOF>> /etc/mdxnetwork/theme/magenta
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
#THEME CYAN
cat <<EOF>> /etc/mdxnetwork/theme/cyan
BG : \E[40;1;46m
TEXT : \033[0;36m
EOF
#THEME CONFIG
cat <<EOF>> /etc/mdxnetwork/theme/color.conf
blue
EOF
#install ssh ovpn
echo -e "${tyblue}.------------------------------------------.${NC}"
echo -e "${tyblue}|     PROCESS INSTALLED SSH & OPENVPN      |${NC}"
echo -e "${tyblue}'------------------------------------------'${NC}"
sleep 2
clear
wget https://raw.githubusercontent.com/Exe303/Crop/main/FILE/SSH/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
#Install Xray
echo -e "${tyblue}.------------------------------------------.${NC}"
echo -e "${tyblue}|          PROCESS INSTALLED XRAY          |${NC}"
echo -e "${tyblue}'------------------------------------------'${NC}"
sleep 2
clear
wget https://raw.githubusercontent.com/Exe303/Crop/main/FILE/XRAY/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
#Install SSH Websocket
echo -e "${tyblue}.------------------------------------------.${NC}"
echo -e "${tyblue}|      PROCESS INSTALLED WEBSOCKET SSH     |${NC}"
echo -e "${tyblue}'------------------------------------------'${NC}"
sleep 2
clear
wget https://raw.githubusercontent.com/Exe303/Crop/main/FILE/WEBSOCKET/insshws.sh && chmod +x insshws.sh && ./insshws.sh
#Install SSH Udp
echo -e "${tyblue}.------------------------------------------.${NC}"
echo -e "${tyblue}|      PROCESS INSTALLED UDPCUSTOM SSH     |${NC}"
echo -e "${tyblue}'------------------------------------------'${NC}"
sleep 2
clear
wget https://raw.githubusercontent.com/Exe303/Bless/main/Tunnel/udp.sh && bash udp.sh && chmod +x udp.sh
#Install OHP Websocket
echo -e "${tyblue}.------------------------------------------.${NC}"
echo -e "${tyblue}|          PROCESS INSTALLED OHP           |${NC}"
echo -e "${tyblue}'------------------------------------------'${NC}"
sleep 2
clear
wget https://raw.githubusercontent.com/Exe303/Crop/main/FILE/OPENVPN/ohp.sh && chmod +x ohp.sh && ./ohp.sh
#Install AutoBackup
echo -e "${tyblue}.------------------------------------------.${NC}"
echo -e "${tyblue}|          PROCESS INSTALLED AUTO BACKUP           |${NC}"
echo -e "${tyblue}'------------------------------------------'${NC}"
sleep 2
clear
wget https://raw.githubusercontent.com/Exe303/Crop/main/backup/set-br.sh && chmod +x set-br.sh && ./set-br.sh
#Download Extra Menu
echo -e "${tyblue}.------------------------------------------.${NC}"
echo -e "${tyblue}|           DOWNLOAD EXTRA MENU            |${NC}"
echo -e "${tyblue}'------------------------------------------'${NC}"
sleep 2
clear
wget https://raw.githubusercontent.com/Exe303/Crop/main/FILE/MENU/update.sh && chmod +x update.sh && ./update.sh
clear
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile

if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/Exe303/Crop/main/FILE/version )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
curl -sS ifconfig.me > /etc/myipvps
cat > /usr/bin/deltr << END
#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
#GREEN='\033[0;32m'
#ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
#CYAN='\033[0;36m'
LIGHT='\033[0;37m'
off='\x1b[m'
# ==========================================
# Getting

clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#tr " "/etc/xray/trojan.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	echo ""
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo "     No  Expired   User"
	grep -E "^#tr " "/etc/xray/trojan.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
CLIENT_NAME=$(grep -E "^#tr " "/etc/xray/trojan.json" | cut -d ' ' -f 2-3 | sed -n "${CLIENT_NUMBER}"p)
user=$(grep -E "^#tr " "/etc/xray/trojan.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#tr " "/etc/xray/trojan.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^#tr $user $exp/,/^},{/d" /etc/xray/trojan.json
systemctl restart trojan.service
service cron restart
clear
echo ""
echo "============================"
echo "  Trojan Account Deleted  "
echo "============================"
echo "Username : $user"
echo "Expired  : $exp"
echo "============================"
echo "ENJOY OUR AUTO SCRIPT PREMIUM"

END

cat > /usr/bin/xp-tr << END
data=( `cat /etc/xray/trojan.json | grep '^#tr' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^#tr $user" "/etc/xray/trojan.json" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^#tr $user $exp/,/^},{/d" /etc/xray/trojan.json
sed -i "/^#tr $user $exp/,/^},{/d" /etc/xray/trojan.json
fi
done
systemctl restart trojan.service

END

cat > /usr/bin/addtr << END
domain=$(cat /etc/xray/domain)
read -p "Username : " Username;
Username="$(echo ${Username} | sed 's/ //g' | tr -d '\r' | tr -d '\r\n' )";

# // Validate Input
if [[ $Username == "" ]]; then
    clear;
    echo -e "${ERROR} Please Input an Username !";
    sleep 1;
    addtr;
fi

# // Checking User already on vps or no
if [[ "$( cat /etc/xray/trojan.json | grep -w ${Username})" == "" ]]; then
    Do=Nothing;
else
    clear;
    echo -e "${ERROR} User ( ${YELLOW}$Username${NC} ) Already Exists !";
    sleep 1;
    addtr;
fi
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray-tr$/a\#tr '"tr-$Username $exp"'\
},{"password": "'""tr-$Username""'","email": "'""$Username""'"' /etc/xray/trojan.json
systemctl restart trojan
trojanlink2="trojan://tr-${Username}@${domain}:8443?security=tls&alpn=http/1.1&headerType=none&type=tcp&sni=bug.com#${Username}"
clear
echo -e "" | tee -a /etc/$Auther/log.db
echo -e "=============-TROJAN-============"
echo -e "Remarks         : ${Username}"
echo -e "Host/IP         : ${domain}"
echo -e "port TrojanGFW  : 8443"
echo -e "TROJAN GFW KEY  : tr-$Username"
echo -e "================================="
echo -e " TROJAN TCP/GFW : ${trojanlink2}"
echo -e "================================="
echo -e "Expired On      : $exp"
END

chmod +x /usr/bin/*

cat > /etc/systemd/system/trojan.service << END
[Unit]
Description=Xray Trojan Service By FERI
Documentation=https://t.me/FER1DEV
After=network.target nss-lookup.target

[Service]
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray -config /etc/xray/trojan.json
Restart=on-failure
RestartPreventExitStatus=23

[Install]
WantedBy=multi-user.target
END

# // json nya tuan
touch /etc/xray/access.log
touch /etc/xray/error.log
export domen=$(cat /etc/xray/domain)
cat > /etc/xray/trojan.json << END
{
  "log": {
    "access": "/etc/xray/access.log",
    "error": "/etc/xray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 8443,
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "testing"
#xray-tr
          }
        ],
        "fallbacks": [
          {
            "dest": 80
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/xray/xray.crt",
              "keyFile": "/etc/xray/xray.key"
            }
          ],
          "alpn": [
            "http/1.1"
          ]
        },
        "tcpSettings": {},
        "kcpSettings": {},
        "wsSettings": {},
        "httpSettings": {},
        "quicSettings": {},
        "grpcSettings": {}
      },
      "domain": "$domen"
     }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  },
  "stats": {},
  "api": {
    "services": [
      "StatsService"
    ],
    "tag": "api"
  },
  "policy": {
    "levels": {
      "0": {
        "statsUserDownlink": true,
        "statsUserUplink": true
      }
    },
    "system": {
      "statsInboundUplink": true,
      "statsInboundDownlink": true
    }
  }
}
END

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8443 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8443 -j ACCEPT
systemctl enable trojan
systemctl restart trojan


echo " "
echo "Installation has been completed!!"
echo " "
echo "=========================[SCRIPT PREMIUM]========================"
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI SSH ]" | tee -a log-install.txt
echo "    -------------------------" | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - Stunnel4                : 447, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 109, 143"  | tee -a log-install.txt
echo "   - SSH Websocket           : 80"  | tee -a log-install.txt
echo "   - SSH SSL Websocket       : 443"  | tee -a log-install.txt
echo "   - SSH UDP Custom          : 1-65350"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI  Badvpn, Nginx]" | tee -a log-install.txt
echo "    ---------------------------" | tee -a log-install.txt
echo "   - Badvpn                  : 7100-7900"  | tee -a log-install.txt
echo "   - Nginx                   : 81"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI Shadowsocks-R & Shadowsocks]"  | tee -a log-install.txt
echo "    ---------------------------------------" | tee -a log-install.txt
echo "   - Websocket Shadowsocks   : 443"  | tee -a log-install.txt
echo "   - Shadowsocks GRPC        : 443"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI XRAY]"  | tee -a log-install.txt
echo "    ----------------" | tee -a log-install.txt
echo "   - Xray Vmess Ws Tls       : 443"  | tee -a log-install.txt
echo "   - Xray Vless Ws Tls       : 443"  | tee -a log-install.txt
echo "   - Xray Vmess Ws None Tls  : 80"  | tee -a log-install.txt
echo "   - Xray Vless Ws None Tls  : 80"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    [INFORMASI TROJAN]"  | tee -a log-install.txt
echo "    ------------------" | tee -a log-install.txt
echo "   - Websocket Trojan        : 443"  | tee -a log-install.txt
echo "   - Trojan GRPC             : 443"  | tee -a log-install.txt
echo "   - Trojan GFW              : 8443"  | tee -a log-install.txt
echo "   --------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Auto Reboot On          : $aureb:00 $gg GMT +7" | tee -a log-install.txt
echo "   - Custom Path " | tee -a log-install.txt
echo "   - Auto Backup Data" | tee -a log-install.txt
echo "   - AutoKill Multi Login User" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Fully Automatic Script" | tee -a log-install.txt
echo "   - VPS Settings" | tee -a log-install.txt
echo "   - Admin Control" | tee -a log-install.txt
echo "   - Backup & Restore Data" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "======================[SCRIPT PREMIUM BY MARDHEX]====================="
echo ""
sleep 3
echo -e "    ${tyblue}.------------------------------------------.${NC}"
echo -e "    ${tyblue}|     SUCCESFULLY INSTALLED THE SCRIPT     |${NC}"
echo -e "    ${tyblue}'------------------------------------------'${NC}"
echo ""
echo -e "   ${tyblue}Server Reboot 10 Detik${NC}"
rm /root/cf.sh >/dev/null 2>&1
rm /root/setup.sh >/dev/null 2>&1
rm /root/insshws.sh
rm /root/udp.sh 
rm /root/update.sh
sleep 10
reboot
