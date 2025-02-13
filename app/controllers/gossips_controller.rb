class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  helper_method :current_user

  def new
    @gossip = Gossip.new
  end

  def create
    if current_user
      @gossip = current_user.gossips.build(gossip_params)
      if @gossip.save
        flash[:success] = "Gossip créé avec succès !"
        redirect_to root_path
      else
        flash.now[:error] = "Erreur : Merci de remplir tous les champs correctement."
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to login_path, alert: "Vous devez être connecté pour créer un potin."
    end
  end

  def show
    @gossip = Gossip.find_by(id: params[:id])
    redirect_to root_path, alert: "Gossip introuvable." if @gossip.nil?
    @comments = @gossip.comments.includes(:user)
  end

  def edit
    @gossip = Gossip.find_by(id: params[:id])
  end 

  def update
    @gossip = Gossip.find(params[:id])
  
    if @gossip.update(gossip_params)
      redirect_to @gossip, notice: "Le potin a été modifié avec succès !"
    else
      flash.now[:alert] = "Erreur : Le titre doit contenir entre 3 et 14 caractères."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to root_path, notice: "Le potin a été supprimé avec succès."
  end

  private

  def authenticate_user
    unless session[:user_id]
      flash[:alert] = "Connectez-vous ou inscrivez-vous pour créer un potin."
      redirect_to login_path
    end
  end

  def authorize_user
    @gossip = Gossip.find(params[:id])
    unless session[:user_id] == @gossip.user_id
      redirect_to root_path, alert: "Vous n'avez pas l'autorisation de modifier ce potin."
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end
end
