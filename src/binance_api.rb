require 'httparty'
gem 'openssl'
require 'openssl'

class BinanceApi
  include HTTParty
  base_uri 'api.binance.com'

  def initialize(api_key = nil, secret_key = nil)
    @api_key = api_key
    @secret_key = secret_key
  end

  def depth(symbol, limit = 10)
    options = {query: {symbol: symbol, limit: limit}}
    self.class.get('/api/v1/depth', options)
  end

  def ticker_price(symbol)
    options = {query: {symbol: symbol}}
    self.class.get('/api/v3/ticker/price', options)
  end

  def place_order(opt = {})
    signature = generate_signature(opt)
    query_hash = opt.merge(signature: signature)
    headers = {'X-MBX-APIKEY': @api_key}
    options = {query: query_hash, headers: headers}
    puts "options: #{options}"
    response = self.class.post('/api/v3/order/test', options)  # only for test
    if response.code != 200
      p "error"
    end
    p JSON.parse(response.body)
    p "place success"
  end

  private

  def generate_signature(options)
    query_str = convert_to_query_str(options)
    sign(query_str)
  end

  def sign(data)
    OpenSSL::HMAC.hexdigest('SHA256', @secret_key, data)
  end

  def convert_to_query_str(options)
    return nil unless options.class == Hash
    option_arr = []
    options.each {|k, v| option_arr << "#{k}=#{v}"}
    option_arr.join("&")
  end
end