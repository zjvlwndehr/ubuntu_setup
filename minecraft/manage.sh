#!/bin/bash
cd /home/minecraft
echo "1 > start server.jar (minecraft server)"
echo "2 > crontab backup.sh config"
read query
if [ ${query} -eq "1" ]
then
        echo "type memsize default(20G, MAX=20G)"
        read mem
        #if [ -z "${mem}" || $((mem)) > 20 ]
        if [ -z "${mem}" ] || [ `expr $mem` -gt 20 ]
        then
                echo "start minecraft server."
                echo "java -Xms1024M -Xmx20G -jar server.jar nogui"
        else
                echo "$((mem))G will be allocated"
                echo "java -Xms1024M -Xmx${mem}G -jar server.jar nogui"
        fi
elif [ ${query} -eq "2" ]
then
        echo "type when to execute backup.sh"
        echo "shape: * * * * * (minute - hour - date - month - day)"
        crontab -l > /home/minecraft/tools/crontab_bak.txt
        read cron
        crontab -e
        echo "[ Backup ] /home/minecraft/tools/bacup.sh"
        ${cron} /home/minecraft/tools/bacup.sh

        echo "crontab -e ${cron} /home/minecraft/tools/bacup.sh"
fi