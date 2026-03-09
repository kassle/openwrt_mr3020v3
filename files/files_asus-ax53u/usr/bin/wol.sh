#!/bin/sh

# Check if TARGET_IP is provided as a parameter
if [ -z "$1" ]; then
  echo "Usage: $0 <target_ip> <target_mac>"
  exit 1
fi

TARGET_IP="$1"
TARGET_MAC="$2"

# Configuration
PING_COUNT=3
PING_TIMEOUT=2 # Timeout in seconds for each ping
WOL_PACKET="arp-ether" # or "wol" depending on your system and card

# Function to send a ping
ping_target() {
  ping -c 1 -W $PING_TIMEOUT "$TARGET_IP" 2>&1
}

# Function to send a Wake-on-LAN packet using etherwake
send_wol_packet() {
  echo "Sending Wake-on-LAN packet to MAC address $TARGET_MAC using etherwake..."
  etherwake -i br-lan "$TARGET_MAC"
  # Check the exit code to see if the packet was sent successfully
  if [ $? -eq 0 ]; then
    echo "Wake-on-LAN packet sent successfully using etherwake."
  else
    echo "Failed to send Wake-on-LAN packet using etherwake."
  fi
}

# Main script
echo "Checking connection to IP address $TARGET_IP..."

# Perform 3 pings
for i in $(seq 1 $PING_COUNT); do
  if ping_target &> /dev/null; then
    echo "Connection to IP address $TARGET_IP is established ($i)."
    # break  # Exit the loop if the connection is established
    exit 0
  else
    echo "Ping to IP address $TARGET_IP failed in attempt $i. Waiting..."
    sleep 5 # Wait 5 seconds before retrying. Adjust this delay as needed.
  fi
done

echo "IP address $TARGET_IP failed after multiple pings. Initiating Wake-on-LAN..."
send_wol_packet
