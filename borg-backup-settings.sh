#!/usr/bin/env bash
# Set here your preferences for the script in /usr/local/bin/borg-backup.sh

# Mandatory settings
export BORG_PASSPHRASE="YourPassword"
export BORG_REPOSITORY="ssh://root@borg.YourDomain:2222/backups/YourPath"
BORG_SOURCE="/"

# Data retention
BORG_KEEP_DAILY="14"
BORG_KEEP_WEEKLY="2"
BORG_KEEP_MONTHLY="0"
