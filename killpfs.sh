cd /usr/bin && ./sx1302_test_loragw_reg
if [ "$?" != "0" ]; then
	echo "KILLED SX1308 ON KILLPFS"
    fwCount=$(pgrep -c sx1308_lora_pkt_fwd+)
else
	echo "KILLED SX1302 ON KILLPFS"
    fwCount=$(pgrep -c sx1302_lora_pkt_fwd+)
fi

if [[ $fwCount -gt 0 ]]; 
	then
	  echo "Killing all pktwds.."
	  pgrep lora_pkt_fwd+ | xargs kill
	else
	  echo "No current pktwd process"
fi
