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

    return [] unless params[:dField].present? && params[:query].present?

    default_field = params[:dField].to_sym
    search_value = params[:query]

    puts search_value.inspect

    # minimum_match(1) turns this into an OR query.  Note, AND is
    # still respected.
    search = GovContract.search do
      keywords search_value do
        fields default_field
        minimum_match(1)
      end
      # Constrain by dollar amount if both start and end are present
      if params[:dollars_start].present? && params[:dollars_end].present?
        with(:dollars_obligation, Float(params[:dollars_start])..Float(params[:dollars_end]))
      end
      order_by(:dollars_obligation, :desc)
    end

    @search_results = search.results

  end
end
