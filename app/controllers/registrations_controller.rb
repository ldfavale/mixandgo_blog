class RegistrationsController < ApplicationController
  def new
    user = User.find_by(id: session[:user_id])
    redirect_to posts_path if user 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_login_path, notice: "User succesfully saved"
    else
      flash[:alert] = "User cannot be saved"
      render :new, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:email,:password, :name, :lastname)
  end
  
end
