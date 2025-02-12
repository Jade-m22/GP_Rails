class GossipsController < ApplicationController
  def new
    @gossip = Gossip.new
  end

  def create
    user = User.find_by(id: params[:gossip][:user_id]) || User.find_by(first_name: "Anonymous")

    unless user
      user = User.create(first_name: "Anonymous", last_name: "User", email: "anonymous@example.com")
    end

    @gossip = Gossip.new(gossip_params)
    @gossip.user = user

    if @gossip.save
      flash[:success] = "Gossip créé avec succès !"
      redirect_to root_path
    else
      flash.now[:error] = "Erreur : Merci de remplir tous les champs correctement."
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @gossip = Gossip.find_by(id: params[:id])
    if @gossip.nil?
      redirect_to root_path, alert: "Gossip introuvable."
    end
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end
end
