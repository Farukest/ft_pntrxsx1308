cd /usr/bin && ./sx1302_test_loragw_reg
if [ "$?" != "0" ]; then
	echo "KILLED SX1308 ON KILLPFS"
    fwCount=$(pgrep -c sx1308_lora+)
	process="sx1308_lora"
else
	echo "KILLED SX1302 ON KILLPFS"
    fwCount=$(pgrep -c sx1302_lora+)
	process="sx1302_lora"
fi

if [[ $fwCount -gt 0 ]]; 
	then
	  echo "Killing all pktwds.."
	  pgrep $process | xargs kill
	else
	  echo "No current pktwd process"
fi
