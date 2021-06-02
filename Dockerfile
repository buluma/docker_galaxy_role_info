FROM python:3.9-alpine

LABEL maintainer="Michael Buluma"

WORKDIR /github/workspace

RUN apk add --update --no-cache python3 py-pip && \
    apk add --update --no-cache --virtual build_dependencies gcc musl-dev libffi-dev openssl-dev rust cargo && \
    pip install ansible && \
    apk del build_dependencies

CMD cd ${path:-./} ; ansible-galaxy role info --api-key ${galaxy_api_key} $(echo $GITHUB_REPOSITORY | cut -d/ -f1) $(echo $GITHUB_REPOSITORY | cut -d/ -f2)
