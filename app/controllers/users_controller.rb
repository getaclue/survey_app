class UsersController < ApplicationController
  ############################################
  # Followed some parts of the book from 
  # www.railstutorial.org/book
  ############################################
  
  # ensure that user is signed in before edit and update actions
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  # ensure that user sending the request is the signed in user
  before_action :permitted_user, only: [:edit, :update]
  # ensures that user has admin
  before_action :admin_user, only: [:destroy]
  
  # Show all users
  def index
    @users = User.all
  end
  
  # Responds to GET request
  # Purpose - Page to make a new user
  # Named path - new_user_path
  def new
    if signed_in?
      # doesn't make sense to make a new account if already signed in
      # redirect to show action
      redirect_to current_user
    else
      # user not signed in
      # proceed as normal
      @user = User.new
    end
  end
  
  # Responds to GET request
  # Purpose - Page to show user
  # Named path - user_path(user)
  # user.surveys = returns a collection of surveys
  def show
    @user = User.find(params[:id])
    @surveys = @user.surveys
    remove_current_survey
  end
  
  # Responds to POST request
  # Purpose - Create a new user
  # Named path - users_path
  def create
    @user = User.new(accepted_user_params)
    if @user.save
      # Successfull Sign Up
    
      # Store successfull signup as a current user
      # Redirect to showing user profile
      sign_in(@user)
      flash[:success] = "Welcome #{@user.name} to Survey App!"
      redirect_to root_url
    else
      # Unsuccessfull Sign Up
      
      # Redirect to signup page
      render 'new'
    end
  end
  
  # Editing a user action
  def edit
    # Removed User.find because before_action takes care of it
    # @user = User.find(params[:id])
  end
  
  # updating a user action
  def update
    # Removed User.find because before_action takes care of it
    # @user = User.find(params[:id])
    if @user.update_attributes(accepted_user_params)
      # update was successful
      # flash message and redirect to show action
      flash[:success] = "Settings updated"
      redirect_to @user
    else
      # update was unsuccessful
      # show the edit action again
      render 'edit'
    end
  end
  
  # Delete a user
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end
  
  # Helper methods
  private
  
    # Ensure that only the permitted parameters are passed and no others
    def accepted_user_params
      params.require(:user).permit(:name, :email, :age, :sex, :password, 
                                    :password_confirmation)
    end
    
    # Helper method for before_action Rails method for edit and update actions
    def permitted_user
      @user = User.find(params[:id])
      # using session helper to check if current user == user
      redirect_to root_url unless current_user?(@user)
    end
    
    # Helper method for before_action Rails method for admin action(s)
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
  
end