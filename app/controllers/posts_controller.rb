class PostsController < ApplicationController

  before_action :logged_in_user, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create 
    @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to posts_path
      else 
        render 'new'
      end
  end

  def index
    @posts = Post.all
  end


  def logged_in_user
    unless logged_in? 
      redirect_to login_url
    end
  end

end

private
  def post_params
    params.require(:post).permit(:title, :content)
  end