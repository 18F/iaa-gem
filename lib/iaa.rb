require "iaa/version"
require 'pdf_forms'
require 'json'
require 'pry'

require 'base_form'
require 'form_7600a'
require 'form_7600b'

module IAA
  module Util
    def self.get_path(path)
      File.join(File.dirname(File.expand_path(__FILE__)), "../#{path}")
    end
  end
end
