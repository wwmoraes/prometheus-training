# Prometheus training

## Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)

## About <a name = "about"></a>

Prometheus from scratch, so you can fully understand all the architecture and
how everything works.

These images are *NOT* meant for production use - for that you have images under
`prom/` on Docker Hub. Here you'll find a raw installation to demonstrate what
each component is composed of and how to configure it.

On `docker-compose.yml` you'll notice some volume mounts from `config/` folder,
so you can later play with configuration and reload of prometheus/alertmanager.

## Getting Started <a name = "getting_started"></a>

Make sure you have docker up and running.

### Components

- alertmanager
- blackbox
- grafana
- node with a python application
- prometheus
- telegram-bot 😮
- smtp sink to receive the alert emails
- imap to receive the emails
- webmail to actually see and interact with the alert emails :D

all images have node exporter. The `node` itself has a simple python web app with
a counter and a histogram to start with.

## Usage <a name = "usage"></a>

to run use:

```shell
docker-compose up -d
```

### helper scripts

on the repository root you'll see some helper scripts to play around with, namely:

- `./setup-ngrok-hook.sh <bot-webhook-URL>`

this script will call the Telegram API to setup your bot webhook URL.

- `./alert.sh`

Fires a fake alert through alertmanager, and after that waits for any key to
send a resolve.

- `./bot.sh <bot-webhook-URL>`

This script sends a fake alert to the bot.

### using the telegram bot

> Disclaimer: Take instructions here with a grain of salt, as this bot is a
work-in-progress and lives on a
[separate repository](https://github.com/wwmoraes/alertmanager-telegram-bot).

The telegram bot runs as a webhook, and thus requires an HTTPS termination to work.
You can run it using the compose and then start a service as ngrok to forward all
http to port 8443. Then use the `./setup-ngrok-hook.sh` to register that endpoint.

Also the bot expects a token and an user ID. Set those on the
`./services/telegram-bot/.env` file:

```shell
TELEGRAM_ADMIN=<your-user-id>
TELEGRAM_TOKEN=<your-bot-token>
```

Then replace the general receiver on alertmanager with:

```yaml
receivers:
- name: 'general'
  email_configs:
    send_resolved: True
    to: engineer@localhost
    from: monitorning@localhost
    smarthost: smtp
    require_tls: False
  webhook_configs:
  - send_resolved: true
    url: 'https://<subdomain>.ngrok.io'
```

You can add that to the general, as receivers can have multiple configs.

### ports forwarded on localhost

- 9093: Alertmanager
- 8443: Telegram bot
- 3000: Grafana
- 9115: blackbox exporter
- 9090: prometheus
- 9100: node exporter on `node` service
- 8080: python web app on `node` service
- 8181: webmail
