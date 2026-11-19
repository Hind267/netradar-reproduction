#!/usr/bin/env bash
# Environment setup for the NetRadar reproduction (Ubuntu 24.04, CPU-only VM).
set -e
sudo apt-get update
sudo apt-get install -y python3.12-venv cmake libpcap-dev parallel build-essential
python3.12 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install torch --index-url https://download.pytorch.org/whl/cpu
pip install -r requirements.txt
ulimit -n "$(ulimit -Hn)"
ulimit -c 0
echo core | sudo tee /proc/sys/kernel/core_pattern >/dev/null
echo "Environment ready. Activate later with: source venv/bin/activate"
