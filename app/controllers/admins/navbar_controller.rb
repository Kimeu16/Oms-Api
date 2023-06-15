class Admins::NavbarController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role

  def index
  end

  private

  def check_admin_role
    redirect_to root_path unless current_user.admin?
  end
end
