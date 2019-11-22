# Top Processes sorted by RAM or CPU
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head

#Top 15 Processes by Memory Usage with ‘top’
top -b -o +%MEM | head -n 22
