FROM python:3.7.3-alpine3.9
LABEL maintainer="Muhammad Fahrizal Rahman riesal[at]gmail[dot]com"

ARG USR_PSS
ARG USR_NME
ENV USR_PSS=$USR_PSS
ENV USR_NME=$USR_NME

user root
RUN apk update && apk upgrade

RUN apk add bash curl net-tools wget git sudo shadow

RUN echo "Adding alpine repo.." && \
    echo "http://dl-2.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories && \
    echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-2.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update && apk upgrade && apk add --update shadow

RUN useradd -m -p "$USR_PSS" "$USR_NME" && \
    usermod -aG users "$USR_NME" && \
    adduser "$USR_NME" wheel && \
    usermod -aG root "$USR_NME" && \
    echo "$USR_NME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

user "$USR_NME"
RUN echo "Welcome $USR_NME"
