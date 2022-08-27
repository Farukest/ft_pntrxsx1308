ptCount=$(pgrep -c ftcollector+)

if [[ $ptCount -gt 0 ]]; 
	then
	  echo "Killing all collectors.."
	  pgrep ftcollector+ | xargs kill
	else
	  echo "No current collector process"
fi


ptCount=$(pgrep -c bridge+)

if [[ $ptCount -gt 0 ]]; 
	then
	  echo "Killing all bridges.."
	  pgrep bridge+ | xargs kill
	else
	  echo "No current bridge process"
fi
