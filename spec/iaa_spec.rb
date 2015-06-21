require 'spec_helper'
require 'json'

describe IAA do
  it 'has a version number' do
    expect(IAA::VERSION).not_to be nil
  end

  it 'reads an existing PDF' do
    form = IAA::Form7600A.new(pdf_path: 'lib/pdfs/7600A.pdf')
    expect(form.start_date).to(eq("FILL IN"))
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

  it 'creates a full 7600A form' do
    test_text = "lorem ipsum"
    form = IAA::Form7600A.new
    fields = JSON.parse(File.read('lib/mappings/7600A.json'))
    fields.each do |field|
      if field["type"] == "Text"
        form.set_attr(field["name"], test_text)
      end
      if field["type"] == "Button"
        options = field["options"]
        if options && !options.empty?
          options = field["options"]
          selection = options.first
          form.set_attr(field["name"], selection)
        end
      end
    end
    file_path = form.save('spec/output')
    opened_form = IAA::Form7600A.new(pdf_path: file_path)

    text_fields = fields.select {|f| f["type"] == "Text"}
    button_fields = fields.select {|f| f["type"] == "Button"}

    expect(opened_form.servicing_agency_tracking_number).to(eq(test_text))
    expect(opened_form.start_date).to(eq(test_text))
    expect(opened_form.end_date).to(eq(test_text))
    expect(opened_form.requesting_agency_name).to(eq(test_text))
    expect(opened_form.requesting_agency_address).to(eq(test_text))
    expect(opened_form.servicing_agency_name).to(eq(test_text))
    expect(opened_form.servicing_agency_address).to(eq(test_text))
    expect(opened_form.amendment).to(eq(test_text))
    expect(opened_form.cancellation_explanation).to(eq(test_text))
    expect(opened_form.other_renewal_period).to(eq(test_text))
    expect(opened_form.requesting_agency_statutory_authority_title_and_citation).to(eq(test_text))
    #expect(opened_form.gt_and_c_number).to(eq(test_text))
    expect(opened_form.mod_number).to(eq(test_text))
    expect(opened_form.direct_cost).to(eq(test_text))
    expect(opened_form.overhead_fees_and_charges).to(eq(test_text))
    expect(opened_form.total_estimated_amount).to(eq(test_text))
    expect(opened_form.requesting_agency_scope).to(eq(test_text))
    expect(opened_form.requesting_agency_roles_and_responsibilities).to(eq(test_text))
    #expect(opened_form.general_explanation_overhead_fees_and_charges).to(eq(test_text))
    expect(opened_form.statory_authority).to(eq(test_text))
    expect(opened_form.statutory_authority_1).to(eq(test_text))
    expect(opened_form.restrictions).to(eq(test_text))
    expect(opened_form.requesting_agency_organiations_authorized).to(eq(test_text))
    expect(opened_form.servicing_agency_organiations).to(eq(test_text))
    expect(opened_form.requesting_agency_clauses).to(eq(test_text))
    #expect(opened_form.number_of_days_this_iaa_may_be_terminated).to(eq(test_text))
    expect(opened_form.servicing_agency_clauses).to(eq(test_text))
    expect(opened_form.additional_attachments).to(eq(test_text))
    expect(opened_form.requesting_agency_name).to(eq(test_text))
    expect(opened_form.servicing_agency_name).to(eq(test_text))
    expect(opened_form.requesting_agency_title).to(eq(test_text))
    expect(opened_form.servicing_agency_title).to(eq(test_text))
    expect(opened_form.requesting_agency_telephone_number).to(eq(test_text))
    expect(opened_form.servicing_agency_telephone_number).to(eq(test_text))
    expect(opened_form.requesting_agency_fax_number).to(eq(test_text))
    expect(opened_form.servicing_agency_fax_number).to(eq(test_text))
    expect(opened_form.requesting_agency_email_address).to(eq(test_text))
    expect(opened_form.servicing_agency_email_address).to(eq(test_text))
    expect(opened_form.requesting_agency_approval_date).to(eq(test_text))
    expect(opened_form.servicing_agency_approval_date).to(eq(test_text))

    expect(["No", "Off", "Yes"]).to(include(opened_form.radio1))
    expect(["AMENDMENT", "CANCELLATION", "NEW", "Off"]).to(include(opened_form.radio2))
    expect(["NO", "Off", "Yes"]).to(include(opened_form.radio3))
    expect(["2", "Off", "Yes"]).to(include(opened_form.radio4))
    expect(["2", "Off", "SINGLE ORDER IAA"]).to(include(opened_form.radio5))
    expect(["2", "Off", "Yes"]).to(include(opened_form.radio6))
    expect(["2", "Off", "Requesting FF", "Requesting OA", "Requesting RF", "Requesting WCF"]).to(include(opened_form.radio7))
    expect(["0", "1", "2", "3", "4", "Off"]).to(include(opened_form.radio8))

    File.delete(file_path)
  end

  it 'sets gt_and_c_number' do
    pending("troubleshooting")
    form = IAA::Form7600A.new
    test_text = "lorem"
    form.gt_and_c_number = test_text
    file_path = form.save('spec/output')
    opened_form = IAA::Form7600A.new(pdf_path: file_path)
    expect(opened_form.gt_and_c_number).to(eq(test_text))
    File.delete(file_path)
  end

  it 'sets general_explanation_overhead_fees_and_charges' do
    pending("troubleshooting")
    form = IAA::Form7600A.new
    test_text = "lorem"
    form.general_explanation_overhead_fees_and_charges = test_text
    file_path = form.save('spec/output')
    opened_form = IAA::Form7600A.new(pdf_path: file_path)
    expect(opened_form.general_explanation_overhead_fees_and_charges).to(eq(test_text))
    File.delete(file_path)
  end

  it 'sets number_of_days_this_iaa_may_be_terminated' do
    pending("troubleshooting")
    form = IAA::Form7600A.new
    test_text = "lorem"
    form.number_of_days_this_iaa_may_be_terminated = test_text
    file_path = form.save('spec/output')
    opened_form = IAA::Form7600A.new(pdf_path: file_path)
    expect(opened_form.number_of_days_this_iaa_may_be_terminated).to(eq(test_text))
    File.delete(file_path)
  end
end
