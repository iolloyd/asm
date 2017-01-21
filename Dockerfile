FROM ubuntu:latest

MAINTAINER lloyd@codegood.co

RUN apt-get update
RUN apt-get install -y gcc
