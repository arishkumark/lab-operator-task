# Device Dashboard

This repository contain a sample project on how real-time time series data coming from devices' various sensors could be visualize.

## Prerequisite

To run locally, you'll need to install [docker-compose](https://docs.docker.com/compose/install/)

Make sure that your docker-compose version is at least v1.27.0

## Running

Once docker-compose is installed, you can start the server by running:

```
$ docker-compose up --build
```

You can then open http://localhost:3000 in your browser

## Testing

- Back-End testing are provided using RSpec
- Front-End testing are provided using Jest
