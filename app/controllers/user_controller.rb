class UserController < ApplicationController
  def show
    # @gossip = Gossip.find(params[:id])
    @user = User.find(params[:author_id])
  end
end
