class SessionsController < ApplicationController
  include SessionsHelper

  # skip_before_action :verify_authenticity_token, only: [:create]
  # def new
  # end

    def create
      user = User.find_by(email: params[:email])
      
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        remember(user) if params[:remember_me] == "1"
        redirect_to root_path, notice: "Connexion réussie #{user&.first_name} !"
      else
        flash.now[:alert] = "Email ou mot de passe invalide."
        render :new, status: :unprocessable_entity
      end
    end

  def destroy
    user = User.find_by(id: session[:user_id])
    puts "Forget method called for #{user.email}" # Debug
    puts "Cookies before: #{cookies[:remember_token]}"  
    forget(user) if user # <-- Supprime les cookies de connexion
    puts "Cookies after: #{cookies[:remember_token]}"  
    # session[:user_id] = nil
    reset_session
    redirect_to root_path, notice: "Déconnexion réussie, à bientôt #{user&.first_name} !"
  end
  
end