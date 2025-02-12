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
    redirect_to root_path, alert: "Gossip introuvable." if @gossip.nil?
  end

  def edit
    @gossip = Gossip.find_by(id: params[:id])
  end 

  def update
    @gossip = Gossip.find(params[:id])
    
    user = User.find_by(first_name: params[:gossip][:new_user_first_name])
    
    if user
      @gossip.user = user
      if @gossip.update(gossip_params)
        redirect_to @gossip, notice: "Le potin a été modifié avec succès !"
      else
        flash.now[:alert] = "Erreur : Le titre doit contenir entre 3 et 14 caractères."
        render :edit, status: :unprocessable_entity
      end
    else
      # Stocker les données du potin en attente dans la session
      session[:pending_gossip] = { gossip_id: @gossip.id, title: params[:gossip][:title], content: params[:gossip][:content] }
      session[:pending_gossip] = { gossip_id: @gossip.id }
      Rails.logger.debug "Session après ajout : #{session[:pending_gossip]}"

      
      redirect_to new_user_path(gossip_id: @gossip.id), alert: "L'utilisateur n'existe pas. Veuillez le créer d'abord."
    end
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content, :user_id)
  end
end
