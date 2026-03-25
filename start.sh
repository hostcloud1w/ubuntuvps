#!/bin/bash

# Set non-interactive timezone
export DEBIAN_FRONTEND=noninteractive
ln -fs /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

# Install tmate and expect
apt-get update
apt-get install -y tmate expect

# Start tmate session
tmate -S /tmp/tmate.sock new-session -d
tmate -S /tmp/tmate.sock wait tmate-ready

# Print access links
echo "SSH access:"
tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'

echo "Web access:"
tmate -S /tmp/tmate.sock display -p '#{tmate_web}'

# Keep session alive forever
while true; do
    tmate -S /tmp/tmate.sock send-keys "echo alive && date" C-m
    sleep 60
done
