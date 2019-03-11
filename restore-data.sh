#!/bin/sh

if [ ! -z "$1" ]; then
    unzip -oq "db/$1"

    python manage.py loaddata db.json

    rm -rf db.json

    echo "Restore finished"
else
    echo "Please define a filename"
fi