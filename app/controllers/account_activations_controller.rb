# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && !user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "account_activation.account_activated"
      redirect_to user
    else
      invalid
    end
  end

  def invalid
    flash[:danger] = t "account_activation.invalid_activation"
    redirect_to root_url
  end
end
