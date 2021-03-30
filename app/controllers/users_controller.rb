class UsersController < ApplicationController

    before_action :logged_in_user, only:[:index, :edit, :update, :destroy]
    
    def index
        @users = User.search(params[:search])
    end

    def show
        @user = User.find(params[:id])
        @microposts = @user.microposts.all
        @microposts_cards = @user.microposts.order(created_at: :desc).limit(3)
        @current_month_microposts = @user.microposts.current_month.count
        @last_month_microposts = @user.microposts.last_month.count
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
           flash[:notice] = "ユーザー登録が完了しました"
           redirect_to root_path
        else
           render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = 'プロフィールを更新しました'
            redirect_to @user
        else
            render 'edit'
        end
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = 'アカウントを削除しました。'
        redirect_to root_url
    end

    def posts
        @user = User.find(params[:id])
        @microposts = @user.microposts
    end
    
    def liked
        @user = User.find(params[:id])
        @microposts = @user.liked_microposts
    end
    
    def follower
        user = User.find(params[:user_id])
        @users = user.following_user
        render 'follower'
    end
    
    def followed
        user = User.find(params[:user_id])
        @users = user.follower_user
        render 'followed'
    end

    def user_params
        params.require(:user).permit(:name, :email, :avatar, :password, :password_confirmation, :profile)
    end


end
