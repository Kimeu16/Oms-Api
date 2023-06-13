class LeaveFormsController < ApplicationController
  before_action :set_leave_form, only: %i[ show update destroy ]

  # GET /leave_forms
  def index
    @leave_forms = LeaveForm.all

    render json: @leave_forms
  end

  # GET /leave_forms/1
  def show
    render json: @leave_form
  end

  # POST /leave_forms
  def create
    @leave_form = LeaveForm.new(leave_form_params)

    if @leave_form.save
      render json: @leave_form, status: :created, location: @leave_form
    else
      render json: @leave_form.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /leave_forms/1
  def update
    if @leave_form.update(leave_form_params)
      render json: @leave_form
    else
      render json: @leave_form.errors, status: :unprocessable_entity
    end
  end

  # DELETE /leave_forms/1
  def destroy
    @leave_form.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave_form
      @leave_form = LeaveForm.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leave_form_params
      params.require(:leave_form).permit(:staff_id, :date_from, :date_to, :reason_for_leave, :leave_type)
    end
end
