class Mypage::BaseController < ApplicationController
  before_action :authenticate_user!
  layout 'mypage'
end
