# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        redirect_to user
      else
        message
      end
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def message
    message = t "message.message_active"
    flash[:warning] = message
    redirect_to root_url
  end
end
