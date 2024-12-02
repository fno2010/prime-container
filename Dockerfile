FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-runtime

ARG PRIME_REPO="https://github.com/PrimeIntellect-ai/prime"

ADD requirements.txt /opt/prime-requirements.txt

RUN apt update -y && \
    apt install iperf git -y && \
    git clone ${PRIME_REPO} /opt/prime && \
    cd /opt/prime && \
    git submodule update --init --recursive && \
    pip install --no-cache-dir -r /opt/prime-requirements.txt && \
    pip install --no-cache-dir flash-attn --no-build-isolation && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

