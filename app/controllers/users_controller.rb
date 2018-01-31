
# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user, except: %i(index create new)
  before_action :logged_in_user, except: %i(new create show)
  before_action :admin_user, only: :destroy

  def show
    if @user
      render :show
    else
      flash[:danger] = t "users.form.sorry"
      render "static_pages/home"
    end
  end

  def index
    @users = User.where(activated: FILL_IN).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "message.message_create"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "users.index.flash_update_profile"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.index.flash_delete"
      redirect_to users_url
    else
      flash[:danger] = t "users.index.flash_error_delete"
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "users.index.please_login"
    redirect_to login_url
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def load_user
    @user = User.find_by(id: params[:id])
    unless @user
      flash.now[:danger] = t "users.index.not_found_user"
      render "static_pages/home"
    end
  end
end
