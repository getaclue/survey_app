class UsersController < ApplicationController
  
  # Responds to GET request
  # Purpose - Page to make a new user
  # Named path - new_user_path
  def new
    @user = User.new
  end
  
  # Responds to GET request
  # Purpose - Page to show user
  # Named path - user_path(user)
  def show
    @user = User.find(params[:id])
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
      redirect_to user_path(@user)
    else
      # Unsuccessfull Sign Up
      
      # Redirect to signup page
      render 'new'
    end
  end
  
  # Helper methods
  private
  
    # Ensure that only the permitted parameters are passed and no others
    def accepted_user_params
      params.require(:user).permit(:name, :email, :age, :sex, :password, 
                                    :password_confirmation)
    end
  
end
