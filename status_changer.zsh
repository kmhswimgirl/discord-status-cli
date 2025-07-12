#!/bin/zsh

# auth token
AUTH_TOKEN=$(cat ~/.discord_api_key)

# Default Value
EMOJI_NAME=""
STATUS_TEXT="probably made a typo somewhere"

while getopts "e:t:" opt; do
  case $opt in
    e) EMOJI_NAME="$OPTARG" ;;
    t) STATUS_TEXT="$OPTARG" ;;
    *) echo "Usage: $0 [-e emoji] [-t status_text]"; exit 1 ;;
  esac
done

# Build JSON payload
PAYLOAD=$(cat <<EOF
{
  "custom_status": {
    "text": "$STATUS_TEXT",
    "emoji_name":"$EMOJI_NAME"
  }
}
EOF
)

curl -s -X PATCH https://discord.com/api/v9/users/@me/settings \
    -H "Authorization: $AUTH_TOKEN" \
    -H "Content-Type: application/json" \
    -d "$PAYLOAD" > /dev/null

echo "\e[1;35m$DISCORD_USERNAME's status set to:\e[0m $EMOJI_NAME $STATUS_TEXT"