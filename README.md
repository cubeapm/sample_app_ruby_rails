# README

# Ruby Rails OpenTelemetry Instrumentation

This is a sample app to demonstrate how to instrument Ruby Rails app with OpenTelemetry. The app itself is a minimal Rails app. This repository has a docker compose file for convenient setup.

This repository is inentionally designed to work with any OpenTelemetry backend, not just CubeAPM. In fact, it can even work without any OpenTelemetry backend (by dumping traces to console, which is also the default behaviour).

## Setup

Clone this repository and go to the project directory. Then run the following commands

```
docker compose up --build
```

Laravel app will now be available at `http://localhost:9000`.

Open http://localhost:9000 in your browser and refresh the page a few times to generate some traces. Traces are printed to console (where docker compose is running) by default. If you want to send traces to a backend tool, comment out the `OTEL_TRACES_EXPORTER=console` line and uncomment the `OTEL_TRACES_EXPORTER=otlp` and `OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=...` line in [docker-compose.yml](docker-compose.yml).

## Contributing

Please feel free to raise PR for any enhancements - additional service integrations, library version updates, documentation updates, etc.






This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
