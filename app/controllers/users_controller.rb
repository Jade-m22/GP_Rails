class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @gossip_id = params[:gossip_id]
  end

  def create
    Rails.logger.debug "Session avant suppression : #{session.to_h}"
  
    @city = City.find_or_create_by(name: params[:user][:city_name])
    @user = User.new(user_params.except(:city_name))
    @user.city = @city
  
    if @user.save
      flash[:success] = "Utilisateur créé avec succès !"
  
      if session[:pending_gossip] && session[:pending_gossip]["gossip_id"]
        gossip_id = session[:pending_gossip]["gossip_id"]
        session.delete(:pending_gossip)
        Rails.logger.debug "Session après suppression de pending_gossip : #{session.to_h}"
  
        gossip = Gossip.find_by(id: gossip_id)
        Rails.logger.debug "Gossip trouvé : #{gossip.inspect}"
  
        if gossip
          gossip.update(user: @user) #pour associer potin et user
          redirect_to edit_gossip_path(gossip), notice: "Utilisateur ajouté, continuez votre modification."
          return
        else
          redirect_to root_path, alert: "Erreur : Gossip introuvable après la création de l'utilisateur."
          return
        end
      end
  
      redirect_to root_path
    else
      flash.now[:error] = "Erreur lors de la création de l'utilisateur."
      render :new, status: :unprocessable_entity
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :age, :description, :city_name)
  end
end
