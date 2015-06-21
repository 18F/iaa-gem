require 'spec_helper'
require 'json'

describe IAA::Form7600B do
  after(:all) do
    FileUtils.rm_rf Dir.glob("spec/output/*")
  end

  it 'reads an existing PDF' do
    form = IAA::Form7600B.new(pdf_path: 'lib/pdfs/7600B.pdf')
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

  it 'creates a full 7600B form' do
    test_text = "zz"
    form = IAA::Form7600B.new
    fields = JSON.parse(File.read('lib/mappings/7600B.json'))
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
    opened_form = IAA::Form7600B.new(pdf_path: file_path)

    text_fields = fields.select {|f| f["type"] == "Text"}
    button_fields = fields.select {|f| f["type"] == "Button"}

    expect(opened_form.requesting_agency_office_name).to(eq(test_text))
    expect(opened_form.servicing_agency_office_name).to(eq(test_text))
    expect(opened_form.requesting_agency_office_address).to(eq(test_text))
    expect(opened_form.servicing_agency_office_address).to(eq(test_text))
    expect(opened_form.modification).to(eq(test_text))
    expect(opened_form.cancellation).to(eq(test_text))
    expect(opened_form.line).to(eq(test_text))
    expect(opened_form.line1).to(eq(test_text))
    expect(opened_form.line2).to(eq(test_text))
    expect(opened_form.original_line_funding).to(eq(test_text))
    expect(opened_form.original_line_funding1).to(eq(test_text))
    expect(opened_form.original_line_funding2).to(eq(test_text))
    expect(opened_form.original_line_funding3).to(eq(test_text))
    expect(opened_form.original_line_funding_total).to(eq(test_text))
    expect(opened_form.cumulative_funding_changes).to(eq(test_text))
    expect(opened_form.cumulative_funding_changes1).to(eq(test_text))
    expect(opened_form.cumulative_funding_changes2).to(eq(test_text))
    expect(opened_form.cumulative_funding_changes1).to(eq(test_text))
    expect(opened_form.cumulative_funding_changes_total).to(eq(test_text))
    expect(opened_form.funding_change).to(eq(test_text))
    expect(opened_form.funding_change1).to(eq(test_text))
    expect(opened_form.funding_change2).to(eq(test_text))
    expect(opened_form.funding_change3).to(eq(test_text))
    expect(opened_form.funding_change_total).to(eq(test_text))
    expect(opened_form.total_modified_obligation).to(eq(test_text))
    expect(opened_form.total_modified_obligation1).to(eq(test_text))
    expect(opened_form.total_modified_obligation2).to(eq(test_text))
    expect(opened_form.total_modified_obligation2).to(eq(test_text))
    expect(opened_form.total_modified_obligation_total).to(eq(test_text))
    expect(opened_form.total_advance_amount).to(eq(test_text))
    expect(opened_form.total_advance_amount1).to(eq(test_text))
    expect(opened_form.total_advance_amount2).to(eq(test_text))
    expect(opened_form.total_advance_amount3).to(eq(test_text))
    expect(opened_form.total_advance_amount_total).to(eq(test_text))
    expect(opened_form.net_modified_amount).to(eq(test_text))
    expect(opened_form.net_modified_amount1).to(eq(test_text))
    expect(opened_form.net_modified_amount2).to(eq(test_text))
    expect(opened_form.net_modified_amount3).to(eq(test_text))
    expect(opened_form.net_modified_amount_total).to(eq(test_text))
    expect(opened_form.start_date).to(eq(test_text))
    expect(opened_form.end_date).to(eq(test_text))
    #expect(opened_form.gt_and_c_number).to(eq(test_text))
    expect(opened_form.order_number).to(eq(test_text))
    expect(opened_form.mod_number).to(eq(test_text))
    expect(opened_form.tracking_number).to(eq(test_text))
    expect(opened_form.line_number).to(eq(test_text))
    expect(opened_form.requesting_agency_alc).to(eq(test_text))
    expect(opened_form.servicing_asgency_alc).to(eq(test_text))
    expect(opened_form.requesting_agency_sp).to(eq(test_text))
    expect(opened_form.requesting_agency_ata).to(eq(test_text))
    expect(opened_form.requesting_agency_aid).to(eq(test_text))
    expect(opened_form.requesting_agency_bpoa).to(eq(test_text))
    expect(opened_form.requesting_agency_epoa).to(eq(test_text))
    #expect(opened_form.requesting_agency_a).to(eq(test_text))
    expect(opened_form.requesting_agency_mauin).to(eq(test_text))
    expect(opened_form.requesting_agency_sub).to(eq(test_text))
    expect(opened_form.servicing_agency_sp).to(eq(test_text))
    expect(opened_form.servicing_agency_ata).to(eq(test_text))
    expect(opened_form.servicing_agency_aid).to(eq(test_text))
    expect(opened_form.servicing_agency_bpoa).to(eq(test_text))
    expect(opened_form.servicing_agency_epoa).to(eq(test_text))
    #expect(opened_form.servicing_agency_a).to(eq(test_text))
    expect(opened_form.servicing_agency_main).to(eq(test_text))
    expect(opened_form.servicing_agency_sub).to(eq(test_text))
    expect(opened_form.requesting_agency_funding_information_tas).to(eq(test_text))
    expect(opened_form.servicing_agency_funding_information_tas).to(eq(test_text))
    expect(opened_form.requesting_agency_funding_information_betc).to(eq(test_text))
    expect(opened_form.servicing_agency_funding_information_betc).to(eq(test_text))
    expect(opened_form.requesting_agency_funding_information_object_class_code).to(eq(test_text))
    expect(opened_form.servicing_agency_funding_information_object_class_code).to(eq(test_text))
    expect(opened_form.requesting_agency_funding_information_bpn).to(eq(test_text))
    expect(opened_form.servicing_agency_funding_information_bpn).to(eq(test_text))
    expect(opened_form.requesting_agency_funding_information_bpn_plus_4).to(eq(test_text))
    expect(opened_form.servicing_agency_funding_information_bpn_plus_4).to(eq(test_text))
    expect(opened_form.requesting_agency_funding_information_additional_accounting_classification_information_optional).to(eq(test_text))
    expect(opened_form.servicing_agency_funding_information_additional_accounting_classification_information_optional).to(eq(test_text))
    expect(opened_form.requesting_agency_funding_expiration_date).to(eq(test_text))
    expect(opened_form.requesting_agency_funding_cancellation_date).to(eq(test_text))
    expect(opened_form.project_number_title).to(eq(test_text))
    expect(opened_form.description_of_products_and_or_services).to(eq(test_text))
    expect(opened_form.naics_number).to(eq(test_text))
    expect(opened_form.quantity).to(eq(test_text))
    expect(opened_form.unit_price).to(eq(test_text))
    expect(opened_form.quantity_times_unit_price).to(eq(test_text))
    #expect(opened_form.overhead_fees_and_charges).to(eq(test_text))
    expect(opened_form.total_line_amount_obligated).to(eq(test_text))
    expect(opened_form.advance_line_amount).to(eq(test_text))
    expect(opened_form.net_line_amount_due).to(eq(test_text))
    expect(opened_form.contract_cost).to(eq(test_text))
    expect(opened_form.servicing_fees).to(eq(test_text))
    expect(opened_form.total_obligated_cost).to(eq(test_text))
    expect(opened_form.advance_for_line).to(eq(test_text))
    expect(opened_form.net_total_cost).to(eq(test_text))
    expect(opened_form.assisted_acquisition_servicing_fees_explanation).to(eq(test_text))
    expect(opened_form.total_advance_amount_for_the_order).to(eq(test_text))
    expect(opened_form.amount_to_be_accrued).to(eq(test_text))
    expect(opened_form.number_of_months).to(eq(test_text))
    expect(opened_form.explain_accrual_other).to(eq(test_text))
    expect(opened_form.total_net_order_amount).to(eq(test_text))
    expect(opened_form.key_project_and_or_acquisition_milestones).to(eq(test_text))
    expect(opened_form.other_attachments).to(eq(test_text))
    expect(opened_form.explain_other_payment_method).to(eq(test_text))
    expect(opened_form.other_billing_frequency_explanation).to(eq(test_text))
    expect(opened_form.other_payment_terms).to(eq(test_text))
    expect(opened_form.funding_clauses).to(eq(test_text))
    expect(opened_form.agency_name).to(eq(test_text))
    expect(opened_form.point_of_contact).to(eq(test_text))
    expect(opened_form.point_of_contact_email).to(eq(test_text))
    expect(opened_form.delivery_address_room_number).to(eq(test_text))
    expect(opened_form.point_of_contact_telephone_number).to(eq(test_text))
    expect(opened_form.special_shipping_information).to(eq(test_text))
    expect(opened_form.program_officials_requesting_agency_name).to(eq(test_text))
    expect(opened_form.program_officials_requesting_agency_title).to(eq(test_text))
    expect(opened_form.program_officials_requesting_agency_telephone_number).to(eq(test_text))
    expect(opened_form.program_officials_requesting_agency_fax_number).to(eq(test_text))
    expect(opened_form.program_officials_requesting_agency_email_address).to(eq(test_text))
    expect(opened_form.program_officials_requesting_agency_date_signes).to(eq(test_text))
    expect(opened_form.program_officials_servicing_agency_name).to(eq(test_text))
    expect(opened_form.program_officials_servicing_agency_title).to(eq(test_text))
    expect(opened_form.program_officials_servicing_agency_telephone_number).to(eq(test_text))
    expect(opened_form.program_officials_servicing_agency_fax_number).to(eq(test_text))
    expect(opened_form.program_officials_servicing_agency_email_address).to(eq(test_text))
    expect(opened_form.program_officials_servicing_agency_date_signed).to(eq(test_text))
    expect(opened_form.funding_officials_requesting_agency_name).to(eq(test_text))
    expect(opened_form.funding_officials_requesting_agency_title).to(eq(test_text))
    expect(opened_form.funding_officials_requesting_agency_telephone_number).to(eq(test_text))
    expect(opened_form.funding_officials_requesting_agency_fax_number).to(eq(test_text))
    expect(opened_form.funding_officials_requesting_agency_email_address).to(eq(test_text))
    expect(opened_form.funding_officials_requesting_agency_date_signed).to(eq(test_text))
    expect(opened_form.funding_officials_servicing_agency_name).to(eq(test_text))
    expect(opened_form.funding_officials_servicing_agency_title).to(eq(test_text))
    expect(opened_form.funding_officials_servicing_agency_telephone_number).to(eq(test_text))
    expect(opened_form.funding_officials_servicing_agency_fax_number).to(eq(test_text))
    expect(opened_form.funding_officials_servicing_agency_email_address).to(eq(test_text))
    expect(opened_form.funding_officials_servicing_agency_date_signed).to(eq(test_text))
    expect(opened_form.point_of_contact_requesting_agency_name).to(eq(test_text))
    expect(opened_form.point_of_contact_requesting_agency_title).to(eq(test_text))
    expect(opened_form.point_of_contact_requesting_agency_office_address).to(eq(test_text))
    expect(opened_form.point_of_contact_requesting_agency_telephone_number).to(eq(test_text))
    expect(opened_form.requesting_agency_payment_office_fax_number).to(eq(test_text))
    expect(opened_form.requesting_agency_payment_office_email_address).to(eq(test_text))
    expect(opened_form.requesting_agency_payment_office_date).to(eq(test_text))
    expect(opened_form.point_of_contact_servicing_agency_name).to(eq(test_text))
    expect(opened_form.point_of_contact_servicing_agency_title).to(eq(test_text))
    expect(opened_form.point_of_contact_servicing_agency_office_address).to(eq(test_text))
    expect(opened_form.point_of_contact_servicing_agency_telephone_number).to(eq(test_text))
    expect(opened_form.point_of_contact_servicing_agency_fax_number).to(eq(test_text))
    expect(opened_form.point_of_contact_servicing_agency_email_address).to(eq(test_text))
    expect(opened_form.point_of_contact_servicing_agency_date).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_name).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_title).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_address).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_telephone_number).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_fax_number).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_email_address).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_date).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_name).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_title).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_office_address).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_telephone_number).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_fax_number).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_email_address).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_date).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_name2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_title1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_address1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_telephone_number1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_fax_number1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_email_address1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_date1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_name1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_title1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_office_address1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_telephone_number1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_fax_number1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_email_address1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_date1).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_name2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_title2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_address2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_telephone_number2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_fax_number2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_email_address2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_requesting_agency_date2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_name2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_title2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_office_address2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_telephone_number2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_fax_number2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_email_address2).to(eq(test_text))
    expect(opened_form.additional_point_of_contact_servicing_agency_date2).to(eq(test_text))

    File.delete(file_path)
  end

  it 'sets gt_and_c_number' do
    pending("troubleshooting")
    form = IAA::Form7600B.new
    test_text = "lorem"
    form.gt_and_c_number = test_text
    file_path = form.save('spec/output')
    opened_form = IAA::Form7600B.new(pdf_path: file_path)
    expect(opened_form.gt_and_c_number).to(eq(test_text))
    File.delete(file_path)
  end

  it 'sets requesting_agency_a' do
    pending("troubleshooting")
    form = IAA::Form7600B.new
    test_text = "lorem"
    form.requesting_agency_a = test_text
    file_path = form.save('spec/output')
    opened_form = IAA::Form7600B.new(pdf_path: file_path)
    expect(opened_form.requesting_agency_a).to(eq(test_text))
    File.delete(file_path)
  end

  it 'sets servicing_agency_a' do
    pending("troubleshooting")
    form = IAA::Form7600B.new
    test_text = "lorem"
    form.servicing_agency_a = test_text
    file_path = form.save('spec/output')
    opened_form = IAA::Form7600B.new(pdf_path: file_path)
    expect(opened_form.servicing_agency_a).to(eq(test_text))
    File.delete(file_path)
  end

  it 'sets overhead_fees_and_charges' do
    pending("troubleshooting")
    form = IAA::Form7600B.new
    test_text = "lorem"
    form.overhead_fees_and_charges = test_text
    file_path = form.save('spec/output')
    opened_form = IAA::Form7600B.new(pdf_path: file_path)
    expect(opened_form.overhead_fees_and_charges).to(eq(test_text))
    File.delete(file_path)
  end

end
