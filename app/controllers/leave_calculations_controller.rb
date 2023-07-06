class LeaveCalculationsController < ApplicationController

  # GET /  LeaveCalculations
  def index
    @leave_calculation = LeaveCalculation.all
    render json: @leave_calculation
  end

  # GET /leave_types/1
  def show
    @leave_calculation = set_leave_calculation
    render json: @leave_calculation
  end

  # POST /leave_types
  def create
    @leave_calculation = LeaveCalculation.create(leave_calculation_params)
    render json: @leave_calculation, status: :created
  end

  # PATCH/PUT /leave_types/1
  def update
    @leave_calculation = set_leave_calculation
    @leave_calculation.update(leave_calculation_params)
    render json: @leave_calculation, status: :created
  end

  # DELETE /leave_types/1
  def destroy
    @leave_calculation = set_leave_calculation
    @leave_calculation.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave_calculation
      @leave_calculation = LeaveCalculation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leave_calculation_params
      params.permit(:staff_details, :type_of_leave, :total_days, :used_days, :available_days, :leave_type_id)
    end

end
