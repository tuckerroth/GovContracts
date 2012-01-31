require 'csv'

class GovContractsController < ApplicationController

  #Contstants to define fields we want from spreadsheet data
  AWARD_TYPE = 2
  CONTRACT_PRICING = 3
  CONTRACTING_AGENT = 4
  DATE_SIGNED = 6
  REASON_FOR_MOD = 7
  CONTRACT_DESC = 8
  DOLLARS_OBLIG = 9
  EXTENT_COMPLETED = 10
  AGENCY_ID = 13
  FUNDING_AGENCY = 14
  MAJOR_AGENCY = 18
  PARENT_RECIPIENT = 23
  PROD_OR_SERV_CODE = 30
  PROGRAM_SRC_DESC = 34
  RECIPIENT_CITY = 36
  RECIPIENT_NAME = 38
  RECIPIENT_ZIP = 41
  TYPE_OF_TRANSACTION = 43

  # GET /gov_contracts
  # GET /gov_contracts.json
  def index
    @gov_contracts = GovContract.perform_search params

    @results_size = @gov_contracts.size
    @user_query = params[:query]

    puts 'Results Size = ' + @results_size.to_s

    respond_to do |format|
      format.html # indexOLD.html.erb
      format.json { render json: @gov_contracts }
      format.js { render "index.js.erb" }
    end
  end

  # GET /gov_contracts/1
  # GET /gov_contracts/1.json
  def show
    @gov_contract = GovContract.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gov_contract }
    end
  end

  # GET /gov_contracts/new
  # GET /gov_contracts/new.json
  def new
    @gov_contract = GovContract.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gov_contract }
    end
  end

  # GET /gov_contracts/1/edit
  def edit
    @gov_contract = GovContract.find(params[:id])
  end

  # POST /gov_contracts
  # POST /gov_contracts.json
  def create
    @gov_contract = GovContract.new(params[:gov_contract])

    respond_to do |format|
      if @gov_contract.save
        format.html { redirect_to @gov_contract, notice: 'Gov contract was successfully created.' }
        format.json { render json: @gov_contract, status: :created, location: @gov_contract }
      else
        format.html { render action: "new" }
        format.json { render json: @gov_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gov_contracts/1
  # PUT /gov_contracts/1.json
  def update
    @gov_contract = GovContract.find(params[:id])

    respond_to do |format|
      if @gov_contract.update_attributes(params[:gov_contract])
        format.html { redirect_to @gov_contract, notice: 'Gov contract was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gov_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gov_contracts/1
  # DELETE /gov_contracts/1.json
  def destroy
    @gov_contract = GovContract.find(params[:id])
    @gov_contract.destroy

    respond_to do |format|
      format.html { redirect_to gov_contracts_url }
      format.json { head :no_content }
    end
  end

  # Populate the solr index.
  def reindex

    i = 0
    rows_to_index = 5000;

    CSV.foreach('GovSpending.csv.xls') do |row|

      # Skip the first row
      if i == 0
        i += 1
        next
      end

      govContract = GovContract.new
      govContract.award_type = row[AWARD_TYPE]
      govContract.contract_pricing = row[CONTRACT_PRICING]
      govContract.contracting_agent = row[CONTRACTING_AGENT]

      #handle the date
      dateSplitAry = row[DATE_SIGNED].split("-")
      if dateSplitAry.size == 3
        puts "Month: " + dateSplitAry[0] + "Day: " + dateSplitAry[1] + "Year: " + dateSplitAry[2]
        dateSigned = dateSplitAry[2] + "-" + dateSplitAry[0] + "-" + dateSplitAry[1]
        govContract.date_signed = Date.parse(dateSigned)
      end

      govContract.reason_for_modification = row[REASON_FOR_MOD]
      govContract.contract_description = row[CONTRACT_DESC]
      govContract.dollars_obligation = row[DOLLARS_OBLIG]
      govContract.extent_completed = row[EXTENT_COMPLETED]
      govContract.agency_id = row[AGENCY_ID]
      govContract.funding_agency = row[FUNDING_AGENCY]
      govContract.major_agency = row[MAJOR_AGENCY]
      govContract.parent_recipient = row[PARENT_RECIPIENT]
      govContract.product_or_service_code = row[PROD_OR_SERV_CODE]
      govContract.program_source_description = row[PROGRAM_SRC_DESC]
      govContract.recipient_city = row[RECIPIENT_CITY]
      govContract.recipient_name = row[RECIPIENT_NAME]
      govContract.recipient_zip = row[RECIPIENT_ZIP]
      govContract.type_of_transaction = row[TYPE_OF_TRANSACTION]

      # Save it
      govContract.save

      i += 1
      # while testing, index only 'rows_to_index' rows
      break if i > rows_to_index

    end

    respond_to do |format|
      format.html { redirect_to gov_contracts_url }
      format.json { head :no_content }
    end

  end
end
