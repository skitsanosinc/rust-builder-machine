FROM ubuntu:rolling as builder

WORKDIR /app

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y wget curl build-essential libffi-dev libcpuid-dev libssl-dev git luajit jq

RUN apt-get autoclean && apt-get autoremove

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH="$PATH:/root/.cargo/bin"
