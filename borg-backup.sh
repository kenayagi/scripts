#!/bin/bash
# Simple script to do system backups with https://github.com/borgbackup/borg
# First run with: ./borg-backup.sh init
# Latest version on https://raw.githubusercontent.com/kenayagi/scripts/master/borg-backup.sh

# Load settings from a separate file
source /usr/local/etc/borg-backup-settings.sh

# Probably, you won't need to edit below
BORG_VERSION="1.0.2"
BORG_PATH="/usr/local/bin/borg"
BORG_PREFIX="Backup-"
BORG_SUFFIX=`date +%Y-%m-%d_%H-%M-%S`
BORG_CREATE_PARAMS="-v --stats --compression zlib --exclude sh:/dev/* --exclude sh:/proc/* --exclude sh:/sys/* --exclude sh:/tmp/* --exclude sh:/run/* "

if [ ! -f "$BORG_PATH" ]; then
  wget https://github.com/borgbackup/borg/releases/download/$BORG_VERSION/borg-linux64 -O /usr/local/bin/borg
  chmod +x /usr/local/bin/borg
fi

if [ "$1" = "init" ]; then
  echo "Creating new repository..."
  $BORG_PATH init $BORG_REPOSITORY
fi

$BORG_PATH create $BORG_CREATE_PARAMS $BORG_REPOSITORY::$BORG_PREFIX$BORG_SUFFIX $BORG_SOURCE

$BORG_PATH prune -v $BORG_REPOSITORY --keep-daily=$BORG_KEEP_DAILY --keep-weekly=$BORG_KEEP_WEEKLY --keep-weekly=$BORG_KEEP_MONTHLY --prefix=$BORG_PREFIX
