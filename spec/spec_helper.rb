$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'iaa'
require 'sinatra'
require 'sinatra/base'
require 'rack/test'
require 'pry'

def post_json(uri, json)
  post(uri, json, { "CONTENT_TYPE" => "application/json" })
end
 
def app
  IAA::Server
end
 
RSpec.configure do |config|
  config.tty = true
  config.include Rack::Test::Methods
end

ALPHABET = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]

def has_setters(form_class)
  form_name = form_class.form_name
  form = form_class.new
  fields = JSON.parse(File.read("lib/mappings/#{form_name}.json"))
  method_names = fields.map {|f| f["attribute_name"]}.reject(&:nil?)
  method_names.each do |method_name|
    expect(form).to(respond_to("#{method_name}="))
  end
end

def has_getters(form_class)
  form_name = form_class.form_name
  form = form_class.new
  fields = JSON.parse(File.read("lib/mappings/#{form_name}.json"))
  method_names = fields.map {|f| f["attribute_name"]}.reject(&:nil?)
  method_names.each do |method_name|
    expect(form).to(respond_to(method_name))
  end
end

def writes_and_reads_field(form_class, field, value)
  form = form_class.new
  form.send("#{field}=", value)
  file_path = form.save('spec/output')
  opened_form = form_class.new(pdf_path: file_path)
  read_field = opened_form.send(field)
  expect(read_field).to(eq(value), "Expected #{field} to output '#{value}', got '#{read_field}'")
  File.delete(file_path)
end

def fills_a_full_form(form_class)
  form_name = form_class.form_name
  fields = JSON.parse(File.read("lib/mappings/#{form_name}.json"))
  fields.each do |field|
    if field["type"] == "Text"
      writes_and_reads_field(form_class, field['attribute_name'], ALPHABET.sample)
    end
    if field["type"] == "Button"
      writes_and_reads_field(form_class, field['attribute_name'], field['options'].sample)
    end
  end
end

def saves(form_class, kv_pair)
  form = form_class.new
  key = kv_pair.keys.first
  value = kv_pair.values.first
  form.send("#{key}=", value)
  file_path = form.save('spec/output')
  opened_form = form_class.new(pdf_path: file_path)
  expect(opened_form.send(key)).to(eq(value))
  File.delete(file_path)
end

