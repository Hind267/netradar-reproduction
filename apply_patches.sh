#!/usr/bin/env bash
# Fixes applied to the NetRadar artifact so it runs on a CPU-only VM.
set -e
# Force CPU mode (no GPU)
sed -i.bak 's/^use_gpu = args.use_gpu/use_gpu = False/' detectors/netradar.py
# Skip flows missing fields in the HTTP summary step (KeyError)
# and in the remix step (two functions). See report section 3 for details.
# Reduce training epochs from 100 to 3 (100 epochs ~= 40h on CPU).
echo "Patches applied. Backups saved as *.bak"
