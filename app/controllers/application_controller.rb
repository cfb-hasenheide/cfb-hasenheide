require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:username, :email, :password, :password_confirmation]
    )

    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [
        :username, :email, :password, :password_confirmation, :current_password
      ]
    )

    devise_parameter_sanitizer.permit(
      :accept_invitation,
      keys: [
        :first_name,
        :invitation_token,
        :last_name,
        :password,
        :password_confirmation,
        :phone,
        :username
      ]
    )
  end

  def authorize_admin!
    return true if current_user.admin?
    alert = 'Du hast keine Berechtigung für den Admin Bereich!'
    redirect_to(:root, alert: alert) && return
  end
end
