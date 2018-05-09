class PublicController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :allow_iframe_requests

  layout 'application'

  private

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end
end
