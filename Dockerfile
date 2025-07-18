FROM python:3.10.6

# Crea una cartella di lavoro
RUN mkdir /workspace
WORKDIR /workspace

# Copia i requirements
COPY requirements.txt .

# Installa Python packages
#RUN pip install --upgrade pip && pip install -r requirements.txt
RUN pip install -r requirements.txt

# Installa librerie di sistema per immagini/video (opencv, matplotlib, ecc.)
RUN apt-get update && apt-get install -y ffmpeg libsm6 libxext6

RUN apt-get update && \
    apt-get install -y curl apt-utils gnupg software-properties-common && \
    curl -fsSL https://code-server.dev/install.sh | sh

RUN code-server --install-extension ms-python.python

# Copia i notebook
#COPY code code - meglio mount

# Espone la porta del server Jupyter
EXPOSE 8443

# Avvia direttamente il server code quando il container parte
ENV PASSWORD="giulio"
CMD ["code-server", "--bind-addr", "0.0.0.0:8443", "--auth", "password", "/workspace"]