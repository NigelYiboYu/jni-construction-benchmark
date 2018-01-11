

numActiveCPU=4

if [[ "$#" -ge "1" ]]; then
	numActiveCPU=$1
fi

echo "Turning on $numActiveCPU CPUs"

CPU_NUM=0

while [ -f "/sys/devices/system/cpu/cpu$CPU_NUM/online" ]; do

	if [[ $CPU_NUM -lt $numActiveCPU ]]; then
		echo turning on $CPU_NUM
		echo 1 > "/sys/devices/system/cpu/cpu$CPU_NUM/online"
	else
		echo turning off $CPU_NUM
		echo 0 > "/sys/devices/system/cpu/cpu$CPU_NUM/online"
	fi
	

	CPU_NUM=$[$CPU_NUM+1]
	
done


