require 'test_helper'

class SaleTypesControllerTest < ActionController::TestCase
  setup do
    @sale_type = sale_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale_type" do
    assert_difference('SaleType.count') do
      post :create, :sale_type => @sale_type.attributes
    end

    assert_redirected_to sale_type_path(assigns(:sale_type))
  end

  test "should show sale_type" do
    get :show, :id => @sale_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sale_type.to_param
    assert_response :success
  end

  test "should update sale_type" do
    put :update, :id => @sale_type.to_param, :sale_type => @sale_type.attributes
    assert_redirected_to sale_type_path(assigns(:sale_type))
  end

  test "should destroy sale_type" do
    assert_difference('SaleType.count', -1) do
      delete :destroy, :id => @sale_type.to_param
    end

    assert_redirected_to sale_types_path
  end
end
