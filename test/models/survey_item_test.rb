require 'test_helper'

class SurveyItemTest < ActiveSupport::TestCase
 
 test "survey_id should be present" do
    @survey_item.survey_id = " "
    assert @survey_item.valid?
  end
  
 test "content should be present" do
    @survey_item.content = " "
    assert @survey_item.valid?
  end
  
end