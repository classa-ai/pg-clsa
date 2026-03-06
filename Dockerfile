FROM ghcr.io/railwayapp-templates/postgres-ssl:16.11

RUN apt-get update && apt-get install -y \
    postgresql-16-postgis-3 \
    postgresql-16-postgis-3-scripts \
    build-essential \
    git \
    postgresql-server-dev-16 \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --branch v0.8.2 https://github.com/pgvector/pgvector.git /tmp/pgvector \
 && cd /tmp/pgvector \
 && make \
 && make install \
 && rm -rf /tmp/pgvector

COPY init-extensions.sql /docker-entrypoint-initdb.d/20-extensions.sql