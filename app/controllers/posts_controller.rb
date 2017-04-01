class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = current_user.posts
  end

  def show
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])

  end

  def new
    @group = Group.find(params[:group_id])
    if current_user && current_user.is_member_of?(@group)
     @post  = Post.new
    else
      redirect_to group_path(@group), notice: "你还不是该群组成员！"
    end
  end

  def create
    @group = Group.find(params[:group_id])
    @post  = Post.new(post_params)
    @post.group = @group
    @post.user  = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
     if @post.update(post_params)
        redirect_to account_posts_path,notice: "Post Update Success!"
     else
        render :edit
     end

  end

  def destroy
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to account_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :content)
  end

end
