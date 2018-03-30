class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def invalid_request
    render status: 422, json: {}
  end
end
