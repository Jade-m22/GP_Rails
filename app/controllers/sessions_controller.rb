class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Connexion réussie #{user&.first_name} !"
    else
      flash.now[:alert] = "Email ou mot de passe invalide."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    redirect_to root_path, notice: "Déconnexion réussie, à bientôt #{user&.first_name} !"
  end  
end
