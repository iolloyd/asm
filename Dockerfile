FROM ubuntu:latest

MAINTAINER lloyd@codegood.co

RUN apt-get update && apt-get install -y \
    gcc
