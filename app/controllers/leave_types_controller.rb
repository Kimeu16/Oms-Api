class LeaveTypesController < ApplicationController
  before_action :authorize
  skip_before_action :authorize, only:[:index, :show, :create, :destroy]

  # GET /LeaveTypes
  def index
    @leave_type = LeaveType.all
    render json: @leave_type
  end

  # GET /leave_types/1
  def show
    @leave_type = set_leave_type
    render json: @leave_type
  end

  # POST /leave_types
  def create
    @leave_type = LeaveType.create(leave_type_params)
    render json: @leave_type, status: :created
  end

  # PATCH/PUT /leave_types/1
  def update
    @leave_type = set_leave_type
    @leave_type.update(leave_type_params)
    render json: @leave_type, status: :created
  end

  # DELETE /leave_types/1
  def destroy
    @leave_type = set_leave_type
    @leave_type.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave_type
      @leave_type = LeaveType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leave_type_params
      params.permit(:id, :your_name, :days_allowed, :staff_id)
    end

    def authorize
      return render json: { error: "Not authorized "}, status: :unauthorized unless session.include? :admin_id
    end
end
