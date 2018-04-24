FROM openshift/base-centos7

ENV MINIO_ACCESS_KEY="C8NODTMLRKRBB4665CV9"
ENV MINIO_SECRET_KEY="a3xpzQFu4rKRC/pm0Ky9ciyhBvXMb/Go3cfETNH2"
ENV MINIO_DOWNLOAD_URL="https://dl.minio.io/server/minio/release/linux-amd64/minio"

RUN mkdir -p /minio/bin \
## Install prerequisities
 && apk update && apk add curl \ 
 && echo "curl -sL -o /minio/bin/minio $MINIO_DOWNLOAD_URL" \
 && curl -sL -o /minio/bin/minio $MINIO_DOWNLOAD_URL \
 && chmod +x /minio/bin/minio

VOLUME ["~/minio/data", "~/minio/config"]

RUN chgrp -R 0 /minio \
 && chmod -R g+rwX /minio

EXPOSE 9000

USER 100001

CMD ["/minio/bin/minio", "server", "--config-dir=/minio/config", "/minio/data"]
