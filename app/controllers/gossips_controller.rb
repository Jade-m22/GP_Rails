class GossipsController < ApplicationController
  def show
    @gossip = Gossip.find(params[:id])
    @random_color = "rgb(#{rand(100..255)}, #{rand(100..255)}, #{rand(100..255)})"
  end
end
