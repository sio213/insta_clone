class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  before_action :set_search_posts_form

  unless Rails.env.development?
    rescue_from StandardError, with: :render500
    rescue_from ActiveRecord::RecordNotFound, with: :render404
  end

  private

  def set_search_posts_form
    @search_form = SearchPostsForm.new(search_posts_params)
  end

  def search_posts_params
    params.fetch(:q, {}).permit(:body, :commnet)
  end

  def render404
    render template: 'errors/404', status: :not_found
  end

  def render500
    render template: 'errors/500', status: :internal_server_error
  end
end
