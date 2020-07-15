class PostsController < ApplicationController
  before_action :is_logged_in?

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user = helpers.current_user

    if @post.valid?
      @post.save

      flash[:success] = I18n.t('posts.create.success')
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
