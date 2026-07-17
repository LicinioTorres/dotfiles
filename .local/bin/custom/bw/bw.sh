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

bw_unlock() {
  while true; do
    PASSPHRASE="$(printf ''| rofi -dmenu -theme bw-password -password -p PIN)"

    #Escape
    [[ $? -ne 0 ]] && exit 1

    #Pin Inserted
    [[ -z "$PASSPHRASE" ]] && rofi -e "Please Insert Passphrase" && continue

    if BW_PASSWORD="$(gpg --batch --pinentry-mode loopback --passphrase "$PASSPHRASE" --quiet --decrypt "$BW_PASSWORD_PATH" 2>/dev/null)"; then
      export BW_PASSWORD
      bw_rofi
      exit 0
    fi
    rofi -e "Incorrect Passphrase"
  done
}

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
    # Refresh cache if needed
    #   No Vault Found
    if [ ! -f "$BW_CACHE_PATH" ]; then
        bw_refresh_cache || exit 1
    fi
    # Every Week
    if find "$BW_CACHE_PATH" -mtime +7 | grep -q .; then
        bw_refresh_cache || exit 1
    fi

    # Decrypt into local
    local vault
    vault=$(gpg --batch \
        --pinentry-mode loopback \
        --passphrase "$PASSPHRASE" \
        --quiet \
        --decrypt "$BW_CACHE_PATH") || { rofi -e "Failed to decrypt vault"; return 1; }

    # Step 1: pick an item
    local selection
    selection=$(echo "$vault" | jq -r '.[] | select(.login.username != null) | "\(.name) (\(.login.username))"' |
        rofi -dmenu -p "Bitwarden")

    [[ -z "$selection" ]] && return 0

    # Map selection back to the item's id (exact match on "name (username)")
    local id
    id=$(echo "$vault" | jq -r --arg sel "$selection" '
        .[] | select("\(.name) (\(.login.username))" == $sel) | .id
    ' | head -n1)

    [[ -z "$id" || "$id" == "null" ]] && { rofi -e "Item not found"; return 1; }

    # Step 2: pick a field
    local choice
    choice=$(printf "Username\nPassword\nTOTP\n" | rofi -dmenu -p "Bitwarden")

    case "$choice" in
        Username)
            echo "$vault" | jq -r --arg id "$id" '.[] | select(.id==$id) | .login.username' | wl-copy
            ;;
        Password)
            echo "$vault" | jq -r --arg id "$id" '.[] | select(.id==$id) | .login.password' | wl-copy
            cliphist list | sed -i '$d' ~/.cache/cliphist/db
            ;;
        TOTP)
            if [ -z "$BW_SESSION" ]; then
                export BW_SESSION="$(bw unlock --passwordenv BW_PASSWORD --raw)" || { rofi -e "Failed to unlock session for TOTP"; return 1; }
            fi
            bw get totp "$id" --session "$BW_SESSION" | wl-copy
            ;;
    esac
}

bw_unlock


