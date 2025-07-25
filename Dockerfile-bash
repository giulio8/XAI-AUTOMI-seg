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

# Installa jupyter e jupyter nbconvert per eseguire notebook da riga di comando
RUN pip install notebook nbconvert

# Espone una porta utile per debug, se necessario
EXPOSE 8888

# Nessun comando automatico: si lavora in modo interattivo
CMD ["/bin/bash"]