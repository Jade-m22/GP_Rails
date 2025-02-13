class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:destroy]

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = "Commentaire ajouté avec succès !"
      redirect_to @gossip
    else
      flash[:error] = "Le commentaire ne peut pas être vide."
      redirect_to @gossip
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = "Commentaire modifié avec succès."
      redirect_to @comment.gossip
    else
      flash[:error] = "Erreur lors de la modification du commentaire."
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Commentaire supprimé avec succès."
    redirect_to @comment.gossip
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def authenticate_user
    unless current_user
      redirect_to login_path, alert: "Vous devez être connecté pour commenter."
    end
  end

  def authorize_user
    unless current_user == @comment.user || current_user == @comment.gossip.user
      redirect_to @comment.gossip, alert: "Vous n'êtes pas autorisé à supprimer ce commentaire."
    end
  end
end
