# Prometheus exporter for MQTT

Configurable general purpose Prometheus exporter for MQTT.

Subscribes to one or more MQTT topics, and lets you configure prometheus metrics based on pattern matching.

[![Test with pytest](https://github.com/fhemberger/mqtt_exporter/actions/workflows/test.yml/badge.svg)](https://github.com/fhemberger/mqtt_exporter/actions/workflows/test.yml)[![CodeQL](https://github.com/fhemberger/mqtt_exporter/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/fhemberger/mqtt_exporter/actions/workflows/codeql-analysis.yml)![Docker Pulls](https://img.shields.io/docker/pulls/fhemberger/mqtt_exporter)


## Features

- Supported Metrics:
  - standard metrics 
    - Gauge, Counter, Histogram, Summary
  - additional
    - **Counter (Absolute):** 
      - Same as Counter, but working with absolute numbers received from MQTT. Which is far more common, than sending the diff in each publish.
      - e.g. a network counter or a rain sensor
    - **Enum:**
      - is a metric type not so common, details can be found in the [OpenMetrics docs](https://github.com/OpenObservability/OpenMetrics/blob/main/specification/OpenMetrics.md#stateset) and [Python client code](https://github.com/prometheus/client_python/blob/9a24236695c9ad47f9dc537a922a6d1333d8d093/prometheus_client/metrics.py#L640-L698).
      - Allows to track as state by a know set of strings describing the state, e.g. `on/off` or `high/medium/low`
      - Common sources would be a light switch oder a door lock.
- Comprehensive rewriting for topic, value/payload and labels 
  - similar to prometheus label rewrites
  - regex allows almost every conversion
  - e.g. to
    - remove units or other strings from payload 
    - convert topic hierarchy into labels
    - normalize labels
  - check example configs `./exampleconf` and the configs in `./test/test_data/`


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


## Contribution

* Contribution is welcome. Fork and then PR. 
* Discussions in Issues.
* Functional tests are written in `pytest` (see [tests/readme.md](tests/readme.md)) 
* Code formatting uses [`autopep8`](https://pypi.org/project/autopep8/) with default settings. If you submit a PR to this repo, please make sure it follows its formatting guidelines.


## TODO

- Add persistence of metrics on restart
- forget/age out metrics receiving no updates anymore
