class ApplicationController < ActionController::Base
    before_action :set_current_user


    #ログインしているのか
    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end

    #ログインしている場合の制限
    def authenticate_user
        if @current_user == nil
            flash[:notice] = "権限がありません"
            redirect_to("/login")
        end
    end

    #ログインしていない場合の制限
    def forbid_login_user
        if @current_user
            flash[:notice] = "権限がありません"
            redirect_to("/")
        end
    end

end