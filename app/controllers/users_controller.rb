class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      city: City.last
    )
    if @user.save
      flash[:success] = "Ton compte a bien été créé."
      redirect_to root_path
    else
      flash[:danger] = "Problème, essaye à nouveau."   
      render new_user_path
    end
  end
end
