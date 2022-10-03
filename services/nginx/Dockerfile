ARG NGINX_VERSION
FROM ${NGINX_VERSION}

ARG TZ
ARG NGINX_VERSION
ARG CONTAINER_PACKAGE_URL


ENV INSTALL_APPS=",${NGINX_INSTALL_APPS},"

RUN if [ "${CONTAINER_PACKAGE_URL}" != "" ]; then \
        sed -i "s/dl-cdn.alpinelinux.org/${CONTAINER_PACKAGE_URL}/g" /etc/apk/repositories; \
    fi

RUN if [ -z "${INSTALL_APPS##*,certbot,*}" ]; then \
        echo "---------- Install certbot ----------"; \
        apk add --no-cache certbot; \
    fi
RUN apk add --no-cache openssl bash

# COPY nginx.sh /customization/

RUN chmod +x /etc/nginx/conf.d/nginx.sh

WORKDIR /www

# CMD ["/customization/nginx.sh"]
CMD ["/etc/nginx/conf.d/nginx.sh"]
