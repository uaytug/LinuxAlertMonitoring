#!/bin/bash

#--------------------------TOKEN&ID-------------------------------
TELEGRAM_BOT_TOKEN="TELEGRAM_TOKEN"
TELEGRAM_CHAT_ID="TELEGRAM_CHAT_ID"
#--------------------------THRESHOLD-------------------------------
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
FILE_SYSTEM_THRESHOLD=80
#--------------------------FILESYSTEM-------------------------------
FILE_SYSTEM_PATH="/file/system/path"
LOG_FILE="/var/log/alert_monitor.log"

check_cpu() {
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
  log "CPU usage: $cpu_usage%"
  if [ $(echo "$cpu_usage >= $CPU_THRESHOLD" | bc -l) -eq 1 ]; then
    send_telegram_alert "CPU usage is high: $cpu_usage%"
    log "CPU usage exceeded threshold: $cpu_usage%"
  fi
}

check_memory() {
  memory_usage=$(free -m | awk 'NR==2{printf "%s", $3*100/$2}')
  log "Memory usage: $memory_usage%"
  if [ $(echo "$memory_usage >= $MEMORY_THRESHOLD" | bc -l) -eq 1 ]; then
    send_telegram_alert "Memory usage is high: $memory_usage%"
    log "Memory usage exceeded threshold: $memory_usage%"
  fi
}

check_file_size() {
  file_system_usage=$(df -h /filesystempath 2>/dev/null | awk 'NR==2 {printf "%s\t\t", $5}' | tr -d '%[:space:]')
  log "file system usage: $file_system_usage%"
    if ((file_system_usage >= FILE_SYSTEM_THRESHOLD)); then
      send_telegram_alert "file system usage is high: $file_system_usage%"
      log "file system usage exceeded threshold: $file_system_usage%"
    fi
}

send_telegram_alert() {
  message="$1"
  curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
    -d "chat_id=$TELEGRAM_CHAT_ID" \
    -d "text=$message"
}

log() {
  message="$1"
  echo "$(date) - $message" >> "$LOG_FILE"
}

main() {
  while true; do
    check_cpu
    check_memory
    check_file_size
  done
}

main


# MADE BY UAYTUG