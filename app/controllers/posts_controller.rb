class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :limitation_corrent_user, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id,)
    if @post.save
      flash[:notice] = "投稿しました！"
      redirect_to posts_index_url
    else
      render :new
    end
    
  end
  
  def edit
  end
  
  def update
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました。"
      redirect_to posts_index_url
    else
      render :edit
    end
  end
  
  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_index_url
  end
  
  def limitation_corrent_user
    @post = Post.find(params[:id])
    unless @post.user_id == @current_user.id
      flash[:notice] = "自分以外のユーザーの投稿は編集できません。"
      redirect_to posts_index_url
    end
  end
end
