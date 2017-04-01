class Account::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = current_user.posts
  end

end
