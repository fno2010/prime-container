FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-runtime

ARG PRIME_REPO="git@github.com:PrimeIntellect-ai/prime.git"

ADD requirements.txt /opt/prime-requirements.txt

RUN \
    sudo apt update -y \
    && sudo apt install iperf -y \
    && git clone ${PRIME_REPO} /opt/prime \
    && cd /opt/prime \
    && git submodule update --init --recursive \
    && pip install --no-cache-dir -r /opt/prime-requirements.txt \
    && pip install --no-cache-dir flash-attn --no-build-isolation \
    && sudo apt-get clean \
    && rm -rf /var/lib/apt/lists/* \

