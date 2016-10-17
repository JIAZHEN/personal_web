class PostsController < ApplicationController
  before_action :signed_in_admin, only: [:new, :create, :update, :edit, :destroy]
  before_action :a_post_by_url, only: [:show, :update, :edit, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
  	if @post.save
  		redirect_to @post
  	else
  		render "new"
  	end
  end

  def show
  end

  def index
    scope = if params[:tag].blank?
      Post
    else
      Post.tagged_with(params[:tag].downcase.strip)
    end

  	@posts = scope.order("created_at DESC").page(params[:page]).per(9)
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render "edit"
    end
  end

  def search
    @posts = Post.search_by_keyword(params["keyword"]).page(params[:page]).per(9)
    render "index"
  end

  def destroy
    Post.friendly.find(params[:id]).destroy
    redirect_to posts_path
  end

  def a_post_by_url
    @post = Post.friendly.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:content, :title, :subtitle, :url, :image, :tag_list)
  end
end
