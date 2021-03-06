class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_path
    end
    # render :layout => false
  end

  def create
    user = User.find_by(phone: params[:session][:phone])||User.find_by(phone_short: params[:session][:phone])
    p user
    if user && user.authenticate(params[:session][:password])
      p "ok!!"
      flash[:success] = user.name+",登入成功"
      log_in user
      redirect_back_or_index
    else
      flash[:error] = "用户名或者密码错误，请重试！"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
