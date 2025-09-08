#!/bin/bash

# Percorsi assoluti sulla macchina remota, presi dall'environment
source .env-w2
CODE_DIR="${CODE_DIR:?Environment variable CODE_DIR not set}"
DATA_DIR="${DATA_DIR:?Environment variable DATA_DIR not set}"
OUTPUT_DIR="${OUTPUT_DIR:?Environment variable OUTPUT_DIR not set}"
WANDB_API_KEY="${WANDB_API_KEY:?Environment variable WANDB_API_KEY not set}"

# -it per interattività, -d per eseguire in background
# --gpus device=0 per specificare l'uso della GPU 0
# -p per mappare le porte per Jupyter Notebook (tra host e container) -> ma restringiamo a localhost
# per preferire la connessione SSH diretta
# -v per montare i volumi (code, data, results, output)
# -w per impostare la directory di lavoro all'interno del container
# automi-base è l'immagine Docker da eseguire
# Comando base
DOCKER_CMD="docker run -it -d \
  --name automi-dev-w2 \
  -p 127.0.0.1:8889:8888 \
  -v \"$CODE_DIR\":/workspace/code \
  -v \"$DATA_DIR/Dataset003_AUTOMI_CTVLNF_NEWGL_raw_data\":/workspace/data/nnunet_raw \
  -v \"$DATA_DIR/Dataset003_AUTOMI_CTVLNF_NEWGL_results\":/workspace/data/results \
  -v \"$DATA_DIR/SHAP_results\":/workspace/data/experiment_results \
  -v \"$OUTPUT_DIR\":/workspace/output \
  -w /workspace \
  -e WANDB_API_KEY=\"$WANDB_API_KEY\""

# Aggiunge GPU solo se specificata
if [[ -n "$GPUS" ]]; then
  DOCKER_CMD="$DOCKER_CMD --gpus \"$GPUS\""
else
  DOCKER_CMD="$DOCKER_CMD -e NVIDIA_VISIBLE_DEVICES=none"
fi

# Aggiungi l'immagine e avvia
DOCKER_CMD="$DOCKER_CMD automi-base"

eval $DOCKER_CMD