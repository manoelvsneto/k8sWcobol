FROM --platform=linux/arm64 ubuntu:20.04 as builder

# Instalando dependências necessárias
RUN apt-get update && apt-get install -y \
    build-essential \
    gnucobol \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Diretório de trabalho
WORKDIR /app

# Copia o código fonte COBOL
COPY hello.cob .

# Compila o programa COBOL
RUN cobc -x -o hello hello.cob

# Segunda etapa da build para uma imagem mais leve
FROM --platform=linux/arm64 ubuntu:20.04

# Instalando apenas o runtime necessário
RUN apt-get update && apt-get install -y \
    libcob4 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copia apenas o binário compilado da etapa anterior
COPY --from=builder /app/hello /app/hello

# Define o comando padrão para execução
CMD ["/app/hello"]