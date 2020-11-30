class PostsController < ApplicationController

  before_action :authenticate_user, {only: [:new, :edit,]}
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}


  


  #ログインしているユーザーが一致しないときの制限
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if  @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end

  #普通のアクションたち
  def index
  end

  def new
  end

  def create
    @post = Post.new(content: params[:content], user_id: @current_user.id)
    if @post.save
      flash[:notice] ="新規投稿が完了しました"
      redirect_to("/")
    else
      @error_message = "文字は一文字以上入れてください"
      render("posts/new")
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿編集が完了しました"
      redirect_to("/")
    else
      render("posts/#{@post.id}/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿の削除が完了しました"
    redirect_to("/")
  end

  def search
    @user = User.find_by(id: params[:id])
    @post = params[:search]
    if @post.present?
      @posts = Post.where("content LIKE ?", "%#{@post}%").order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end
  

end
