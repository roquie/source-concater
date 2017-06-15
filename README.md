# Source-concater

[![Build Status](https://travis-ci.org/roquie/source-concater.svg?branch=master)](https://travis-ci.org/roquie/source-concater)
[![BCH compliance](https://bettercodehub.com/edge/badge/roquie/source-concater?branch=master)](https://bettercodehub.com/)

Concat zipped sources to single file.

## Docker

```bash
docker run --name srcc -d -p 80:80 roquie/srcc:latest
```

#### Build

* `cd /path/to/project/root`
* `yarn build`
* `docker build -t srcc-image:v1 .`

#### Run

* `docker run --name srcc -d -p 80:80 srcc-image:v1`
* open [http://localhost:8001/](http://localhost:8001/)

#### Stop

* `docker stop srcc`

## Online

[https://roquie.github.io/source-concater/](https://roquie.github.io/source-concater/)

## Build Setup

``` bash
# install dependencies
yarn install

# serve with hot reload at localhost:8080
yarn run dev

# build for production with minification
yarn run build

# build for production and view the bundle analyzer report
yarn run build --report
```

## License

MIT
