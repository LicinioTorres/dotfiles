#!/usr/bin/env bash

# CPU usage
read cpu a b c idle rest < /proc/stat
prev_idle=$idle
prev_total=$((a+b+c+idle))

sleep 1

read cpu a b c idle rest < /proc/stat
total=$((a+b+c+idle))
diff_total=$((total-prev_total))
diff_idle=$((idle-prev_idle))

usage=$(( (100*(diff_total-diff_idle))/diff_total ))

# CPU temperature
temp=$(sensors 2>/dev/null | awk '
/Package id 0/ {print $4; exit}
/Tctl/ {print $2; exit}
/CPU Temp/ {print $3; exit}
')

[ -z "$temp" ] && temp="N/A"

# Fan speed
fan=$(sensors 2>/dev/null | awk '
/cpu_fan:/ {
print $2 " RPM"
exit
}')

[ -z "$fan" ] && fan="N/A"

# Physical core count
cores=$(lscpu -p=core | grep -v '^#' | sort -u | wc -l)

# Per-core usage
core_usage=""

for ((i=0;i<cores;i++)); do
    read -r cpu user nice system idle rest < <(grep "^cpu$i " /proc/stat)

    total1=$((user+nice+system+idle))
    idle1=$idle

    sleep 0.1

    read -r cpu user nice system idle rest < <(grep "^cpu$i " /proc/stat)

    total2=$((user+nice+system+idle))
    idle2=$idle

    diff_total=$((total2-total1))
    diff_idle=$((idle2-idle1))

    usage_core=$((100*(diff_total-diff_idle)/diff_total))

    # Per-core temperature from sensors
    core_temp=$(sensors 2>/dev/null | awk -v core="$i" '
    $1 == "Core" && $2 == core ":" {print $3; exit}
    ')
    [ -z "$core_temp" ] && core_temp="N/A"

    core_usage+="Core $i: ${usage_core}% | ${core_temp}\n"
done

# Waybar output
tooltip="󰍛 CPU\nTemp: $temp\nFan: $fan\n\n$core_usage"

printf '%s\n' "{\"text\":\"  󰍛 ${usage}% |  ${temp}\",\"tooltip\":\"${tooltip}\"}"
