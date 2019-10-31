class LikesController < ApplicationController
  before_action :find_gossip
  before_action :find_like, only: [:destroy]

  def create
    # redirect_back(fallback_location: root_path)
    if already_liked?
      flash[:danger] = "Tu ne peux pas liker plusieurs fois un même Gossip."
    else
      @like = Like.create(user: current_user, gossip: @gossip)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if already_liked?
      @like.destroy
    else
      flash[:danger] = "Tu ne peux pas unlike."
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def find_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, gossip_id: params[:gossip_id]).exists?
  end

  def find_like
    @like = find_gossip.likes.find(params[:id])
  end
end
