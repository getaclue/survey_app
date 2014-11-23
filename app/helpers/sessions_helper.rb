module SessionsHelper
  
  ##########################################
  # Start Dealing with users
  ##########################################
  # using built in session helper from Rails
  def sign_in(user)
    session[:user_id] = user.id
  end
  
  # creating an instance variable to store the current user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  # checks if the user is signed in (or not)
  def signed_in?
    !current_user.nil?
  end
  
  # delete current_user
  # using built-in rails method session.delete
  # remove pointer to current_user
  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  # checks if passed user object is the current user object
  def current_user?(user)
    user == current_user
  end
  
  ##########################################
  # End Dealing with users
  ##########################################
  
  # Redirect to a default location OR
  # Redirect to URL trying to be accessed
  def conditional_redirect(default)
    redirect_to(session[:URL_trying_to_be_accessed] || default)
    session.delete(:URL_trying_to_be_accessed)
  end
  
  # Store URL trying to be accessed
  def store_URL_trying_to_be_accessed
      session[:URL_trying_to_be_accessed] = request.url if request.get?
  end
  
  ##########################################
  # Start Dealing with surveys
  ##########################################
  
  # add a session id to the survey
  def add_current_survey(survey)
    session[:survey_id] = survey.id
  end
  
  # create instance variable to store current_survey
  # limitation = work on one survey at a time
  def current_survey
    @current_survey ||= Survey.find_by(id: session[:survey_id])
  end
  
  # delete survey
  def remove_current_survey
    session.delete(:survey_id)
    @current_survey = nil
  end
  
  # is there a survey assigned to a current_survey?
  def current_survey?
    !current_survey.nil?
  end
  
  ##########################################
  # End Dealing with surveys
  ##########################################
  
end
