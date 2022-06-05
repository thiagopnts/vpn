FROM alpine:3.16

ARG VERSION=1.24.2
ARG ARCH=amd64
ARG TAILSCALE_HOSTNAME=flyio-exit-node-brazil

WORKDIR /app
ENV TAILSCALE_HOSTNAME=${TAILSCALE_HOSTNAME}
ENV TAILSCALE=tailscale_${VERSION}_${ARCH}.tgz
RUN apk add --no-cache \
  curl=7.83.1-r1 \
  iptables=1.8.8-r1 \
  ip6tables=1.8.8-r1 \
  iproute2=5.17.0-r0 \
  ca-certificates=20211220-r0 \
  && \
  curl -sLO "https://pkgs.tailscale.com/stable/${TAILSCALE}" && \
  tar xz --strip-components=1 -f "${TAILSCALE}"
COPY ./run.sh ./

CMD ["sh", "run.sh"]
