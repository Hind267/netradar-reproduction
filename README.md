# NetRadar Reproduction — CSIS 4450 Project (Track B)

Reproduction of the DDoS carpet-bombing detector **NetRadar** (NDSS 2026) for
Douglas College course **CSIS 4450 – OS & Multimedia Cybersecurity**, Fall 2026.

- **Student:** Hind Abu Alamrain (ID 300403234)
- **Instructor:** Zhe Yang
- **Track:** B — Top-Tier Security Paper Evaluation
- **Original artifact:** Zenodo DOI 10.5281/zenodo.17582526

## 1. What this project does
NetRadar detects carpet-bombing DDoS attacks, which spread traffic thinly across
many servers so each looks normal while the shared gateway is overwhelmed. It
analyses many servers together with a set-based neural network (PointNet) and
flags traffic that is suspiciously similar across servers at the same time.

This repo documents my reproduction of the paper's main detection experiment on
the synchronous_download attack scenario, running all three detectors:

| Detector | Accuracy (my run) | Paper claim |
|----------|-------------------|-------------|
| Whisper  | 96.1%             | > 94%       |
| FlowLens | 95.5%             | > 94%       |
| NetRadar | 95.2%             | > 94%       |

All three reached about 95% accuracy, matching the paper's claim of over 94%.
This is a valid partial reproduction: one of three scenarios, documented honestly.

## 2. Environment
- VirtualBox, Ubuntu 24.04 LTS
- 2 CPU cores, 8 GB RAM, 80 GB disk (CPU only, no GPU)
- Python 3.12 (virtual environment), PyTorch CPU build, cmake, libpcap, GNU parallel
- Dataset: CICIDS2017 (Monday capture as attack-free background traffic)

## 3. Fixes I had to make
1. Grew the VM disk from 25 GB to 80 GB (preprocessing needs space).
2. Used a Python virtual environment (Ubuntu blocks system-wide pip).
3. Disabled core dumps (they slowed preprocessing to ~7 hours).
4. Raised the open-file limit during the pcap merge.
5. Deleted 0-byte pcap files that crashed the merge tool.
6. Patched two scripts to skip flows missing expected fields (KeyError).
7. Forced CPU mode in the NetRadar detector (no GPU).
8. Reduced training from 100 to 3 epochs (100 would take ~40 hours on CPU).
9. Reduced the config list to scenarios that fit in 8 GB RAM.

## 4. Results
NetRadar reached 95.2% accuracy, consistent with the paper. Raw run logs are in
netradar_logs.zip (results, run logs, and preprocessing logs).

## 5. Limitations
- Reproduced one of three attack scenarios (RAM/time limits on a CPU-only VM).
- Trained for 3 epochs instead of 100 (the result had already converged).
- NetRadar's script reports accuracy only; recall/precision were not reproduced.

## 6. Repo contents
- README.md — this file
- setup_environment.sh — environment setup commands
- apply_patches.sh — the fixes from section 3
- netradar_logs.zip — my actual run logs
