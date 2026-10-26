#!/bin/bash

ID=$(id -un)

if [ "$ID" != "apache" ]; then
  echo "ERROR: must run as apache (e.g: sudo -u apache)"
  exit 2
fi

if [ "$1" == "stop" ]; then

  pkill -f "manage.py qcluster"

fi

if [ "$1" == "start" ]; then

  PYTHONPATH=$(deploy/tools/python_path)
  export PYTHONPATH
  RELEASE_YEAR=$(grep -oiP 'RELEASE\s*=\s*"?\K[0-9]+' jaspar/wsgi.py)
  export DJANGO_SETTINGS_MODULE="jaspar.settings${RELEASE_YEAR}"

  pgrep -f "manage.py qcluster" && echo "ERROR: qcluster already running" && exit 1
  nohup python manage.py qcluster >/tmp/qcluster.log 2>&1 &

fi
