require 'sinatra'
require 'json'

module IAA
  class Server < Sinatra::Base
    post '/7600a' do
      json_params = JSON.parse(request.body.read)
      form = IAA::Form7600A.new
      json_params.each_pair do |key, value|
        form.send("#{key}=", value)
      end
      file = form.save
      send_file(file)
    end
  end
end
