FROM postgres:13.3-alpine@sha256:ff384947eb9f5939b7fc5ef2ce620fad088999590973f05e6812037d163c770e

MAINTAINER Leonardo Gatica <lgatica@protonmail.com>

RUN apk add --no-cache py2-pip && pip install awscli && mkdir /backup

ENV AWS_DEFAULT_REGION=us-east-1

COPY entrypoint.sh /usr/local/bin/entrypoint
COPY backup.sh /usr/local/bin/backup
COPY pguri.py /usr/local/bin/pguri

VOLUME /backup

CMD /usr/local/bin/entrypoint
