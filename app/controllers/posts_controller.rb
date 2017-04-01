class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def show
    @group = Group.find(params[:group_id])
    @posts.group = Post.find(params[:id])

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
    @post = @group.post
  end

  def destroy
    @group = Group.find(params[:id])
    @post = @group.find(params[:id])
    @post.destroy
    redirect_to group_path(@group)
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :content)
  end

end
