require 'test_helper'

class PromosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @promo = promos(:one)
  end

  test "should get index" do
    get promos_url
    assert_response :success
  end

  test "should get new" do
    get new_promo_url
    assert_response :success
  end

  test "should create promo" do
    assert_difference('Promo.count') do
      post promos_url, params: { promo: {  } }
    end

    assert_redirected_to promo_url(Promo.last)
  end

  test "should show promo" do
    get promo_url(@promo)
    assert_response :success
  end

  test "should get edit" do
    get edit_promo_url(@promo)
    assert_response :success
  end

  test "should update promo" do
    patch promo_url(@promo), params: { promo: {  } }
    assert_redirected_to promo_url(@promo)
  end

  test "should destroy promo" do
    assert_difference('Promo.count', -1) do
      delete promo_url(@promo)
    end

    assert_redirected_to promos_url
  end
end
