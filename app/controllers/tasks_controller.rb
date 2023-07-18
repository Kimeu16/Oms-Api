class TasksController < ApplicationController
  before_action :authenticate_staff, only: [:show]
  before_action :deny_access, only: [:destroy, :create, :show, :update]


 # GET /tasks
 def index
  tasks = Task.all
  render json: tasks, status: :ok
end

  # GET /tasks/1
  def show
    task = Task.find_by(id: params[:id])
    if task
      render json: task
    else
      render json: { error: "Task not found" }, status: :not_found
    end
  end

  # POST /tasks
  def create
    task = Task.create(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    task = Task.find_by(id: params[:id])
    if task
      if task.update(task_params)
        render json: task
      else
        render json: { error: task.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Task not found" }, status: :not_found
    end
  end

  # DELETE /tasks/1
  def destroy
    task = Task.find_by(id: params[:id])
    if task
      task.destroy
      head :no_content
    else
      render json: { error: "Task not found" }, status: :not_found
    end
  end

  private

  def task_params
    params.permit(:task_name, :assigned_to, :managed_by, :project_id, :staff_id)
  end

  def deny_access
    render_unauthorized unless authenticate_admin
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

end
