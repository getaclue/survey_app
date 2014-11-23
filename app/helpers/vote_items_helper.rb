module VoteItemsHelper
  
    def add_question(question)
      savequestion = question.vote_items.build
      savequestion.toggle(:active)
      savequestion.save
    end
  
    def make_question_collection
      @questions = SurveyItem.find_by(survey_id: current_survey)
    end

    def add_questions(questions)
      
      questions.each do |question|
        @temp_entry = question.vote_items.build
        @temp_entry.toggle(:active)
        @temp_entry.save
        
      end
    end
    
end
