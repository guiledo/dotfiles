#!/usr/bin/env bash

# This script enables the required systemd timers for Snapper to automatically
# take snapshots and clean them up based on the configuration limits.

echo "Enabling Snapper timeline and cleanup timers..."

sudo systemctl enable --now snapper-timeline.timer
sudo systemctl enable --now snapper-cleanup.timer

echo "Snapper services enabled successfully."
