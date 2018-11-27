# SETUP

1. install ruby gems
```
bundle install
```

2. input your binance keys

```
cp .env.example .env
```

then replace the dummy keys with your api key and secret key in **.env**


# RUN
```
bundle exec rake binance:place_orders
```