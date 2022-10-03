FROM certbot/certbot:v1.29.0

ARG CONTAINER_PACKAGE_URL

RUN if [ "${CONTAINER_PACKAGE_URL}" != "" ]; then \
        sed -i "s/dl-cdn.alpinelinux.org/${CONTAINER_PACKAGE_URL}/g" /etc/apk/repositories; \
    fi
RUN apk add --no-cache bash

COPY certbot.sh /opt/

RUN chmod +x /opt/certbot.sh

ENTRYPOINT ["/opt/certbot.sh"]