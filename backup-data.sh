#!/bin/sh

timestamp=$(date +%s)

if [ ! -z "$1" ]; then
	filename="db_$1.zip"
else
	filename="db_$timestamp.zip"
fi

python manage.py dumpdata -e contenttypes -e auth.Permission  -e admin.LogEntry -e sessions > db.json

zip -qr "db/$filename" media db.json

rm -rf db.json

echo "$filename"