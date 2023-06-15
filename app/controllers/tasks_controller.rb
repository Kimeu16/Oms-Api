class TasksController < ApplicationController
  before_action :authorize
  skip_before_action :authorize, only:[:index, :show]

  # GET /tasks
  def index
    @task = Task.all
    render json: @task
  end

  # GET /tasks/1
  def show
    @task = set_task
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.create!(staff_params)
    render json: @task, status: :created
  end

  # PATCH/PUT /tasks/1
  def update
    @task = set_task
    @task.update(task_params)
    render json: @task, status: :created
  end

  # DELETE /tasks/1
  def destroy
    @task = set_task
    @task.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.permit(:project_id, :name, :assigned_to, :managed_by)
    end

    def authorize
      return render json: { error: "Not authorized "}, status: :unauthorized unless session.include? :client_id
    end
end
