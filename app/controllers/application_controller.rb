class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search_posts_form

  unless Rails.env.development?
    rescue_from StandardError, with: :render500
    rescue_from ActiveRecord::RecordNotFound, with: :render404
  end

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    login_path
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
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
