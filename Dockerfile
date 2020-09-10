FROM alpine:3.8

RUN apk add --no-cache \
      bash \
      git \
      perl \
      rsync \
      openssh-client \
      curl \
      docker \
      jq \
      su-exec \
      python3 \
      libc6-compat \
      run-parts \
      tini \
      tzdata \
    && \
    pip3 install --upgrade pip && \
    pip3 install --quiet docker-compose~=1.23.0

WORKDIR /buildkite

ARG BK_VERSION=3.23.1
ENV BUILDKITE_AGENT_CONFIG=/buildkite/buildkite-agent.cfg

RUN wget https://github.com/buildkite/agent/releases/download/v${BK_VERSION}/buildkite-agent-linux-armhf-${BK_VERSION}.tar.gz \
    && tar -xzf buildkite-agent-linux-armhf-${BK_VERSION}.tar.gz \
    && rm buildkite-agent-linux-armhf-${BK_VERSION}.tar.gz buildkite-agent.cfg bootstrap.sh \
    && mv buildkite-agent /usr/local/bin/buildkite-agent

RUN mkdir -p /buildkite/builds /buildkite/plugins \
    && curl -Lfs -o /usr/local/bin/ssh-env-config.sh https://raw.githubusercontent.com/buildkite/docker-ssh-env-config/master/ssh-env-config.sh \
    && chmod +x /usr/local/bin/ssh-env-config.sh

COPY ./buildkite-agent.cfg /buildkite/buildkite-agent.cfg
COPY ./entrypoint.sh /usr/local/bin/buildkite-agent-entrypoint

VOLUME /buildkite
ENTRYPOINT ["buildkite-agent-entrypoint"]
CMD ["start"]