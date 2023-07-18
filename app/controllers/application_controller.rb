class ApplicationController < ActionController::API
  include JsonWebToken

  # before_action :authenticate_admin
  # before_action :authenticate_staff

  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found


  private

  def render_invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_not_found(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end

  def authenticate_staff
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)

    if decoded == "Token not found"
      render json: { error: 'Not Authenticated' }, status: :unauthorized
    else
      staff_id = decoded[:staff_id] if decoded.key?(:staff_id)
      @current_staff = Staff.find_by(id: staff_id)
    end
  end

  def current_staff
    @current_staff ||= authenticate_staff
  end

  def authenticate_admin
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)

    if decoded == "Token not found"
      render json: { error: 'Not Authenticated' }, status: :unauthorized
    else
      @current_admin = Admin.find(decoded[:admin_id]) if decoded.key?(:admin_id)
    end
  end



  # def authorize_staff
  #   render_unauthorized unless current_staff
  # end

  # def authorize_admin
  #   render_unauthorized unless current_admin
  # end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
