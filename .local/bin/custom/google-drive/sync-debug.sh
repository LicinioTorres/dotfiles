#!/usr/bin/env bash

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

echo -ne "$NOW Register Log in File? (y,n) -> "
read LOG
#connection check
echo -ne "\r$NOW -> Check Connection? (y,n) -> " 
read concheck
if [[ "$concheck" == "y" ]]; then
  echo -e "$NOW -> Checking Connection to Google Drive"
  if ! ping -c 1 -W 1 googleapis.com; then
    echo -e "$NOW -> Not Connected"
    echo -ne "\nProceed? (y,n) -> "
    read prof
    echo -e "\n"
    if [[ "$prof" == "n" ]]; then
      exit 0
    fi
  else 
    echo -e "$NOW -> Connected"
  fi
fi

#safety check for safety file
echo -ne "\n$NOW -> Check Safety File? (y,n) -> "
read safetycheck
echo -e "$NOW -> Safety File name -> $SAFETY_FILE"
if [[ "$safetycheck" == "y" ]]; then
  if [[ ! -f "$LOCAL_PATH/$SAFETY_FILE" ]]; then
    echo -e "$NOW Local Safety File Not Found at\n"
    echo -e "-> $LOCAL_PATH/$SAFETY_FILE"
    echo -ne "\nProceed? (y,n) -> "
    read prof
    echo -e "\n"
    if [[ "$prof" == "n" ]]; then
      exit 0
    fi
  else
  echo -e "$NOW Local Safety File Found\n" 
  fi

  #Remote Safety File Checking
  if ! rclone ls "$REMOTE_SAFETY"; then
    echo -e "$NOW Remote Safety File Not Found at\n"
    echo -e "-> $REMOTE_SAFETY"
    echo -ne "\nProceed? (y,n) -> "
    read prof
    echo -e "\n"
    if [[ "$prof" == "n" ]]; then
      exit 0
    fi
    echo -e "$NOW Local Safety File Found\n" 
  fi
fi



echo -e "$NOW -> Starting Bisync\n"
#rclone command
if [[ "$LOG" == "n" ]]; then
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
    --dry-run \
    --timeout 20s \
    --exclude-from "$IGNORE_PATH" \
    -MvvP  
else
    rclone bisync "$REMOTE_PATH" "$LOCAL_PATH" \
    --check-access \
    --log-file $LOG_PATH \
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
    --dry-run \
    --timeout 20s \
    -MvvP && echo -e "$NOW Log taken at $LOG_PATH" || echo -e "Error"
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
