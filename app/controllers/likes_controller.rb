class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    @gossip = Gossip.find(params[:gossip_id])
    like = @gossip.likes.build(user: current_user)

    if like.save
      flash[:success] = "Tu as liké ce gossip !"
    else
      flash[:alert] = "Tu as déjà liké ce gossip."
    end

    redirect_back fallback_location: root_path
  end

  def destroy
    @gossip = Gossip.find(params[:gossip_id])
    like = @gossip.likes.find_by(user: current_user)

    if like
      like.destroy
      flash[:success] = "Tu as enlevé ton like."
    else
      flash[:alert] = "Tu n'avais pas liké ce gossip."
    end

    redirect_back fallback_location: root_path
  end

  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Tu dois être connecté pour liker un gossip."
      redirect_to login_path
    end
  end
end
