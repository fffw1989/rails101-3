class WelcomeController < ApplicationController
  def index
    flash[:notice] = "Freedom!"
  end

  
end
