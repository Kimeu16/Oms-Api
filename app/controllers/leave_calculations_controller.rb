class LeaveCalculationsController < ApplicationController
  # GET /leave_calculations
  def index
    @leave_calculations = LeaveCalculation.all
    render json: @leave_calculations
  end

  # GET /leave_calculations/1
  def show
    @leave_calculation = set_leave_calculation
    render json: @leave_calculation
  end

  # POST /leave_calculations
  def create
    @leave_calculation = LeaveCalculation.create(leave_calculation_params)
    update_leave_days(@leave_calculation) # Calculate and update leave days
    if @leave_calculation.save
      render json: @leave_calculation, status: :created
    else
      render json: @leave_calculation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /leave_calculations/1
  def update
    @leave_calculation = set_leave_calculation
    @leave_calculation.update(leave_calculation_params)
    update_leave_days(@leave_calculation) # Recalculate and update leave days
    if @leave_calculation.save
      render json: @leave_calculation, status: :ok
    else
      render json: @leave_calculation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /leave_calculations/1
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

  # Update the leave days (used_days, available_days) based on total_days
  def update_leave_days(leave_calculation)
    leave_calculation.used_days = leave_calculation.used_days.to_i
    leave_calculation.available_days = [leave_calculation.total_days.to_i - leave_calculation.used_days.to_i, 0].max
  end
end
