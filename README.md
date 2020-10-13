# Xtrabackup 2.4 with qpress
Dockerfile for Percona Xtrabackup 2.4 with qpress for decompressing

# How to CREATE backup
```
 run -it --rm \
  -v /local/backupdir:/backupdir \
  -v /local/my.cnf.d:/etc/my.cnf.d:ro \
  -v /local/lib/mysql:/var/lib/mysql:ro \
  --entrypoint=/bin/bash \
  1kmenu/xtrabackup-24-qpress \
  -c "innobackupex \
      --host='HOST' \
      --user='USER' \
      --password='PASSWORD' \
      --compress \
      --stream=xbstream \
      /backupdir > /backupdir/backup_file_name"
```

# How to RESTORE backup

## Extract xbstream
```
docker run -it --rm -v /local/backupdir:/backupdir --entrypoint=/bin/bash  1kmenu/xtrabackup-24-qpress -c "xbstream -x < backup_file_name"
```

## Decompress qp files
```
docker run -it --rm -v /local/backupdir:/backupdir 1kmenu/xtrabackup-24-qpress --decompress /backupdir
```

## Apply logs
```
docker run -it --rm -v /local/backupdir:/backupdir 1kmenu/xtrabackup-24-qpress --apply-log /backupdir
```

## Delete qp files
```
find /local/backupdir -name "*.qp" -delete
```

## Permissions
Update folder permissions according to your system settings. This works with percona:5.7 in docker environment
```
chown -R 999:999 /local/backupdir
```

## Done
Now your /local/backupdir is ready to be used as /var/lib/mysql. You can use it as volume in docker or copy it locally via:
```
xtrabackup --copy-back --target-dir=/local/backupdir
```
