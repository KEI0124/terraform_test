FROM alpine:latest AS satt_infra_base

# Terraform
ENV TERRAFORM_VERSION=0.12.25

RUN apk update && \
    apk add curl ca-certificates git openssl unzip wget bash docker openrc py-pip python3 && \
    cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/tmp/*
RUN rc-update add docker boot

# Install Python3 and Packages
RUN ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools awscli boto3 --upgrade --user
ENV PATH="/root/.local/bin:${PATH}"

RUN mkdir /work
WORKDIR /work

# bashの設定
RUN echo PS1=\"\[\\w\]# \" >> ~/.bashrc
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && echo $SNIPPET >> "/root/.bashrc" 