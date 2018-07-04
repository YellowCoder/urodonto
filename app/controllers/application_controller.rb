class ApplicationController < ActionController::Base
  layout :current_layout

  before_action :authenticate_user!, :set_paper_trail_whodunnit

  def index
  end

  private

  def current_layout
    user_signed_in? ? 'application' : 'public'
  end
end