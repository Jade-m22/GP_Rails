class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    first_name = params[:user][:first_name].presence || "Anonymous"
    @user = User.find_or_initialize_by(first_name: first_name)
  
    if @user.new_record?
      @user.assign_attributes(user_params)
      city_name = params[:user][:city_name]
      city = City.find_or_create_by(name: city_name)
      @user.city = city
  
      if @user.save
        redirect_to new_gossip_path(user_id: @user.id)
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to new_gossip_path(user_id: @user.id)
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :age, :description)
  end
end
