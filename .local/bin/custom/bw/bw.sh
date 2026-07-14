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

while true; do
  PASSPHRASE="$(printf ''| rofi -dmenu -theme bw-password -password -p PIN)"

  #Escape
  [[ $? -ne 0 ]] && exit 1

  #Pin Inserted
  [[ -z "$PASSPHRASE" ]] && rofi -e "Please Insert Passphrase" && continue

  if BW_PASSWORD="$(gpg --batch --pinentry-mode loopback --passphrase "$PASSPHRASE" --quiet --decrypt "$BW_PASSWORD_PATH" 2>/dev/null)"; then
    export BW_PASSWORD
    break
  fi
  rofi -e "Incorrect Passphrase"
done

# Make a encrypted Vault Cache
bw_refresh_cache() {
    # Unlock if needed
    if [ -z "$BW_SESSION" ]; then
        export BW_SESSION="$(bw unlock --passwordenv BW_PASSWORD --raw)" || return 1
    fi

    mkdir -p "$(dirname "$BW_CACHE_PATH")"

    bw list items --session "$BW_SESSION"|gpg \
    --batch \
    --yes \
    --encrypt \
    --recipient "$BW_KEY_ID" \
    --output "$BW_CACHE_PATH"
}


bw_rofi() {
    if [ ! -f "$BW_CACHE_PATH" ]; then
        bw_refresh_cache || return 1
    fi

    if find "$BW_CACHE_PATH" -mtime +7 | grep -q .; then
        bw_refresh_cache || return 1
    fi


    while true; do

        local items
        items=$(gpg --batch --pinentry-mode loopback --passphrase "$PASSPHRASE" --quiet --decrypt "$BW_CACHE_PATH" \
            | jq -r '
                .[]
                | select(.login != null)
                | "\(.name)\t\(.id)"
            ')


        local selected

        selected=$(echo "$items" \
            | cut -f1 \
            | rofi -dmenu \
                -i \
                -p "󰟵 BITWARDEN VAULT" \
                -kb-custom-1 "Alt+r")

        local rofi_status=$?


        # Alt+r refresh
        if [[ $rofi_status -eq 10 ]]; then
            bw_refresh_cache || rofi -e "Cache refresh failed"
            continue
        fi


        # Escape
        [[ $rofi_status -ne 0 ]] && return


        [ -z "$selected" ] && return


        local id
        id=$(echo "$items" \
            | awk -F'\t' -v name="$selected" '$1 == name {print $2}')


        local choice
        choice=$(printf "Username\nPassword\nTOTP\n" \
            | rofi -dmenu -p "$selected")


        case "$choice" in

            Username)
                gpg --batch --pinentry-mode loopback --passphrase "$PASSPHRASE" --quiet --decrypt "$BW_CACHE_PATH" \
                | jq -r --arg id "$id" '
                    .[]
                    | select(.id==$id)
                    | .login.username
                ' \
                | wl-copy
                ;;


            Password)
              gpg --batch --pinentry-mode loopback --passphrase "$PASSPHRASE" --quiet --decrypt "$BW_CACHE_PATH" \
                | jq -r --arg id "$id" '
                    .[]
                    | select(.id==$id)
                    | .login.password
                ' \
                | wl-copy --paste-once
                ;;


            TOTP)
                bw get totp "$id" --session "$BW_SESSION" \
                | wl-copy
                ;;

        esac

    done
}


bw_rofi
