# syntax=docker/dockerfile:1.4
FROM python:3.10.6

# Crea una cartella di lavoro
RUN mkdir /workspace
WORKDIR /workspace

# Copia i requirements
COPY requirements.txt .

# Installa Python packages
RUN --mount=type=cache,target=/root/.cache/pip pip install -r requirements.txt

# Installa librerie di sistema per immagini/video (opencv, matplotlib, ecc.)
RUN apt-get update && apt-get install -y ffmpeg libsm6 libxext6

# Installa Jupyter Notebook
RUN pip install notebook

# Espone la porta del server Jupyter
EXPOSE 8888

# Avvia direttamente Jupyter Notebook quando il container parte
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser"]