FROM python:3.10-slim-buster

COPY . /app
WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends


RUN pip install --upgrade pip
RUN python -m pip install --no-cache-dir -r ./requirements.txt
