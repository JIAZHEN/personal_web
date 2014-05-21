class StaticPagesController < ApplicationController
  def home
    @posts = Post.order("created_at DESC").take(3)
  end

  def about
  end

  def contact
  end

  def sitemap
    render :layout => false
  end
end
