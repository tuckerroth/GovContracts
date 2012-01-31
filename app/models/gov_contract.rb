class GovContract < ActiveRecord::Base

  searchable do
    text :award_type, :contract_pricing, :contracting_agent
    date :date_signed
    text :contract_description
    double :dollars_obligation
    text :extent_completed, :agency_id, :funding_agency, :major_agency, :parent_recipient
    text :product_or_service_code, :program_source_description, :recipient_city, :recipient_name, :recipient_zip, :type_of_transaction
  end

  # @param params [Hash] query params from controller
  def self.perform_search(params)

    return nil unless params[:dField].present? && params[:query].present? && params[:items_per_page].present?

    default_field = params[:dField].to_sym
    query = params[:query]
    num_items_to_fetch = Integer(params[:items_per_page])

    page_num_to_fetch = 1;
    page_num_to_fetch = Integer(params[:page_num]) if params[:page_num].present?

    puts "-------------------  Query  ----------------------"
    puts "Searching for '" + query + "' in search field '" + default_field.to_s + "'"
    puts ""

    # minimum_match(1) turns this into an OR query.  Note, AND is
    # still respected.
    search = GovContract.search do
      keywords query do
        fields default_field
        minimum_match(1)
      end
      # Constrain by dollar amount if both start and end are present
      if params[:dollars_start].present? && params[:dollars_end].present?
        with(:dollars_obligation, Float(params[:dollars_start])..Float(params[:dollars_end]))
      end
      paginate :page => page_num_to_fetch, :per_page => num_items_to_fetch
      order_by(:dollars_obligation, :desc)
    end

  end
end
