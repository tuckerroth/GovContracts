require 'test_helper'

class GovContractsControllerTest < ActionController::TestCase
  setup do
    @gov_contract = gov_contracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gov_contracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gov_contract" do
    assert_difference('GovContract.count') do
      post :create, gov_contract: @gov_contract.attributes
    end

    assert_redirected_to gov_contract_path(assigns(:gov_contract))
  end

  test "should show gov_contract" do
    get :show, id: @gov_contract
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gov_contract
    assert_response :success
  end

  test "should update gov_contract" do
    put :update, id: @gov_contract, gov_contract: @gov_contract.attributes
    assert_redirected_to gov_contract_path(assigns(:gov_contract))
  end

  test "should destroy gov_contract" do
    assert_difference('GovContract.count', -1) do
      delete :destroy, id: @gov_contract
    end

    assert_redirected_to gov_contracts_path
  end
end
