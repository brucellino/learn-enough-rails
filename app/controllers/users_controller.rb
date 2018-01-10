class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    # debugger
  end

  def create
    # don't allow arbitrary parameters, use only the permitted ones in 
    # user params below
    @user = User.new(user_params)
    if @user.save
      # handle the creation
    flash[:success] = "Welcome to the Awesome Thing!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private 
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

