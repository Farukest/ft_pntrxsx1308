#!/bin/bash

ETH0_MAC=`cat /sys/class/net/eth0/address | sed 's/://g'`
MAC_PREFIX=`echo ${ETH0_MAC} | cut -c 1-6`
MAC_POST=`echo ${ETH0_MAC} | cut -c 7-`
REGION=`/usr/bin/region_uptd`
GATEWAY_ID="${MAC_PREFIX}fffe${MAC_POST}"
SEND_PORT=1681
echo ${GATEWAY_ID}

cd /usr/bin && ./sx1302_test_loragw_reg
if [ "$?" != "0" ]; then
    # Run SX1308 lora pkt fwd
    if [ "${REGION}" = "EU868" ]; then
		count=$(pgrep -c sx1308_lora_pkt_fwd)
		if [[ $count -gt 1 ]]; 
		then
		  echo "Killing that SX1308 pktwds.."
		  pgrep sx1308_lora_pkt_fwd | xargs kill
		fi
		
		if [[ $count -eq 1 ]]; 
		then 
			echo "ALREADY RUNNING SX1308";
		else
			sed "s/AABBCCFFFEDDEEFF/${GATEWAY_ID}/g" /home/ft/global_conf.json.sx1257.EU868.template > /etc/global_conf.json
			sed "s/send_port/${SEND_PORT}/g" /home/ft/global_conf.json.sx1257.EU868.template > /etc/global_conf.json
			/usr/bin/reset_lgw.sh start
			cd /usr/bin/ && ./sx1308_lora_pkt_fwd
		fi   
		
	
    else
        echo "SX1308 region error value: ${REGION}"
    fi
else
    if [ "${REGION}" = "EU868" ]; then
        # Run SX1302 lora pkt fwd
		count=$(pgrep -c sx1302_lora_pkt_fwd)
		
		if [[ $count -gt 1 ]]; 
		then
		  echo "Killing that SX1302 pktwds.."
		  pgrep sx1302_lora_pkt_fwd | xargs kill
		fi
		
		if [[ $count -eq 1 ]]; 
		then 
			echo "ALREADY RUNNING SX1302";
		else
			sed "s/AABBCCFFFEDDEEFF/${GATEWAY_ID}/g" /home/ft/global_conf.json.sx1250.EU868.template > /etc/global_conf.json
			sed "s/send_port/${SEND_PORT}/g" /home/ft/global_conf.json.sx1250.EU868.template > /etc/global_conf.json
			cd /usr/bin/ && ./sx1302_lora_pkt_fwd -c /etc/global_conf.json
		fi   
		

    else
        echo "SX1302 region error value: ${REGION}"
    fi
fi
		    

