require 'spec_helper'
require 'json'

describe IAA::Form7600B do
  after(:all) do
    FileUtils.rm_rf Dir.glob("spec/output/*")
  end

  it 'has getters' do
    has_getters(IAA::Form7600B)
  end

  it 'has setters' do
    has_setters(IAA::Form7600B)
  end
  
  it 'fills a full 7600B form' do
    fills_a_full_form(IAA::Form7600B)
  end

  it 'saves' do
    saves(IAA::Form7600B, {"net_total_cost" => "100"})
  end
end
