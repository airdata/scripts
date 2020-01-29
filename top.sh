# Top Processes sorted by RAM or CPU
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head

#Top 15 Processes by Memory Usage with ‘top’
top -b -o +%MEM | head -n 22

top 5
ps -eo pmem,pcpu,vsize,pid,cmd | sort -k 1 -nr | head -5
