# Prometheus exporter for MQTT

Configurable general purpose Prometheus exporter for MQTT.

Subscribes to one or more MQTT topics, and lets you configure prometheus metrics based on pattern matching.

[![Test with pytest](https://github.com/fhemberger/mqtt_exporter/actions/workflows/test.yml/badge.svg)](https://github.com/fhemberger/mqtt_exporter/actions/workflows/test.yml)[![CodeQL](https://github.com/fhemberger/mqtt_exporter/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/fhemberger/mqtt_exporter/actions/workflows/codeql-analysis.yml)


## Usage

- Create a folder to hold the config (default: `conf/`)
- Add metric config(s) in YAML format to the folder. Files are combined and read as a single config. (See `exampleconf/metric_example.yaml` for details)
- Install dependencies with `pip3 install -r requirements-frozen.txt`
- Run `./mqtt_exporter.py`


## Docker

For your convenience, there is also a Docker image available:

```bash
docker run -d \
  -v "$(pwd)/myconfig:/usr/src/app/conf:ro" \
  -p "9344:9344" \
  ghcr.io/fhemberger/mqtt_exporter
```

If you want to mount your configuration to a different directory, add the `-c` flag:

```bash
docker run -d \
  -v "$(pwd)/myconfig:/myconfig:ro" \
  -p "9344:9344" \
  ghcr.io/fhemberger/mqtt_exporter -c /myconfig
```


## Python dependencies

 - paho-mqtt
 - prometheus-client
 - PyYAML
 - yamlreader

Functional tests are written in `pytest` (see [tests/readme.md](tests/readme.md)), code formatting uses [`autopep8`](https://pypi.org/project/autopep8/) with default settings. If you submit a PR to this repo, please make sure it follows its formatting guidelines.


## TODO

- Add persistence of metrics on restart
