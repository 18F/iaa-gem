require "iaa/version"
require 'pdf_forms'
require 'json'
require 'pry'

module IAA
  class Form7600A
    def initialize(pdf_path: nil)
      @fields = JSON.parse(File.read('lib/mappings/7600A.json'))
      @pdftk = PdfForms.new('/usr/local/bin/pdftk')
      @save_filename = nil
      @fill_values = {}
      
      if pdf_path
        @pdf_path = pdf_path
        fields = @pdftk.get_fields(pdf_path)
        fields.each do |field|
          value = field.value rescue nil
          set_attr(field.name, value)
        end        
      else
        @pdf_path = 'lib/pdfs/7600A.pdf'
      end
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
      filename = "#{save_path}/7600A_#{Time.now.to_i}.pdf"
      @pdftk.fill_form @pdf_path, filename, @fill_values
      @filename = filename
    end
    
    def servicing_agency_tracking_number=(new_servicing_agency_tracking_number)
      set_attr("Servicing Agency Agreement Tracking Number (Optional)", new_servicing_agency_tracking_number)
    end

    def servicing_agency_tracking_number
      get_attr("Servicing Agency Agreement Tracking Number (Optional)")
    end

    def start_date=(new_start_date)
      set_attr("Start Date", new_start_date)
    end

    def start_date
      get_attr("Start Date")
    end

    def end_date=(new_end_date)
      set_attr("End Date", new_end_date)
    end

    def end_date
      get_attr("End Date")
    end

    def requesting_agency_name=(new_requesting_agency_name)
      set_attr("Name Requesting Agency of Products/Services", new_requesting_agency_name)
    end

    def requesting_agency_name
      get_attr("Name Requesting Agency of Products/Services")
    end

    def requesting_agency_address=(new_requesting_agency_address)
      set_attr("Address Requesting Agency of Products/Services", new_requesting_agency_address)
    end

    def requesting_agency_address
      get_attr("Address Requesting Agency of Products/Services")
    end

    def servicing_agency_name=(new_servicing_agency_name)
      set_attr("Name Servicing Agency Providing Products/Services", new_servicing_agency_name)
    end

    def servicing_agency_name
      get_attr("Name Servicing Agency Providing Products/Services")
    end

    def servicing_agency_address=(new_servicing_agency_address)
      set_attr("Address Servicing Agency Providing Products/Services", new_servicing_agency_address)
    end

    def servicing_agency_address
      get_attr("Address Servicing Agency Providing Products/Services")
    end

    def radio1=(new_radio1)
      set_attr("Radio Button1", new_radio1)
    end

    def radio1
      get_attr("Radio Button1")
    end

    def radio2=(new_radio2)
      set_attr("Radio Button2", new_radio2)
    end

    def radio2
      get_attr("Radio Button2")
    end

    def radio3=(new_radio3)
      set_attr("Radio Button3", new_radio3)
    end

    def radio3
      get_attr("Radio Button3")
    end

    def radio4=(new_radio4)
      set_attr("Radio Button4", new_radio4)
    end

    def radio4
      get_attr("Radio Button4")
    end

    def radio5=(new_radio5)
      set_attr("Radio Button5", new_radio5)
    end

    def radio5
      get_attr("Radio Button5")
    end

    def radio6=(new_radio6)
      set_attr("Radio Button6", new_radio6)
    end

    def radio6
      get_attr("Radio Button6")
    end

    def amendment=(new_amendment)
      set_attr("Amendment", new_amendment)
    end

    def amendment
      get_attr("Amendment")
    end

    def cancellation_explanation=(new_cancellation_explanation)
      set_attr("IAA Cancellation Explanation", new_cancellation_explanation)
    end

    def cancellation_explanation
      get_attr("IAA Cancellation Explanation")
    end

    def other_renewal_period=(new_other_renewal_period)
      set_attr("Other Renewal Period", new_other_renewal_period)
    end

    def other_renewal_period
      get_attr("Other Renewal Period")
    end

    def requesting_agency_statutory_authority_title_and_citation=(new_requesting_agency_statutory_authority_title_and_citation)
      set_attr("Requesting Agency's Statutory Authority Title and Citation", new_requesting_agency_statutory_authority_title_and_citation)
    end

    def requesting_agency_statutory_authority_title_and_citation
      get_attr("Requesting Agency's Statutory Authority Title and Citation")
    end

    def gt_and_c_number=(new_gt_and_c_number)
      set_attr("GT&amp;C #", new_gt_and_c_number)
    end

    def gt_and_c_number
      get_attr("GT&amp;C #")
    end

    def mod_number=(new_mod_number)
      set_attr("Mod #", new_mod_number)
    end

    def mod_number
      get_attr("Mod #")
    end

    def direct_cost=(new_direct_cost)
      set_attr("Direct  Cost", new_direct_cost)
    end

    def direct_cost
      get_attr("Direct  Cost")
    end

    def overhead_fees_and_charges=(new_overhead_fees_and_charges)
      set_attr("Overhead Fees  Charges", new_overhead_fees_and_charges)
    end

    def overhead_fees_and_charges
      get_attr("Overhead Fees  Charges")
    end

    def total_estimated_amount=(new_total_estimated_amount)
      set_attr("Total Estimated Amount", new_total_estimated_amount)
    end

    def total_estimated_amount
      get_attr("Total Estimated Amount")
    end

    def requesting_agency_scope=(new_requesting_agency_scope)
      set_attr("11 Requesting Agencys Scope State andor list attachments that support Requesting Agencys Scope", new_requesting_agency_scope)
    end

    def requesting_agency_scope
      get_attr("11 Requesting Agencys Scope State andor list attachments that support Requesting Agencys Scope")
    end

    def requesting_agency_roles_and_responsibilities=(new_requesting_agency_roles_and_responsibilities)
      set_attr("12 Roles  Responsibilities for the Requesting Agency and Servicing Agency State andor list attachments for the roles and responsibilities for the Requesting Agency and the Servicing Agency", new_requesting_agency_roles_and_responsibilities)
    end

    def requesting_agency_roles_and_responsibilities
      get_attr("12 Roles  Responsibilities for the Requesting Agency and Servicing Agency State andor list attachments for the roles and responsibilities for the Requesting Agency and the Servicing Agency")
    end

    def radio7=(new_radio7)
      set_attr("Radio Button7", new_radio7)
    end

    def radio7
      get_attr("Radio Button7")
    end

    def radio8=(new_radio8)
      set_attr("Radio Button8", new_radio8)
    end

    def radio8
      get_attr("Radio Button8")
    end

    def generation_explanation_overhead_fees_and_charges=(new_generation_explanation_overhead_fees_and_charges)
      set_attr("General Explanation Overhead Fees &amp; Charges", new_generation_explanation_overhead_fees_and_charges)
    end

    def generation_explanation_overhead_fees_and_charges
      get_attr("General Explanation Overhead Fees &amp; Charges")
    end

    def statory_authority=(new_statory_authority)
      set_attr("Statutory authority", new_statory_authority)
    end

    def statory_authority
      get_attr("Statutory authority")
    end

    def statutory_authority_1=(new_statutory_authority_1)
      set_attr("Statutory Authority1", new_statutory_authority_1)
    end

    def statutory_authority_1
      get_attr("Statutory Authority1")
    end

    def restrictions=(new_restrictions)
      set_attr("13 Restrictions Optional State andor attach unique requirements andor mission specific restrictions specific to this IAA", new_restrictions)
    end

    def restrictions
      get_attr("13 Restrictions Optional State andor attach unique requirements andor mission specific restrictions specific to this IAA")
    end

    def requesting_agency_organiations_authorized=(new_requesting_agency_organiations_authorized)
      set_attr("17  Assisted Acquisition Agreements  Requesting Agencys Organizations Authorized To Request Acquisition Assistance for this IAA State or attach a list of Requesting Agencys organizations authorized to request acquisition assistance for this IAA", new_requesting_agency_organiations_authorized)
    end

    def requesting_agency_organiations_authorized
      get_attr("17  Assisted Acquisition Agreements  Requesting Agencys Organizations Authorized To Request Acquisition Assistance for this IAA State or attach a list of Requesting Agencys organizations authorized to request acquisition assistance for this IAA")
    end

    def servicing_agency_organiations=(new_servicing_agency_organiations)
      set_attr("18  Assisted Acquisition Agreements  Servicing Agencys Organizations authorized to Provide Acquisition Assistance for this IAA State or attach a list of Servicing Agencys organizations authorized to provide acquisition for this IAA", new_servicing_agency_organiations)
    end

    def servicing_agency_organiations
      get_attr("18  Assisted Acquisition Agreements  Servicing Agencys Organizations authorized to Provide Acquisition Assistance for this IAA State or attach a list of Servicing Agencys organizations authorized to provide acquisition for this IAA")
    end

    def requesting_agency_clauses=(new_requesting_agency_clauses)
      set_attr("19 Requesting Agency Clauses Optional State andor attach any additional Requesting Agency clauses", new_requesting_agency_clauses)
    end

    def requesting_agency_clauses
      get_attr("19 Requesting Agency Clauses Optional State andor attach any additional Requesting Agency clauses")
    end

    def number_of_days_this_iaa_may_be_terminated=(new_number_of_days_this_iaa_may_be_terminated)
      set_attr("No. of days this IAA may be terminated", new_number_of_days_this_iaa_may_be_terminated)
    end

    def number_of_days_this_iaa_may_be_terminated
      get_attr("No. of days this IAA may be terminated")
    end

    def servicing_agency_clauses=(new_servicing_agency_clauses)
      set_attr("20 Servicing Agency Clauses Optional State andor attach any additional Servicing Agency clauses", new_servicing_agency_clauses)
    end

    def servicing_agency_clauses
      get_attr("20 Servicing Agency Clauses Optional State andor attach any additional Servicing Agency clauses")
    end

    def additional_attachments=(new_additional_attachments)
      set_attr("21 Additional Requesting Agency andor Servicing Agency Attachments Optional State andor attach any additional Requesting Agency andor Servicing Agency attachments", new_additional_attachments)
    end

    def additional_attachments
      get_attr("21 Additional Requesting Agency andor Servicing Agency Attachments Optional State andor attach any additional Requesting Agency andor Servicing Agency attachments")
    end

    def requesting_agency_name=(new_requesting_agency_name)
      set_attr("Requesting Agency Name", new_requesting_agency_name)
    end

    def requesting_agency_name
      get_attr("Requesting Agency Name")
    end

    def servicing_agency_name=(new_servicing_agency_name)
      set_attr("Servicing Agency Name", new_servicing_agency_name)
    end

    def servicing_agency_name
      get_attr("Servicing Agency Name")
    end

    def requesting_agency_title=(new_requesting_agency_title)
      set_attr("Requesting Agency Title", new_requesting_agency_title)
    end

    def requesting_agency_title
      get_attr("Requesting Agency Title")
    end

    def servicing_agency_title=(new_servicing_agency_title)
      set_attr("Servicing Agency Title", new_servicing_agency_title)
    end

    def servicing_agency_title
      get_attr("Servicing Agency Title")
    end

    def requesting_agency_telephone_number=(new_requesting_agency_telephone_number)
      set_attr("Requesting Agency Telephone Number", new_requesting_agency_telephone_number)
    end

    def requesting_agency_telephone_number
      get_attr("Requesting Agency Telephone Number")
    end

    def servicing_agency_telephone_number=(new_servicing_agency_telephone_number)
      set_attr("Servicing Agency Telephone Number", new_servicing_agency_telephone_number)
    end

    def servicing_agency_telephone_number
      get_attr("Servicing Agency Telephone Number")
    end

    def requesting_agency_fax_number=(new_requesting_agency_fax_number)
      set_attr("Requesting Agency Fax Number", new_requesting_agency_fax_number)
    end

    def requesting_agency_fax_number
      get_attr("Requesting Agency Fax Number")
    end

    def servicing_agency_fax_number=(new_servicing_agency_fax_number)
      set_attr("Servicing Agency Fax Number", new_servicing_agency_fax_number)
    end

    def servicing_agency_fax_number
      get_attr("Servicing Agency Fax Number")
    end

    def requesting_agency_email_address=(new_requesting_agency_email_address)
      set_attr("Requesting Agency Email Address", new_requesting_agency_email_address)
    end

    def requesting_agency_email_address
      get_attr("Requesting Agency Email Address")
    end

    def servicing_agency_email_address=(new_servicing_agency_email_address)
      set_attr("Servicing Agency Email Address", new_servicing_agency_email_address)
    end

    def servicing_agency_email_address
      get_attr("Servicing Agency Email Address")
    end

    def requesting_agency_approval_date=(new_requesting_agency_approval_date)
      set_attr("Requesting Agency Approval Date", new_requesting_agency_approval_date)
    end

    def requesting_agency_approval_date
      get_attr("Requesting Agency Approval Date")
    end

    def servicing_agency_approval_date=(new_servicing_agency_approval_date)
      set_attr("Servicing Agency Approval Date", new_servicing_agency_approval_date)
    end

    def servicing_agency_approval_date
      get_attr("Servicing Agency Approval Date")
    end
    
  end
end
