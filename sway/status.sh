color_green='\033[0;32m'
color_yellow='\033[0;33m'
color_red='\033[0;31m'
color_normal='\033[0m'

date_time=$(date +"%Y-%m-%d %I:%M:%S %p")

temp_file=/sys/class/hwmon/hwmon1/temp1_input
temp=$(cat /sys/class/hwmon/hwmon1/temp1_input | awk '{print $1/1000}')
if [ "$temp" le 45.0 ]
then
  temp_color=$color_green
elif [ "$temp" le 70.0 ]
then
  temp_color=$color_yellow
else
  temp_color=$color_red
fi

# coloring doesn't work on sway-bar
temp=$(echo $temp | awk '{printf("%3.1f", $1)}')

disk=$(df -h | awk '$NF == "/" { print $4, $5 }')

mem=$(free -m | awk '/Mem:/ { printf("%3.1fGb/%3.1fGb\n", $6/1024, $2/1024) }')

echo -e "Disk(/): $disk | Mem: $mem | T: $temp °C | $date_time"
