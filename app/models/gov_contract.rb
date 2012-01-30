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

    if params[:dField] == nil || params[:query] == nil
      return nil
    end

    default_field = params[:dField].to_sym
    search_value = params[:query]

    puts search_value.inspect

    search = GovContract.search do
      fulltext(search_value) do
        fields default_field
      end
    end

    @search_results = search.results

  end
end
