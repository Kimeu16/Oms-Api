class LeaveFormsController < ApplicationController
  # before_action :authorize
  # skip_before_action :authorize, only:[:index, :show]

  # GET /LeaveForms
  def index
    @leave_form = LeaveForm.all
    render json: @leave_form
  end

  # GET /leave_forms/1
  def show
    @leave_form = set_leave_form
    render json: @leave_form
  end

  # POST /leave_forms
  def create
    @leave_form = LeaveForm.create!(leave_form_params)
    render json: @leave_form, status: :created
  end

  # PATCH/PUT /leave_forms/1
  def update
    @leave_form = set_leave_form
    @leave_form.update(leave_form_params)
    render json: @leave_form, status: :created
  end

  # DELETE /leave_forms/1
  def destroy
    @leave_form = set_leave_form
    @leave_form.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave_form
      @leave_form = LeaveForm.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leave_form_params
      params.permit(:staff_id, :date_from, :date_to, :reason_for_leave, :leave_type)
    end

    def authorize
      return render json: { error: "Not authorized "}, status: :unauthorized unless session.include? :client_id
    end
end
