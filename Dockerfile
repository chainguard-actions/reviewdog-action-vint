FROM python:3.12-alpine

ENV REVIEWDOG_VERSION=v0.20.2

RUN REVIEWDOG_VERSION_NUM="${REVIEWDOG_VERSION#v}" && \
    wget -O /tmp/reviewdog.tar.gz -q "https://github.com/reviewdog/reviewdog/releases/download/${REVIEWDOG_VERSION}/reviewdog_${REVIEWDOG_VERSION_NUM}_linux_amd64.tar.gz" && \
    wget -O /tmp/reviewdog_checksums.txt -q "https://github.com/reviewdog/reviewdog/releases/download/${REVIEWDOG_VERSION}/reviewdog_${REVIEWDOG_VERSION_NUM}_checksums.txt" && \
    grep "reviewdog_${REVIEWDOG_VERSION_NUM}_linux_amd64.tar.gz" /tmp/reviewdog_checksums.txt | sha256sum -c - && \
    tar -xzf /tmp/reviewdog.tar.gz -C /usr/local/bin/ reviewdog && \
    rm /tmp/reviewdog.tar.gz /tmp/reviewdog_checksums.txt
RUN apk --update add git && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*
RUN pip3 install --upgrade pip && \
    pip3 install vim-vint && \
    rm -r /root/.cache

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
