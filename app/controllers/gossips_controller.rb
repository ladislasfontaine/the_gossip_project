class GossipsController < ApplicationController
  def index
    # Méthode qui récupère tous les potins et les envoie à la view index (index.html.erb) pour affichage
    @gossips = Gossip.all
    @users = User.all
  end

  def show
    # Méthode qui récupère le potin concerné et l'envoie à la view show (show.html.erb) pour affichage
    @gossip = Gossip.find(params[:id])
    @gossip_update_date = @gossip.updated_at.strftime("%A, %d %b %Y %l:%M %p")
    @users = User.all
  end

  def new
    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  end

  def create
    @gossip = Gossip.new(title: params[:title], content: params[:content], user: User.first) #, user: User.first

    if @gossip.save
      flash[:success] = "You created a Gossip!"
      redirect_to root_path
    else
      flash[:danger] = "A problem occured my friend."
      render new_gossip_path
    end
  end

  def edit
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
    @gossip = Gossip.find(params[:id])
  end

  def update
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
    @gossip = Gossip.find(params[:id])
    if @gossip.update(title: params[:title], content: params[:content])
      flash[:success] = "You updated a Gossip!"
      redirect_to gossip_path
    else
      flash[:danger] = "A problem occured my friend."
      render edit_gossip_path
    end
  end

  def destroy
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
    @gossip = Gossip.find(params[:id])
    if @gossip.destroy
      flash[:success] = "You deleted a Gossip!"
      redirect_to gossips_path
    else
      flash[:danger] = "A problem occured my friend."
      render gossip_path
    end
  end
end
