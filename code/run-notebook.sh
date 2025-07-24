#!/bin/bash

# Usage: ./run-notebook.sh xai-automi

NOTEBOOK_NAME=$1

if [ -z "$NOTEBOOK_NAME" ]; then
  echo "❌ Please provide the notebook name (without .ipynb)"
  echo "Usage: ./run-notebook.sh xai-automi"
  exit 1
fi

NOTEBOOK_PATH="code/${NOTEBOOK_NAME}.ipynb"
SCRIPT_PATH="code/${NOTEBOOK_NAME}.py"

# Check if the notebook exists
if [ ! -f "$NOTEBOOK_PATH" ]; then
  echo "❌ Notebook not found: $NOTEBOOK_PATH"
  exit 1
fi

echo "📘 Converting $NOTEBOOK_PATH to script..."
jupyter nbconvert --to script "$NOTEBOOK_PATH"

echo "🚀 Running $SCRIPT_PATH..."
python "$SCRIPT_PATH"