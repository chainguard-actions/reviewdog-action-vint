FROM python:3.12-alpine

ENV REVIEWDOG_VERSION=v0.19.0

RUN wget -O /tmp/install-reviewdog.sh -q https://raw.githubusercontent.com/reviewdog/reviewdog/b88588991adeb3e97f1283710aa7558e5e0811a5/install.sh && \
    sh /tmp/install-reviewdog.sh -b /usr/local/bin/ ${REVIEWDOG_VERSION} && \
    rm /tmp/install-reviewdog.sh
RUN apk --update add git && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*
RUN pip3 install --upgrade pip && \
    pip3 install vim-vint && \
    rm -r /root/.cache

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
