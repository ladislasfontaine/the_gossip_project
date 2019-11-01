module SessionsHelper
  def current_user
    if session[:user_id]
      current_user = User.find_by(id: session[:user_id])      
    elsif cookies[:user_id]
      user = User.find_by(id: cookies[:user_id])
      if user
        remember_token = cookies[:remember_token]
        remember_digest = user.remember_digest
        user_authenticated = BCrypt::Password.new(remember_digest).is_password?(remember_token)
        if user_authenticated
          log_in(user)
          current_user = user
        end
      end
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    session[:user_id] != nil ? true : false
  end

  def forget(user)
    user.update(remember_digest: nil)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def logout(user)
    session.delete(:user_id)
    forget(user)
  end

  def creator?(object)
    current_user == object.user ? true : false
    # on vérifie si l'utilisateur actuel est le créateur d'un objet (gossip ou commentaire)
  end

  def remember(user)
    remember_token = SecureRandom.urlsafe_base64
    user.remember(remember_token)
    cookies.permanent[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  private

  def authenticate_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

  def has_access
    # on vérifie si c'est bien le créateur du gossip en question sinon on le redirige
    unless creator?(Gossip.find(params[:id]))
      flash[:danger] = "Vous n'avez pas accès à cette page."
      redirect_to root_path
    end
  end
end
