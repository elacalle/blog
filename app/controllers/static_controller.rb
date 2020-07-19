class StaticController < ApplicationController
  def index
    @posts = Post.default.page params[:page]
  end
end
