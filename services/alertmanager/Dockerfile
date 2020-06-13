FROM alpine:3

WORKDIR /root/

RUN apk --no-cache add ca-certificates

ADD https://github.com/prometheus/node_exporter/releases/download/v1.0.0/node_exporter-1.0.0.linux-amd64.tar.gz .
RUN tar xzf node_exporter-1.0.0.linux-amd64.tar.gz --strip-components=1 && \
  rm node_exporter-1.0.0.linux-amd64.tar.gz

ADD https://github.com/prometheus/alertmanager/releases/download/v0.21.0-rc.0/alertmanager-0.21.0-rc.0.linux-amd64.tar.gz .
RUN tar xzf alertmanager-0.21.0-rc.0.linux-amd64.tar.gz --strip-components=1 && \
  rm alertmanager-0.21.0-rc.0.linux-amd64.tar.gz

ADD run.sh /root

VOLUME [ "/root/data" ]

EXPOSE 9093 9100

ENTRYPOINT [ "./run.sh" ]
