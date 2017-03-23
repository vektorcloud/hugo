FROM quay.io/vektorcloud/base:3.5

ENV HUGO_VERSION 0.19

RUN set -ex \
  && apk add --no-cache openssl git python2 \
  && wget -q -P /tmp "https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" \
  && wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python \
  && pip install Pygments \
  && apk del openssl \
  && tar -C /tmp -xvf /tmp/*tar.gz \
  && mv /tmp/hugo_*linux_amd64/hugo*_linux_amd64 /bin/hugo \ 
  && rm -Rf /tmp/*

COPY entrypoint.sh /

WORKDIR /src
VOLUME /src
EXPOSE 1313

CMD ["hugo", "server", "-w", "--bind", "0.0.0.0"]

ENTRYPOINT ["/entrypoint.sh"]
