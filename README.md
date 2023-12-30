# System Monitoring Script Documentation

## Overview

This Bash script, named `bot.sh`, is developed for proactive system monitoring, specifically targeting CPU, memory, and file system usage. The script incorporates a Telegram alert mechanism to notify administrators when predefined resource thresholds are exceeded.

## Configuration

### Telegram Configuration

- `TELEGRAM_BOT_TOKEN`: The Telegram Bot Token required for bot authentication.
- `TELEGRAM_CHAT_ID`: The Chat ID designating the recipient of alert messages.

### Thresholds

- `CPU_THRESHOLD`: The upper limit of acceptable CPU usage (percentage).
- `MEMORY_THRESHOLD`: The maximum permissible memory usage (percentage).
- `FILE_SYSTEM_THRESHOLD`: The threshold for high file system usage (percentage).

### File System Configuration

- `FILE_SYSTEM_PATH`: The path of the specific file system to monitor.
- `LOG_FILE`: The complete path of the log file where script outputs are recorded.

## Functions

### `check_cpu()`

This function employs the `top` command to calculate current CPU usage and raises an alert if it surpasses the predefined threshold.

### `check_memory()`

Using the `free` command, this function determines the system's memory usage and triggers an alert if it exceeds the specified threshold.

### `check_file_size()`

Monitors the file system specified by `FILE_SYSTEM_PATH` using `df` to identify usage percentage, triggering an alert if it surpasses the predefined threshold.

### `send_telegram_alert(message)`

Utilizes the Telegram Bot API to send alerts with custom messages to the designated chat.

### `log(message)`

Appends log entries, including timestamps, to the specified log file.

### `main()`

The main execution loop that continually monitors CPU, memory, and file system usage, invoking the relevant check functions.

## Usage

1. **Configuration**: Adjust the Telegram settings, thresholds, file system path, and log file path in the script.
2. **Permissions**: Ensure the script has adequate permissions to access system information and write to the log file.
3. **Execution**: Run the script using the command `./bot.sh`.

```bash
sudo bash bot.sh
```

## Dependencies

1. `curl`: Required for sending alerts to Telegram.
2. `bc`: Essential for floating-point arithmetic used in threshold comparisons.

## Notes

- **Continuous Monitoring**: The script operates in an infinite loop to provide continuous monitoring.
- **Resource Consumption**: Be mindful of the script's resource consumption, especially when running on resource-constrained systems.

## References

- [Telegram Bot API](https://core.telegram.org/bots)</s>

## Contribute

- Source Code: Source Code is written by [uaytug](https://github.com/uaytug)
