# shipit - 0.0.1

E-Commerce website template - Vuetify

## Demo

https://loving-leavitt-9cb65b.netlify.com/

# Team#4 EShop 家電線上商城
## frontend : Build Setup

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report
```

For a detailed explanation on how things work, check out the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).

## backend : build and run
Download and install DrRacket: https://racket-lang.org/download/
``` bash
# build a stand-alone executable server and run it.
raco exe webapi.rkt

# or, in DrRacket, open webapi.rkt, click `run`

# db-userinfo.txt
# the first line is MySQL account
# the second line is password
# make sure the MySQL server has been started (port: 3306, schema: eshop) before you run the backend server!
```

## DB Build
Open MySQL workbench, import schema from `eshop.sql`, and rename it to `eshop`.


