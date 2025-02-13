class UsersController < ApplicationController
  def new
    @user = User.new
    # @emails = User.pluck(:email).uniq
    # @cities = City.pluck(:name).uniq
  end
  
  def show
    @user = User.find_by(id: params[:id])
    
    unless @user
      redirect_to root_path, alert: "Utilisateur introuvable."
    end
  end

  def create
    city = City.find_or_create_by(name: params[:user].delete(:city_name))
    
    @user = User.new(user_params)
    @user.city = city 
  
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Bienvenue #{@user.first_name} !"
      redirect_to root_path
    else
      flash.now[:danger] = "Erreur dans l'inscription. Vérifie tes informations."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :age, :description, :city_name, :password, :password_confirmation)
  end
end