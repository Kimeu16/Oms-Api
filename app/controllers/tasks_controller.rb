class TasksController < ApplicationController
  before_action :authorize
  skip_before_action :authorize, only:[:show]

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
    @task = Task.create!(task_params)
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
      params.permit(:id, :task_name, :assigned_to, :managed_by, :project_id)
    end

    def authorize
      return render json: { error: "Not authorized "}, status: :unauthorized unless session.include? :staff_id
    end
end
