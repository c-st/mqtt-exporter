FROM python:3.8-alpine

RUN adduser --system --no-create-home --shell /usr/sbin/nologin mqtt_exporter
COPY mqtt_exporter.py requirements.txt /
RUN pip install -r requirements.txt

USER mqtt_exporter

EXPOSE 9344
ENTRYPOINT [ "python", "./mqtt_exporter.py" ]
