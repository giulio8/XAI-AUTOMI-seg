#!/bin/bash

# Percorsi assoluti sulla macchina remota
CODE_DIR="/home/giulio/XAI-AUTOMI-seg/code"
DATA_DIR="/home/giulio/XAI-AUTOMI-seg/data"
OUTPUT_DIR="/home/giulio/XAI-AUTOMI-seg/output"

# -it per interattività, -d per eseguire in background
# --gpus device=0 per specificare l'uso della GPU 0
# -p per mappare le porte per Jupyter Notebook (tra host e container) -> ma restringiamo a localhost
# per preferire la connessione SSH diretta
# -v per montare i volumi (code, data, results, output)
# -w per impostare la directory di lavoro all'interno del container
# automi-base è l'immagine Docker da eseguire
docker run -it -d \
  --name automi-dev \
  --gpus device=0 \
  -p 127.0.0.1:8888:8888 \
  -v "$CODE_DIR":/workspace/code \
  -v "$DATA_DIR/Dataset003_AUTOMI_CTVLNF_NEWGL_raw_data":/workspace/data/nnunet_raw \
  -v "$DATA_DIR/Dataset003_AUTOMI_CTVLNF_NEWGL_results":/workspace/data/results \
  -v "$OUTPUT_DIR":/workspace/output \
  -w /workspace \
  automi-base