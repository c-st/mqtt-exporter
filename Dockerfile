FROM python:3.8-alpine

RUN adduser --system --no-create-home --shell /usr/sbin/nologin mqtt_exporter
COPY mqtt_exporter.py requirements-frozen.txt /
RUN pip install -r requirements-frozen.txt

USER mqtt_exporter

EXPOSE 9344
ENTRYPOINT [ "python", "-u", "./mqtt_exporter.py" ]
