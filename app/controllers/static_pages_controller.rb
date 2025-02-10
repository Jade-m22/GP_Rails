class StaticPagesController < ApplicationController
  def team
  end

  def contact
  end 

  def welcome
    @first_name = params[:first_name]
    @gossips = Gossip.includes(:user)
  end

end
