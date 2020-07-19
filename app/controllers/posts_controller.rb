class PostsController < ApplicationController
  before_action :is_logged_in?

  def new
    @post = Post.new
  end

  def create
    post = Post.create(post_params)
    post.user = helpers.current_user

    if post.valid?
      post.save
      flash[:notification] = { type: :success, messages: [I18n.t('posts.create.success')] }

      redirect_to root_path
    else
      errors = post.errors.full_messages.flatten
      flash[:notification] = { type: :warning, messages: errors }

      redirect_to :new_post
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
