FROM ubuntu:14.04

MAINTAINER lloyd@codegood.co

RUN apt-get update && apt-get install -y \
    gcc
