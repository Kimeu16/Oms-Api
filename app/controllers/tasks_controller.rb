class TasksController < ApplicationController
  before_action :authenticate_staff, only: [:index, :show]
  before_action :deny_staff, only: [:show, :update, :destroy]
  before_action :deny_access, only: [:show, :create, :update, :destroy]

  # GET /tasks
  def index
    if current_admin
      tasks = Task.all
    else
      tasks = @current_staff.tasks
    end

    render json: tasks, status: :ok
  end

  # GET /tasks/1
  def show
    task = Task.find_by(id: params[:id])
    if task
      if current_admin || task.staff_id == @current_staff.id
        render json: task
      else
        render_unauthorized
      end
    else
      render json: { error: "Task not found" }, status: :not_found
    end
  end

  # POST /tasks
  def create
    task = Task.create(task_params)
    task.staff_id = @current_staff.id if @current_staff

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
      if current_admin || task.staff_id == @current_staff.id
        if task.update(task_params)
          render json: task
        else
          render json: { error: task.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render_unauthorized
      end
    else
      render json: { error: "Task not found" }, status: :not_found
    end
  end

  # DELETE /tasks/1
  def destroy
    task = Task.find_by(id: params[:id])
    if task
      if current_admin || task.staff_id == @current_staff.id
        task.destroy
        head :no_content
      else
        render_unauthorized
      end
    else
      render json: { error: "Task not found" }, status: :not_found
    end
  end

  private

  def task_params
    params.permit(:task_name, :assigned_to, :managed_by, :project_id, :staff_id)
  end

  def deny_staff
    render_unauthorized unless current_admin
  end

  def deny_access
    render_unauthorized unless current_admin || (current_staff && task_belongs_to_current_staff?)
  end

  def task_belongs_to_current_staff?
    task = Task.find_by(id: params[:id])
    task && task.staff_id == @current_staff.id
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
