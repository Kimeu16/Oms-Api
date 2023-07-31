class SessionsController < ApplicationController
  # skip_before_action :authenticate_admin, only: [:create]

  def create
    staff = Staff.find_by_email(params[:email])
    admin = Admin.find_by_email(params[:email])

    if staff&.authenticate(params[:password])
      token = jwt_encode(staff_id: staff.id)
      render json: { token: token, isStaff: true, staff_name: staff.staff_name }, status: :ok
    elsif admin&.authenticate(params[:password])
      token = jwt_encode(admin_id: admin.id)
      render json: { token: token, isadmin: true }, status: :ok
    else
      render json: { errors: 'Invalid Password or Username' }, status: :unauthorized
    end
  end

  def destroy
    # Token-based authentication doesn't require session deletion
    head :no_content
  end
end
