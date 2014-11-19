class PagesController < ApplicationController
  def index
    @survey = current_user.surveys.build if signed_in?
  end
end
