require 'test_helper'

class LicenseesControllerTest < ActionController::TestCase
  setup do
    @licensee = licensees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:licensees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create licensee" do
    assert_difference('Licensee.count') do
      post :create, licensee: {  }
    end

    assert_redirected_to licensee_path(assigns(:licensee))
  end

  test "should show licensee" do
    get :show, id: @licensee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @licensee
    assert_response :success
  end

  test "should update licensee" do
    patch :update, id: @licensee, licensee: {  }
    assert_redirected_to licensee_path(assigns(:licensee))
  end

  test "should destroy licensee" do
    assert_difference('Licensee.count', -1) do
      delete :destroy, id: @licensee
    end

    assert_redirected_to licensees_path
  end
end
