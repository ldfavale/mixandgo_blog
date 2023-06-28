class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    redirect_to new_login_path, notice: "You need to be logged in to create Posts." unless user_is_logged_in
    @post = Post.new
  end

  def edit
    verify_authority(@post,"edit")
  end

  def create
    user = User.find_by(id: session[:user_id])
    @post = Post.new(post_params)
    @post.user = user
    if @post.save
      redirect_to post_url(@post), notice: "Post was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    return unless user_is_author(@post)
    if @post.update(post_params)
      redirect_to post_url(@post), notice: "Post was successfully updated." 
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    return unless user_is_author(@post)
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed." 
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def user_is_logged_in
      !!session[:user_id]
    end

    def user_is_author(post)
      post.user.id == session[:user_id]
    end

    def verify_authority(post,action)
      redirect_to posts_path, notice: "You need to be the author to #{action} Posts." unless user_is_author(post)
    end

    def post_params
      params.require(:post).permit(:body, :title)
    end
end
