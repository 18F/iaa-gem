require 'pdf_forms'
require 'json'
require 'pry'
require 'cliver'

module IAA
  class BaseForm
    def init_pdftk(pdftk_path)
      PdfForms.new(pdftk_path || Cliver.detect('pdftk'))
    end
    
    def get_full_path(path)
      File.expand_path(File.join('..', '..', path), __FILE__)
    end
    
    def get_mapper_fields(path)
      #full_path = File.expand_path(File.join('..', '..', path), __FILE__)
      full_path = get_full_path(path)
      JSON.parse(File.read(full_path))
    end

    def load_fields_from_pdf!(pdf_path, pdftk, form_object)
      return if pdf_path.nil?
      fields = pdftk.get_fields(pdf_path)
      fields.each do |field|
        value = field.value rescue nil
        form_object.set_attr(field.name, value)
      end
    end

    def initialize(pdf_path: nil, pdftk_path: nil)
      @fields = get_mapper_fields(self.class.mapper_path)
      @pdftk = init_pdftk(pdftk_path)
      @save_filename = nil
      @fill_values = {}
      load_fields_from_pdf!(pdf_path, @pdftk, self)
      @pdf_path = get_full_path(pdf_path || self.class.default_pdf_path)
      
      @fields.each do |field|
        self.class.send(:define_method, field['attribute_name']) do
          get_attr(field['name'])
        end
      end
      
      @fields.each do |field|
        self.class.send(:define_method, "#{field['attribute_name']}=") do |argument|
          set_attr(field['name'], argument)
        end
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

    def save(save_path='tmp')
      filename = "#{save_path}/#{self.class.form_name}_#{Time.now.to_i}.pdf"
      @pdftk.fill_form @pdf_path, filename, @fill_values
      @filename = filename
    end

    def self.mapper_path
      "lib/mappings/#{self.form_name}.json"
    end

    def self.default_pdf_path
      "lib/pdfs/#{self.form_name}.pdf"
    end

  end
end
