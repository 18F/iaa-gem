require 'sinatra'
require 'json'
require 'tempfile'

module IAA
  class Server < Sinatra::Base
    post '/7600a' do
      # Get the params
      json_params = JSON.parse(request.body.read)
      
      # Create and fill the form
      form = IAA::Form7600A.new
      json_params.each_pair do |key, value|
        form.send("#{key}=", value)
      end
      
      # Save the form
      file = form.save
      
      # Get the bytes
      bytes = File.read(file) 
      
      # Delete the file
      File.delete(file)
          
      # Put the bytes in a tempfile 
      tmpfile = Tempfile.new('response.pdf')
      tmpfile.write(bytes)
      
      # Let the user download the file
      send_file(tmpfile)
    end
  end
end
