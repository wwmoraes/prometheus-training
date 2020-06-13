FROM alpine:3

WORKDIR /root/

RUN apk --no-cache add ca-certificates python3 py3-pip

ADD https://github.com/prometheus/node_exporter/releases/download/v1.0.0/node_exporter-1.0.0.linux-amd64.tar.gz .
RUN tar xzf node_exporter-1.0.0.linux-amd64.tar.gz --strip-components=1 && \
  rm node_exporter-1.0.0.linux-amd64.tar.gz && \
  chmod +x node_exporter

RUN pip install prometheus_client

ADD run.sh app.py /root/

EXPOSE 8080 9100

ENTRYPOINT [ "./run.sh" ]
