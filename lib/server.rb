require 'sinatra'
require 'json'
require 'tempfile'

module IAA
  class Server < Sinatra::Base

    # keep Meteor happy by responding to OPTIONS request
    options '/7600a' do
      halt 200
    end
    
    get '/7600a' do
      begin
        # Create and fill the form
        form = IAA::Form7600A.new
        params.each_pair do |key, value|
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
      rescue => e
        content_type :json

        return {
          error: e.to_s
        }.to_json
      end
    end
    
    post '/7600a' do
      begin
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
      rescue => e
        content_type :json
        
        return {
          error: e.to_s
        }.to_json
      end
    end

  end
end
