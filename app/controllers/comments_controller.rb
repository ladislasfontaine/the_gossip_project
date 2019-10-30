class CommentsController < ApplicationController
  def index
  end

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new(user: User.first, gossip: @gossip, content: params[:content])
    if @comment.save
      flash[:success] = "You created a Comment!"
      redirect_to gossip_path(@gossip.id)
    else
      flash[:danger] = "A problem occured my friend."
      render gossip_path(@gossip.id)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
    if @comment.update(content: params[:content])
      flash[:success] = "You updated a Comment!"
      redirect_to gossip_path(@gossip.id)
    else
      flash[:danger] = "A problem occured my friend."
      render edit_gossip_comment_path(@gossip.id, @comment.id)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "You deleted a Comment!"
      redirect_to gossip_path(params[:gossip_id])
    else
      flash[:danger] = "A problem occured my friend."
      render edit_gossip_comment_path
    end
  end
end
