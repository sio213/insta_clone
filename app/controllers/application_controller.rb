class ApplicationController < ActionController::Base
  unless Rails.env.development?
    rescue_from StandardError, with: :render500
    rescue_from ActiveRecord::RecordNotFound, with: :render404
  end

  private

  def render404
    render template: 'errors/404', status: :not_found
  end

  def render500
    render template: 'errors/500', status: :internal_server_error
  end
end
