FROM alpine:3

WORKDIR /root/

RUN apk --no-cache add ca-certificates libc6-compat

ADD https://github.com/prometheus/node_exporter/releases/download/v1.0.0/node_exporter-1.0.0.linux-amd64.tar.gz .
RUN tar xzf node_exporter-1.0.0.linux-amd64.tar.gz --strip-components=1 && \
  rm node_exporter-1.0.0.linux-amd64.tar.gz

ADD https://dl.grafana.com/oss/release/grafana-7.0.3.linux-amd64.tar.gz .
RUN tar xzf grafana-7.0.3.linux-amd64.tar.gz --strip-components=1 && \
  rm grafana-7.0.3.linux-amd64.tar.gz && \
  chmod +x ./bin/*

ADD run.sh /root

VOLUME [ "/root/data" ]

EXPOSE 3000 9100

ENTRYPOINT [ "./run.sh" ]
