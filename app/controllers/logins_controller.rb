class LoginsController < ApplicationController
    def new
        @user = User.find_by(id: session[:user_id])
        redirect_to posts_path if @user 
        @user = User.new
    end
  
    def create
        @user = User.find_by(login_params)

        if @user
            session[:user_id] = @user.id
            redirect_to posts_path
        else
            flash[:notice] = "Wrong email or password.Try again"
            render :new, status: :unprocessable_entity
        end
    end

    private

    def login_params
        params.require(:user).permit(:email,:password)
      end
end
