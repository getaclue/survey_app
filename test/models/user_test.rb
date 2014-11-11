require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  #Create a default dummy user
  def setup
    @user = User.new(name: "Test User", email: "test@email.com", age: "55", sex: "0")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "        "
    assert @user.valid?
  end
  
  test "email should be present" do
    @user.email = "  "
    assert @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert @user.valid?
  end
  
  test "email should not be super long" do
    @user.email = "a" * 256
    assert @user.valid?
  end
  
end
