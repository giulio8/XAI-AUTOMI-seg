#!/bin/bash

# Percorsi assoluti sulla macchina remota
CODE_DIR="/home/giulio/XAI-AUTOMI-seg/code"
DATA_DIR="/home/giulio/XAI-AUTOMI-seg/data"
OUTPUT_DIR="/home/giulio/XAI-AUTOMI-seg/output"


docker run -it -d \
  --name automi-dev \
  --gpus device=0 \
  -v "$CODE_DIR":/workspace/code \
  -v "$DATA_DIR/Dataset003_AUTOMI_CTVLNF_NEWGL_raw_data":/workspace/data/nnunet_raw \
  -v "$DATA_DIR/Dataset003_AUTOMI_CTVLNF_NEWGL_results":/workspace/data/results \
  -v "$OUTPUT_DIR":/workspace/output \
  -w /workspace \
  automi-base