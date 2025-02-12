class WelcomeController < ApplicationController
  def show
    @first_name = params[:first_name]
    @gossips = Gossip.includes(:user)
  end
end