#!/bin/bash

report_file="system_report.txt"

# Get current date and time
current_date_time=$(date +"%Y-%m-%d %H:%M:%S")

# Get current user
current_user=$(whoami)

# Get internal IP address and hostname
internal_ip=$(hostname -I | awk '{print $1}')
hostname=$(hostname)

# Get external IP address (requires internet connection)
external_ip=$(curl -s ifconfig.me)

# Get name and version of Linux distribution
linux_distribution=$(lsb_release -d | cut -f2)

# Get system uptime
uptime_info=$(uptime -p)

# Get information about used and free space in / in GB
disk_info=$(df -h / | awk 'NR==2 {print "Used: "$3", Free: "$4}')

# Get information about total and free RAM
ram_info=$(free -h | awk 'NR==2 {print "Total: "$2", Free: "$4}')

# Get number and frequency of CPU cores
cpu_info=$(lscpu | grep -E 'Core\(s\)|MHz')

# Create the report
echo "System Report - $current_date_time" > "$report_file"
echo "---------------------------------------" >> "$report_file"
echo "User: $current_user" >> "$report_file"
echo "Internal IP: $internal_ip" >> "$report_file"
echo "Hostname: $hostname" >> "$report_file"
echo "External IP: $external_ip" >> "$report_file"
echo "Linux Distribution: $linux_distribution" >> "$report_file"
echo "Uptime: $uptime_info" >> "$report_file"
echo "Disk Space: $disk_info" >> "$report_file"
echo "RAM: $ram_info" >> "$report_file"
echo "CPU Info: $cpu_info" >> "$report_file"

echo "Report generated and saved to: $report_file"


