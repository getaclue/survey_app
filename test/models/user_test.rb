require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  #Create a default dummy user
  def setup
    @user = User.new(name: "Test User", email: "test@email.com", age: "55", sex: "0",
                    password: "test", password_confirmation: "test")
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
  
  test "age should be present" do
    @user.age = " "
    assert @user.valid?
  end
  
  test "sex should be present" do
    @user.sex = " "
    assert @user.valid?
  end
  
  test "email should not be repeated" do
    duplicated_user = @user.dup
    duplicated_user.email = @user.email.upcase
    @user.save
    assert duplicated_user.valid?
  end
  
  test "passwords should not be different" do
    @user.password = "test"
    @user.password_confirmation = "test1"
    assert @user.valid?
  end
  
end
