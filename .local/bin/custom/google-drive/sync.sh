#!/usr/bin/env bash

#config
#---- Source Local Variables
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_SH="$SCRIPT_DIR/local.sh"

if [[ ! -f "$LOCAL_SH" ]]; then
    echo "Error: $LOCAL_SH not found." >&2
    echo "Copy local.sh.example to local.sh and configure it." >&2
    exit 1
fi

source "$LOCAL_SH"
NOW=$(date "+%H:%M:%S")


#Shutdown Function  
shutdownfun() {
  echo -e "$NOW -> \e[1;31m$2\e[0m"
  echo -e "\n$NOW -> Starting Shutdown..\n"
  local seconds=$1
  while [ $seconds -gt 0 ]; do
  echo -ne "\r$NOW Exiting in $seconds seconds..."
  sleep 1
  ((seconds--))
  done
  kill -9 $PPID
}

#safety check for safety file
if [[ ! -f "$LOCAL_PATH/$SAFETY_FILE" ]]; then
  notify-send "Safety File Not Found, Aborting Sync!"
  exit 1
fi

#connection check
echo -e "$NOW -> Checking Connection to Google Drive"
if ! ping -c 1 -W 1 googleapis.com &> /dev/null; then
  notify-send "Not connected"
  shutdownfun 3 "Connection Failed"
else 
  echo -e "$NOW -> Connected"
fi


echo -e "$SAFETY_FILE"
echo -e "$NOW -> Starting Bisync\n"
#rclone command
rclone bisync "$REMOTE_PATH" "$LOCAL_PATH" \
  --check-access \
  --check-filename "$SAFETY_FILE" \
  --create-empty-src-dirs \
  --compare size,modtime \
  --resilient \
  --recover \
  --max-lock 120 \
  --conflict-resolve newer \
  --conflict-loser pathname \
  --drive-skip-gdocs \
  --fix-case \
  --max-delete 2 \
  --timeout 20s \
  --exclude-from "$IGNORE_PATH" \
  -MP

status=$?

if [ $status -eq 0 ]; then
    notify-send "Sync Successful"
    echo -e "$NOW -> Operation Successful"
    echo -e "\n\033[1;32mSync Successful\033[0m\n"
    shutdownfun 5 "\n\033[1;32mSucess\033[0m\n"
else
    notify-send "Sync Failed"
    shutdownfun 5 "Bisync Error"
fi
  


# enable the safetu file checking
# sets safety file path
# allows creation of empty dirs
# dont compare checksum as it is slow
# allows recover from small errors
# recover from erros withou resync
# max lockfile time (seconds)
# in case of conflict newer file wins
# the loser is renamed with a .origin
# skip google docs
# unicode stuff
# max delete of 2% (safety feature)
# preserve Metadata, Verbose, Progress bar
