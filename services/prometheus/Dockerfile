FROM alpine:3

WORKDIR /root/

RUN apk --no-cache add ca-certificates

ADD https://github.com/prometheus/node_exporter/releases/download/v1.0.0/node_exporter-1.0.0.linux-amd64.tar.gz .
RUN tar xzf node_exporter-1.0.0.linux-amd64.tar.gz --strip-components=1 && \
  rm node_exporter-1.0.0.linux-amd64.tar.gz && \
  chmod +x node_exporter

ADD https://github.com/prometheus/prometheus/releases/download/v2.19.0/prometheus-2.19.0.linux-amd64.tar.gz .
RUN tar xzf prometheus-2.19.0.linux-amd64.tar.gz --strip-components=1 && \
  rm prometheus-2.19.0.linux-amd64.tar.gz && \
  chmod +x prometheus promtool tsdb

ADD run.sh /root

VOLUME [ "/root/data" ]

EXPOSE 9090 9100

ENTRYPOINT [ "./run.sh" ]
