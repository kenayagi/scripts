#!/bin/bash
# Simple script to do system backups with https://github.com/borgbackup/borg
# First run with: ./borg-backup.sh init
# Latest version on https://raw.githubusercontent.com/kenayagi/scripts/master/borg-backup.sh

# Default values
BORG_VERSION="1.1.4"
BORG_PATH="/usr/local/bin/borg"
BORG_PREFIX="Backup-"
BORG_SUFFIX=`date +%Y-%m-%d`
BORG_CREATE_PARAMS="--compression zlib --exclude sh:/dev/* --exclude sh:/proc/* --exclude sh:/sys/* --exclude sh:/tmp/* --exclude sh:/run/* "

if [ ! -f "$BORG_PATH" ]; then
  wget https://github.com/borgbackup/borg/releases/download/$BORG_VERSION/borg-linux64 -O /usr/local/bin/borg
  chmod +x /usr/local/bin/borg
fi

# Load machine-specific settings from a separate file
source /usr/local/etc/borg-backup-settings.sh

if [ "$1" = "init" ]; then
  echo "Creating new repository..."
  $BORG_PATH init -e repokey $BORG_REPOSITORY
fi

$BORG_PATH create $BORG_CREATE_PARAMS $BORG_REPOSITORY::$BORG_PREFIX$BORG_SUFFIX $BORG_SOURCE

$BORG_PATH prune -v $BORG_REPOSITORY --keep-daily=$BORG_KEEP_DAILY --keep-weekly=$BORG_KEEP_WEEKLY --keep-monthly=$BORG_KEEP_MONTHLY --prefix=$BORG_PREFIX
