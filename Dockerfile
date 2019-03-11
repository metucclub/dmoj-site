FROM python:2-alpine

ENV LIBRARY_PATH=/lib:/usr/lib
ENV PYTHONUNBUFFERED 1

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
    bash

RUN mkdir -p /app
WORKDIR /app

COPY requirements.txt .
RUN pip install cffi && \
    pip install -r requirements.txt && \
    pip install django_select2 && \
    pip install websocket-client && \
    pip install gunicorn && \
    pip install gunicorn[gevent]

COPY package.json .
RUN npm install .

COPY . .

RUN chmod a+x backup-data.sh restore-data.sh docker-wait-for-it.sh
