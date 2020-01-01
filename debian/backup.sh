#!/bin/bash

BACKUP_DIR=/tmp/debian-backup
mkdir -p $BACKUP_DIR

mkdir -p $BACKUP_DIR/docker-trust-keys
cp $HOME/.docker/trust/private/* $BACKUP_DIR/docker-trust-keys/

cp -R $HOME/.aws $BACKUP_DIR/
cp -R $HOME/.azure $BACKUP_DIR/
cp -R $HOME/unifi-config $BACKUP_DIR/
cp $HOME/.extra $BACKUP_DIR/
cp $HOME/.extra_backup $BACKUP_DIR/
cp $HOME/.git-credentials $BACKUP_DIR/

tar cvzf debian-backup.tar.gz $BACKUP_DIR

rm -rf $BACKUP_DIR
