FROM mockoon/cli:1.6.0

LABEL maintainer="Zayed Mahmud"

ARG HTTP_PROXY=""
ARG HTTPS_PROXY=""
ARG NO_PROXY="localhost,127.0.0.*"
ARG TIMEZONE="Asia/Dhaka"

ARG MOCK_API_JSON_FILENAME="./mockapi.json"
ARG WORK_DIR_PATH="/data"

ENV http_proxy="${HTTP_PROXY}" \
    https_proxy="${HTTPS_PROXY}" \
    no_proxy="${NO_PROXY}" \
    TZ="${TIMEZONE}" \
    MOCK_API_JSON_FILENAME="./mockapi.json" \
    WORK_DIR_PATH="/data"

# Timezone
ENV TZ="${TIMEZONE}"

USER root

RUN mkdir -p ${WORK_DIR_PATH} && chown -R mockoon:mockoon ${WORK_DIR_PATH}

WORKDIR ${WORK_DIR_PATH}

COPY --chown=mockoon:mockoon ${MOCK_API_JSON_FILENAME} .

USER mockoon

EXPOSE 3080

ENTRYPOINT ["mockoon-cli", "start", "--data", "${WORK_DIR_PATH}", "--port", "3000", "--hostname", "0.0.0.0", "--daemon-off", "--repair"]
