#!/bin/ash
curl -o ./ip.txt http://members.3322.org/dyndns/getip
myip=$(cat ./ip.txt)
myOldIp=$(cat oldIp.txt)
if [ ${myip} != ${myOldIp} ]
then
curl -o ./status.txt http://www.3dant.cn/index.php/Home/Dns/updateDns?id=$1\&ip=${myip}\&pw=$2
status=$(cat ./status.txt)
cp -f ./ip.txt ./oldIp.txt
echo ${status}
fi
