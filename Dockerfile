FROM python:alpine

LABEL org.opencontainers.image.title=mqtt_exporter
LABEL org.opencontainers.image.description="Prometheus exporter for MQTT."
LABEL org.opencontainers.image.vendor="Christian Stangier"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source=https://github.com/c-st/mqtt-exporter

WORKDIR /usr/src/app

RUN adduser --system --no-create-home --shell /usr/sbin/nologin mqttexporter
COPY *.py requirements-frozen.txt ./
COPY utils ./utils
RUN /usr/local/bin/pip install --no-cache-dir -r requirements-frozen.txt

USER mqttexporter

EXPOSE 9344
ENTRYPOINT [ "/usr/local/bin/python3", "-u", "/usr/src/app/mqtt_exporter.py" ]
