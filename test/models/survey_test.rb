require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  
  test "user_id should be present" do
    @survey.user_id = " "
    assert @survey.valid?
  end
  
end
