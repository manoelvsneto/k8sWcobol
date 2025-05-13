# Dockerfile corrigido para resolver problemas de apt-get

FROM --platform=linux/arm64 ubuntu:20.04 as builder

# Configurar ambiente não interativo para evitar prompts durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Configurar timezone para evitar prompts
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Atualizar fontes de pacotes e resolver problema de apt-get
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get update -y && \
    apt-get install -y apt-utils 2>&1 | grep -v "debconf: delaying package configuration"

# Instalando dependências necessárias
RUN apt-get install -y \
    build-essential \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Instalar GnuCOBOL (comando corrigido)
RUN apt-get update -y && \
    apt-get install -y gnucobol || apt-get install -y open-cobol && \
    rm -rf /var/lib/apt/lists/*

# Diretório de trabalho
WORKDIR /app

# Copia o código fonte COBOL
COPY hello.cob .

# Compila o programa COBOL (com fallback para different compiler name)
RUN which cobc && cobc -x -o hello hello.cob || \
    which open-cobol && open-cobol -x -o hello hello.cob

# Segunda etapa da build para uma imagem mais leve
FROM --platform=linux/arm64 ubuntu:20.04

# Configurar ambiente não interativo
ENV DEBIAN_FRONTEND=noninteractive

# Atualizar pacotes de maneira segura
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    libcob4 || apt-get install -y --no-install-recommends libcob1 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copia apenas o binário compilado da etapa anterior
COPY --from=builder /app/hello /app/hello

# Define o comando padrão para execução
CMD ["/app/hello"]