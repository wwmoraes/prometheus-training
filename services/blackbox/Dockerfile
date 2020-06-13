FROM alpine:3

WORKDIR /root/

RUN apk --no-cache add ca-certificates

ADD https://github.com/prometheus/node_exporter/releases/download/v1.0.0/node_exporter-1.0.0.linux-amd64.tar.gz .
RUN tar xzf node_exporter-1.0.0.linux-amd64.tar.gz --strip-components=1 && \
  rm node_exporter-1.0.0.linux-amd64.tar.gz

ADD https://github.com/prometheus/blackbox_exporter/releases/download/v0.16.0/blackbox_exporter-0.16.0.linux-amd64.tar.gz .
RUN tar xzf blackbox_exporter-0.16.0.linux-amd64.tar.gz --strip-components=1 && \
  rm blackbox_exporter-0.16.0.linux-amd64.tar.gz

ADD run.sh /root

EXPOSE 9115 9100

ENTRYPOINT [ "./run.sh" ]
