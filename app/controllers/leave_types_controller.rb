class LeaveTypesController < ApplicationController
  before_action :set_leave_type, only: %i[ show update destroy ]

  # GET /leave_types
  def index
    @leave_types = LeaveType.all

    render json: @leave_types
  end

   # GET /leave_types/1
  def show
    @leave_type = set_leave_type
    render json: @leave_type
  end

  # POST /leave_types
  def create
    @leave_type = LeaveType.new(leave_type_params)

    if @leave_type.save
      render json: @leave_type, status: :created, location: @leave_type
    else
      render json: @leave_type.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /leave_types/1
  def update
    if @leave_type.update(leave_type_params)
      render json: @leave_type
    else
      render json: @leave_type.errors, status: :unprocessable_entity
    end
  end

  # DELETE /leave_types/1
  def destroy
    @leave_type.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave_type
      @leave_type = LeaveType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leave_type_params
      params.require(:leave_type).permit(:name, :days_allowed)
    end
end
