# Imagem base Ubuntu arm64
FROM arm64v8/ubuntu:22.04

# Evita prompts interativos
ENV DEBIAN_FRONTEND=noninteractive

# Instala o GnuCOBOL e dependências
RUN apt-get update && \
    apt-get install -y gnucobol build-essential && \
    apt-get clean

# Cria diretório de trabalho
WORKDIR /app

# Copia os arquivos COBOL para dentro do container
COPY . /app

# Compila o código (substitua seu_programa.cob pelo nome do seu arquivo)
RUN cobc -x -o main hello.cob

# Define comando de execução
CMD ["./main"]
