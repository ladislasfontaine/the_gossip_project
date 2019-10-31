module SessionsHelper
  def current_user
    User.find_by(id: session[:user_id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    session[:user_id] != nil ? true : false
  end

  def creator?(object)
    current_user == object.user ? true : false
    # on vérifie si l'utilisateur actuel est le créateur d'un objet (gossip ou commentaire)
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
