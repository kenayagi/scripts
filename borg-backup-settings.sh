#!/usr/bin/env bash
# Set here your preferences for the script in /usr/local/bin/borg-backup.sh

# Mandatory settings
export BORG_PASSPHRASE="YourPassword"
BORG_REPOSITORY="ssh://root@borg.YourDomain:2222/opt/borg/YourPath"
BORG_SOURCE="/"

# Data retention
BORG_KEEP_DAILY="14"
BORG_KEEP_WEEKLY="6"
BORG_KEEP_MONTHLY="1"
