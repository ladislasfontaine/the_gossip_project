class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
    if @user && @user.authenticate(params[:password])
      log_in(@user)
      remember(@user)
      flash[:success] = "Tu es connecté(e)."
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    # a faire fonctionner que si on est déjà connecté
    logout(current_user)
    flash[:success] = "À la prochaine."
    redirect_to root_path
  end

end
