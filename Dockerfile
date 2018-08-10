FROM python:3.6-slim

RUN apt-get update \
  && apt-get install -y python3-pip \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install dumb-pypi==1.3.1

ENTRYPOINT ["dumb-pypi"]
