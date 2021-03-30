class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = "ログインしました。"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:info] = 'ログアウトしました。'
    redirect_to root_url
  end
end
