class Staffs::NavbarController < ApplicationController
  before_action :authenticate_user!
  before_action :check_staff_role

  def index
  end

  private

  def check_staff_role
    redirect_to root_path unless current_user.staff?
  end
end
