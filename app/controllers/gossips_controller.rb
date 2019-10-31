class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :show]
  before_action :has_access, only: [:edit, :update, :destroy]

  def index
    # récupère tous les potins et les envoie à la view index
    @gossips = Gossip.all
    @users = User.all
    @comments = Comment.all
  end

  def show
    # Mrécupère le potin concerné et l'envoie à la view show (show.html.erb)
    @gossip = Gossip.find(params[:id])
    @gossip_update_date = @gossip.updated_at.strftime("%A, %d %b %Y %l:%M %p")
    @users = User.all
  end

  def new
    # formulaire pour récupérer les infos dans create
  end

  def create
    @gossip = Gossip.new(title: params[:title], content: params[:content])
    @gossip.user = current_user
    if @gossip.save
      flash[:success] = "You created a Gossip!"
      redirect_to root_path
    else
      flash[:danger] = "A problem occured my friend."
      render new_gossip_path
    end
  end

  def edit
    # récupère le potin et l'envoie à la view edit pour affichage dans un formulaire d'édition
    @gossip = Gossip.find(params[:id])
  end

  def update
    # met à jour le potin à partir du contenu du formulaire de edit.html.erb
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
    # récupère le potin concerné et le détruit en base
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
