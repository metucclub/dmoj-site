FROM python:3.7-alpine

RUN apk add --upgrade  \
    build-base \
    libffi-dev \
    mariadb-dev \
    libxml2-dev \
    libxslt-dev \
    py2-psycopg2 \
    zlib-dev \
    jpeg-dev \
    gettext \
    nodejs \
    npm \
    libsass \
    git \
    zip \
    unzip \
    nano \
    vim \
    wget \
    curl \
    tar \
    bash

ENV LIBRARY_PATH=/lib:/usr/lib
ENV PYTHONUNBUFFERED 1

RUN wget -q https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz && \
    tar -xzf dockerized-phantomjs.tar.gz -C /usr/local && \
    rm -rf dockerized-phantomjs.tar.gz

RUN mkdir -p /app
WORKDIR /app

RUN mkdir -p static/pdfcache/

COPY requirements.txt .

RUN pip install -r requirements.txt && \
    pip install gunicorn && \
    pip install gunicorn[gevent]

COPY package.json .
RUN npm install .

COPY . .

RUN git clone https://github.com/oznakn/docker-scripts && \
    mv docker-scripts/*.sh . && \
    rm -rf docker-scripts && \
    mkdir -p ./db

RUN chmod a+x backup-data.sh restore-data.sh docker-wait-for-it.sh
