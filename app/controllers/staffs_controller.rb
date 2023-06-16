class StaffsController < ApplicationController
  before_action :authorize
  skip_before_action :authorize ,only:[:show]

  def index
    @staff = Staff.all
    render json: @staff
  end

  # def show
  #   @staff = set_staff
  #   render json: @staff
  # end


# signup request for staff
  def create
    staff = Staff.create(staff_params)
    if staff
      session[:staff_id] = staff.id
      render json: staff
    else
      render json: { error: staff.errors.full_messages }, status: :unprocessable_entity
    end
  end

    # request me
  def show
    staff = Staff.find_by(id: session[:staff_id])
    if staff
      session[:staff_id] = staff.id
      render json: staff
    else
      render json: { error: "unauthorized" }, status: :unauthorized
    end
  end

  def destroy
    @staff = set_staff
    @staff.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    def staff_params
      params.permit(:name, :joining_date, :reporting_to, :email, :password, :password_confirmation, :tech_stack, :isadmin, :admin_id)
    end

    def authorize
      return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :admin_id
    end
end
