require 'spec_helper'
require 'json'

describe IAA::Form7600B do
  after(:all) do
    FileUtils.rm_rf Dir.glob("spec/output/*")
  end

  it 'has getters' do
    form = IAA::Form7600B.new

    fields = JSON.parse(File.read('lib/mappings/7600B.json'))
    method_names = fields.map {|f| f["attribute_name"]}.reject(&:nil?)

    method_names.each do |method_name|
      expect(form).to(respond_to(method_name))
    end
  end

  it 'has setters' do
    form = IAA::Form7600B.new

    fields = JSON.parse(File.read('lib/mappings/7600B.json'))
    method_names = fields.map {|f| f["attribute_name"]}.reject(&:nil?)

    method_names.each do |method_name|
      expect(form).to(respond_to("#{method_name}="))
    end
  end

  it 'saves' do
    form = IAA::Form7600B.new
    requesting_agency_office_name = "lorem ipsum"
    form.requesting_agency_office_name = requesting_agency_office_name
    file_path = form.save('spec/output')

    opened_form = IAA::Form7600B.new(pdf_path: file_path)
    expect(opened_form.requesting_agency_office_name).to(eq(requesting_agency_office_name))

    File.delete(file_path)
  end
end
