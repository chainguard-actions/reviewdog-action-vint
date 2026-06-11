FROM python:3.12-alpine

ENV REVIEWDOG_VERSION=v0.20.2

RUN wget -q "https://github.com/reviewdog/reviewdog/releases/download/${REVIEWDOG_VERSION}/reviewdog_${REVIEWDOG_VERSION#v}_Linux_x86_64.tar.gz" -O /tmp/reviewdog.tar.gz && \
    wget -q "https://github.com/reviewdog/reviewdog/releases/download/${REVIEWDOG_VERSION}/reviewdog_${REVIEWDOG_VERSION#v}_checksums.txt" -O /tmp/reviewdog_checksums.txt && \
    grep "reviewdog_${REVIEWDOG_VERSION#v}_Linux_x86_64.tar.gz" /tmp/reviewdog_checksums.txt | sha256sum -c - && \
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
