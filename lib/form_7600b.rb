require "iaa/version"
require 'pdf_forms'
require 'json'
require 'pry'

module IAA
  class Form7600B
    def initialize(pdf_path: nil, pdftk_path: nil)
      @fields = JSON.parse(File.read('lib/mappings/7600B.json'))
      if pdftk_path
        @pdftk = PdfForms.new(pdftk_path)
      else
        path = `which pdftk`.strip
        @pdftk = PdfForms.new(path)
      end
      @save_filename = nil
      @fill_values = {}

      if pdf_path
        @pdf_path = pdf_path
        fields = @pdftk.get_fields(@pdf_path)
        fields.each do |field|
          value = field.value rescue nil
          set_attr(field.name, value)
        end
      else
        @pdf_path = 'lib/pdfs/7600B.pdf'
      end
    end

    def read_fields
      @pdftk.get_fields(@pdf_path).map do |field|
        {
          "name" => field.name,
          "options" => field.options,
          "type" => field.type,
          "value" => field.value
        }
      end
    end

    def read_field(field_name)
      read_fields.find {|f| f["name"] == field_name}["value"]
    end

    def fill_attributes
      @fill_values
    end

    def filename
      @save_filename
    end

    def set_attr(field, value)
      @fill_values[field] = value
    end

    def get_attr(field)
      @fill_values[field]
    end

    def save(save_path='~')
      filename = "#{save_path}/7600B_#{Time.now.to_i}.pdf"
      @pdftk.fill_form @pdf_path, filename, @fill_values
      @filename = filename
    end

  end
end
