require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
 #  test "Invalid signup information" do
 #  		get signup_path
 #  		assert_no_difference 'User.count' do
 #  			post users_path, params: {user: {name: "", email: "user@invalid", password: "foo", password_confirmation: "bar"}}
 #  		end
 #  		assert_template 'pages/welcome'
	# end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User",
                                        email: "user@Example.com", 
                                        password:              "password",
                                        password_confirmation: "password"} }

    end
    follow_redirect!
    #assert_template 'sessions/new'
    #assert_not flash.empty?
  end

end
  