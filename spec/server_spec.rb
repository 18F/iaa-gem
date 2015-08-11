require 'spec_helper'
require 'tempfile'

describe IAA::Server do
  context "POST '/7600a'" do
    let(:form_7600a_params) do
      {
        "servicing_agency_tracking_number"=>"1234",
        "start_date"=>"05-30-2015",
        "end_date"=>"08-30-2015",
        "requesting_agency_name_of_products_services"=>"lorem",
        "requesting_agency_address"=>"ipsum",
        "servicing_agency_name_products_services"=>"vandelay",
        "servicing_agency_address"=>"lorem",
        "radio1"=>"Yes",
        "radio2"=>"NEW",
        "radio3"=>"Yes",
        "radio4"=>"Off",
        "radio5"=>"SINGLE ORDER IAA",
        "radio6"=>"Yes",
        "amendment"=>"amendment?",
        "cancellation_explanation"=>"no explanation",
        "other_renewal_period"=>"other renewal period?",
        "requesting_agency_statutory_authority_title_and_citation"=>"47 U.S.C. 303b",
        "gt_and_c_number"=>"888",
        "mod_number"=>"111",
        "direct_cost"=>"$1000",
        "overhead_fees_and_charges"=>"$8000",
        "total_estimated_amount"=>"$9000",
        "requesting_agency_scope"=>"scope scope scope",
        "requesting_agency_roles_and_responsibilities"=>"roles roles",
        "radio7"=>"Requesting RF",
        "radio8"=>"4",
        "general_explanation_overhead_fees_and_charges"=>"General Explanation lorem ipsum",
        "statory_authority"=>"123 U.S.C. 456",
        "statutory_authority_1"=>"123 U.S.C. 456(a)",
        "restrictions"=>"lorem",
        "requesting_agency_organiations_authorized"=>"lorem",
        "servicing_agency_organiations"=>"lorem",
        "requesting_agency_clauses"=>"lorem",
        "number_of_days_this_iaa_may_be_terminated"=>"30",
        "servicing_agency_clauses"=>"lorem",
        "additional_attachments"=>"lorem",
        "requesting_agency_name"=>"ipsum",
        "servicing_agency_name"=>"ipsum",
        "requesting_agency_title"=>"ipsum",
        "servicing_agency_title"=>"ipsum",
        "requesting_agency_telephone_number"=>"(123)-456-7890",
        "servicing_agency_telephone_number"=>"(123)-456-7890",
        "requesting_agency_fax_number"=>"(123)-456-7890",
        "servicing_agency_fax_number"=>"(123)-456-7891",
        "requesting_agency_email_address"=>"ipsum@ipsum.lorem",
        "servicing_agency_email_address"=>"ipsum@ipsum.lorem",
        "requesting_agency_approval_date"=>"07-30-2015",
        "servicing_agency_approval_date"=>"07-30-2015"
      }
    end

    it "fills a full 7600a form" do
      # Post the json to the endpoint.
      # Now `last_response` is available to us, magically.
      post_json "/7600a", form_7600a_params.to_json
      
      # Make sure everything is mostly OK
      expect(last_response.status).to(eq(200))
      
      # Stick the response bytes into a tempfile
      file = Tempfile.new('test.pdf')
      file.write(last_response.body)
      
      # Read the tempfile
      new_pdf = IAA::Form7600A.new(pdf_path: file.path)
      
      # Ensure each attribute matches the original json
      form_7600a_params.each_pair do |key, value|
        got = new_pdf.send(key)
        expect(got).to(eq(value), "Expected #{value}, got #{got}")
      end
    end
    
    it "responds to OPTIONS requests" do
      options "/7600a"
      expect(last_response.status).to(eq(200))
    end
    
    it "returns errors as json" do
      # no params here will throw an error
      post "/7600a"       
      expected_error = {"error"=>"A JSON text must at least contain two octets!"}
      parsed_response = JSON.parse(last_response.body)
      
      expect(parsed_response).to(eq(expected_error))
    end
  end
end

