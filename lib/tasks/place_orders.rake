require_relative '../../src/binance_api'
require 'dotenv'
Dotenv.load

namespace :binance do
  desc "Place order"
  task :place_orders do
    binance = BinanceApi.new(ENV['API_KEY'], ENV['SEC_KEY'])
 
    # p binance.depth('XRPBTC')
    # p binance.sign("symbol=LTCBTC&side=BUY&type=LIMIT&timeInForce=GTC&quantity=1&price=0.1&recvWindow=5000&timestamp=1499827319559")\
    #
    #
    #
    symbol = 'LTCBTC'

    result = binance.ticker_price(symbol)
    new_price = JSON.parse(result.body)['price']
    p new_price


    symbol = 'LTCBTC'
    side = 'BUY'
    type = 'LIMIT'
    quantity = 1
    price = new_price
    timestamp = DateTime.now.strftime('%Q').to_i
    timeInForce = 'GTC'
    binance.place_order({symbol: symbol,
                           side: side,
                           type: type,
                           quantity: quantity,
                           timestamp: timestamp,
                           timeInForce: timeInForce,
                           price: price})
  end
end
