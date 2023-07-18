class FormsController < ApplicationController
  before_action :authenticate_staff, only: [:create]
  before_action :deny_access, except: [:index, :show, :destroy, :update]

  # GET /leave_forms
  def index
    form = Form.all
    render json: form, status: :ok
  end

    # GET /forms/1
    def show
      form = Form.find_by(id: params[:id])
      if form
        render json: form
      else
        render json: { error: "form not found" }, status: :not_found
      end
    end

    # POST /forms
    def create
      form = Form.create(form_params)
      if form.save
        render json: form, status: :created
      else
        render json: { error: form.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /tasks/1
    def update
      form = Form.find_by(id: params[:id])
      if form
        if form.update(form_params)
          render json: form
        else
          render json: { error: task.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: "Task not found" }, status: :not_found
      end
    end

    # DELETE /tasks/1
    def destroy
      form = Form.find_by(id: params[:id])
      if form
        form.destroy
        head :no_content
      else
        render json: { error: "form not found" }, status: :not_found
      end
    end

  private

  # Only allow a list of trusted parameters through.
  def form_params
    params.permit(:your_name, :date_from, :date_to, :reason_for_leave, :leaving_type, :status, :staff_id)
  end

  def deny_access
    render_unauthorized unless authenticate_staff
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
