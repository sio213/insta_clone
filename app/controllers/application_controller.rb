class ApplicationController < ActionController::Base
  unless Rails.env.development?
    rescue_from StandardError, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  private

  def render_404
    render template: 'errors/404', status: 404
  end

  def render_500
    render template: 'errors/500', status: 500
  end
end
