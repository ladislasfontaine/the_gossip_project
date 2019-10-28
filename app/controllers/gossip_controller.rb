class GossipController < ApplicationController
  def index
    @gossips = Gossip.all
    @users = User.all
    # @gossip = Gossip.find(self)
    # @user = User.find(gossip.user_id)
  end

  def show
    @gossip = Gossip.find(params[:id])
    @gossip_creation_date = @gossip.created_at.strftime("%A, %d %b %Y %l:%M %p")
  end
end
