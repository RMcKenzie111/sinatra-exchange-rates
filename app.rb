require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do

  the_key = ENV.fetch("EXCHANGE_RATE_KEY")
  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  raw_data = HTTP.get(api_url)

  raw_data_string = raw_data.to_s

  parsed_data = JSON.parse(raw_data_string)

  #get symbols from the JSON
  @symbols = parsed_data.fetch("currencies").keys

  #@symbols.each do |list_symbols|
   # @list_symbols = list_symbols
  #end

  #1.times do
  #  @list_symbols.push(@symbols)
  #end

  #render view template to show symbols
  erb(:home)
end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  # some more code to parse the URL and render a view template
  raw_data = HTTP.get(api_url)

  raw_data_string = raw_data.to_s

  parsed_data = JSON.parse(raw_data_string)

  #get symbols from the JSON
  @symbols = parsed_data.fetch("currencies").keys
  #@symbolss = parsed_data.fetch("currencies").values full names of currencies

  erb(:dynmc_from_currency)

end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  api_url = "http://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"

  # some more code to parse the URL and render a view template
  raw_data = HTTP.get(api_url)

  raw_data_string = raw_data.to_s

  parsed_data = JSON.parse(raw_data_string)

  @symbols = parsed_data.fetch("conversions").values

  @symbols.each do |zebra, giraffe|
    @key = zebra
    @value = giraffe
   
 end
  


  #get symbols from the JSON
  #@symbols = parsed_data.fetch("currencies").keys

  erb(:flexible)


end
