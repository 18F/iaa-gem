require 'spec_helper'
require 'json'

describe IAA::Form7600A do
  after(:all) do
    FileUtils.rm_rf Dir.glob("spec/output/*")
  end

  it 'has getters' do
    form = IAA::Form7600A.new

    fields = JSON.parse(File.read('lib/mappings/7600A.json'))
    method_names = fields.map {|f| f["attribute_name"]}.reject(&:nil?)

    method_names.each do |method_name|
      expect(form).to(respond_to(method_name))
    end
  end

  it 'has setters' do
    form = IAA::Form7600A.new

    fields = JSON.parse(File.read('lib/mappings/7600A.json'))
    method_names = fields.map {|f| f["attribute_name"]}.reject(&:nil?)

    method_names.each do |method_name|
      expect(form).to(respond_to("#{method_name}="))
    end
  end

  it 'saves' do
    form = IAA::Form7600A.new
    start_date = "66-66-6666"
    form.start_date = start_date
    file_path = form.save('spec/output')

    opened_form = IAA::Form7600A.new(pdf_path: file_path)
    expect(opened_form.start_date).to(eq(start_date))

    File.delete(file_path)
  end
end
