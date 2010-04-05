require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { :login => "john", :password => "john1000",
                               :password_confirmation => "john1000",
                               :first_name => "John", :last_name => "Doe",
                               :email => "johndoe@example.com" }
    end

    assert_redirected_to account_path
  end
  
  test "should show current user" do
    UserSession.create(users(:ben))
    get :show
    assert_response :success
  end

  test "should get edit" do
    UserSession.create(users(:ben))
    get :edit, :id => users(:ben).id
    assert_response :success
  end

  test "should update user" do
    UserSession.create(users(:ben))
    put :update, :id => users(:ben).id, :user => { }
    assert_redirected_to account_path
  end
end
