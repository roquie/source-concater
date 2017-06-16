# Source-concater

[![Build Status](https://travis-ci.org/roquie/source-concater.svg?branch=master)](https://travis-ci.org/roquie/source-concater)
[![BCH compliance](https://bettercodehub.com/edge/badge/roquie/source-concater?branch=master)](https://bettercodehub.com/)

Concat zipped sources to single file.

Try it -> [https://srcc.herokuapp.com/](https://srcc.herokuapp.com/)! <br>
Or look it [how use it](https://github.com/roquie/source-concater/blob/master/doc/how-usage.gif).

## Docker

```bash
docker run --name srcc -d -p 80:8080 roquie/source-concater:latest
```

#### Build

* `cd /path/to/project/root`
* `yarn build`
* `docker build -t srcc:latest .`

#### Run

* `docker run --rm --name srcc -d -p 80:8080 srcc:latest`
* open [http://localhost:8001/](http://localhost:8001/)

#### Stop

* `docker stop srcc`

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
