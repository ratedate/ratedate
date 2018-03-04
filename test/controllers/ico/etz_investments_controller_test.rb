require 'test_helper'

class Ico::EtzInvestmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ico_etz_investment = ico_etz_investments(:one)
  end

  test "should get index" do
    get ico_etz_investments_url
    assert_response :success
  end

  test "should get new" do
    get new_ico_etz_investment_url
    assert_response :success
  end

  test "should create ico_etz_investment" do
    assert_difference('Ico::EtzInvestment.count') do
      post ico_etz_investments_url, params: { ico_etz_investment: { etz: @ico_etz_investment.etz, rdt: @ico_etz_investment.rdt, time: @ico_etz_investment.time, wallet: @ico_etz_investment.wallet } }
    end

    assert_redirected_to ico_etz_investment_url(Ico::EtzInvestment.last)
  end

  test "should show ico_etz_investment" do
    get ico_etz_investment_url(@ico_etz_investment)
    assert_response :success
  end

  test "should get edit" do
    get edit_ico_etz_investment_url(@ico_etz_investment)
    assert_response :success
  end

  test "should update ico_etz_investment" do
    patch ico_etz_investment_url(@ico_etz_investment), params: { ico_etz_investment: { etz: @ico_etz_investment.etz, rdt: @ico_etz_investment.rdt, time: @ico_etz_investment.time, wallet: @ico_etz_investment.wallet } }
    assert_redirected_to ico_etz_investment_url(@ico_etz_investment)
  end

  test "should destroy ico_etz_investment" do
    assert_difference('Ico::EtzInvestment.count', -1) do
      delete ico_etz_investment_url(@ico_etz_investment)
    end

    assert_redirected_to ico_etz_investments_url
  end
end
