class CreateGovContracts < ActiveRecord::Migration
  def change
    create_table :gov_contracts do |t|
      t.string :award_type
      t.string :contract_pricing
      t.string :contracting_agent
      t.date :date_signed
      t.string :reason_for_modification
      t.string :contract_description
      t.decimal  :dollars_obligation, precision: 8, scale: 2
      t.string :extent_completed
      t.string :agency_id
      t.string :funding_agency
      t.string :major_agency
      t.string :parent_recipient
      t.string :product_or_service_code
      t.string :program_source_description
      t.string :recipient_city
      t.string :recipient_name
      t.string :recipient_zip
      t.string :type_of_transaction

      t.timestamps
    end
  end
end
