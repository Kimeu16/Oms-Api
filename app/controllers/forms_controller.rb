class FormsController < ApplicationController
  # before_action :authorize
  # skip_before_action :authorize, only:[:index, :show, :create]

# GET /LeaveForms
def index
  form = Form.all
  render json: form
end

# GET /leave_forms/1
def show
  @form = set_form
  render json: @form
end

# POST /leave_forms
def create
  @form = Form.create!(form_params)
  render json: @form, status: :created
end

# PATCH/PUT /leave_forms/1
def update
  @form = set_form
  @form.update(form_params)
  render json: @form, status: :created
end

# DELETE /leave_forms/1
def destroy
  @form = set_form
  @form.destroy
  head :no_content
end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_form
    @form = Form.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def form_params
    params.permit(:id, :date_from, :date_to, :reason_for_leave, :leave_type, :staff_id)
  end

  # def authorize
  #   return render json: { error: "Not authorized "}, status: :unauthorized unless session.include? :admin_id
  # end
end
