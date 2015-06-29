require 'spec_helper'
require 'json'

describe IAA::Form7600A do
  after(:all) do
    FileUtils.rm_rf Dir.glob("spec/output/*")
  end

  it 'has getters' do
    has_getters(IAA::Form7600A)
  end

  it 'has setters' do
    has_setters(IAA::Form7600A)
  end
  
  it 'fills a full 7600A form' do
    fills_a_full_form(IAA::Form7600A)
  end

  it 'saves' do
    saves(IAA::Form7600A, {"start_date" => "66-66-6666"})
  end
end
