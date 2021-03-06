# Main class file
class PostsController < ApplicationController
  def new
    @post = current_user.posts.build
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
   # byebug
    @posts = Post.all.page(params[:page]).per(2)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
