class UserController < ApplicationController
  before_action :forbid_login_user, {only: [:new, :login_form, :create]}
  before_action :ensure_correct_user, {only: [:edit, :update]}


  #ログインしているユーザーが一致しないときの制限
  def ensure_correct_user
    if params[:id].to_i != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end


  def new
  end

  def create
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])
    @checkbox = params[:checkbox]
    if @checkbox.present? && @user.save &&
      session[:user_id] = @user.id
      flash[:notice] = "新規会員登録が完了しました"
      redirect_to("/")
    else
      @error_message = "すべての項目に入力してください"
      render("user/new")
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if @user.save
      flash[:notice] = "マイページ編集が完了しました"
      redirect_to("/")
    else
      @error_message = "すべての項目に入力してください"
      render("user/edit")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password]) &&
      session[:user_id] = @user.id
      flash[:notice] ="ログインが完了しました"
      redirect_to("/")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("user/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトが完了しました"
    redirect_to("/")
  end

end
