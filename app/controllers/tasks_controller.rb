class TasksController < ApplicationController
  before_action :authenticate_staff, only: [:index, :show, :create, :upload_completed_files]
  before_action :deny_staff, only: [:show, :update, :destroy]
  before_action :deny_access, only: [:show, :create, :update, :destroy]

  # GET /tasks
  def index
    if current_admin
      tasks = Task.all
    else
      tasks = Task.where(assigned_to: @current_staff.staff_name)
    end

    render json: tasks, status: :ok
  end

  # GET /tasks/1
  def show
    task = Task.find_by(id: params[:id])
    if task
      if current_staff || task.staff_name == @current_staff.name
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
    task = Task.new(task_params)
    task.staff_id = @current_staff.id if @current_staff

    if task.save
      render json: task, status: :created
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    task = Task.find_by(id: params[:id])
    if task
      if current_admin || task.staff_id == @current_staff.id
        # Other update logic...

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

  def upload_completed_files
    task = Task.find_by(id: params[:id])

    if task
      if current_staff && task.assigned_to == current_staff.staff_name
        if params[:completed_files].present?
          puts "Task ID: #{task.id.inspect}"
          puts "Current Staff ID: #{current_staff.id.inspect}"
          puts "Completed Files Params: #{params[:completed_files].inspect}"

          # Convert the completed_files attribute to an array if it is nil or a string
          task.completed_files = [] if task.completed_files.nil? || task.completed_files.is_a?(String)

          # Append the new file URLs to the existing completed_files array
          new_completed_files = task.completed_files + Array(params[:completed_files])

          if task.update(completed_files: new_completed_files)
            render json: task, status: :ok
          else
            render json: { error: task.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: "No completed files attached" }, status: :unprocessable_entity
        end
      else
        puts "Current Staff: #{current_staff.inspect}"
        puts "Task Assigned To: #{task.assigned_to.inspect}" # Add this line to check the assigned_to attribute

        render_unauthorized
      end
    else
      render json: { error: "Task not found" }, status: :not_found
    end
  end

  # def upload_completed_files
  #   task = Task.find_by(id: params[:id])

  #   if task
  #     if current_staff && task.assigned_to == current_staff.staff_name
  #       if params[:completed_files].present?
  #         puts "Task ID: #{task.id.inspect}"
  #         puts "Current Staff ID: #{current_staff.id.inspect}"
  #         puts "Completed Files Params: #{params[:completed_files].inspect}"

  #         # Update the task's completed_files attribute with the new value
  #         task.update(completed_files: params[:completed_files])
  #         render json: task, status: :ok
  #       else
  #         render json: { error: "No completed files attached" }, status: :unprocessable_entity
  #       end
  #     else
  #       puts "Current Staff: #{current_staff.inspect}"
  #       puts "Task Assigned To: #{task.assigned_to.inspect}" # Add this line to check the assigned_to attribute

  #       render_unauthorized
  #     end
  #   else
  #     render json: { error: "Task not found" }, status: :not_found
  #   end
  # end

  def completed_tasks
    if current_admin
      tasks_with_completed_files = Task.where.not(completed_files: nil)

      # Prepare a new array to hold the tasks with completed file URLs
      tasks_with_urls = tasks_with_completed_files.map do |task|
        task_with_url = task.as_json

        if task.completed_files.is_a?(Array)
          task_with_url["completed_files"] = task.completed_files.map do |file|
            file.url
          end
        else
          task_with_url["completed_files"] = [task.completed_files.url]
        end

        task_with_url
      end

      render json: tasks_with_urls, status: :ok
    else
      render_unauthorized
    end
  end

  private

  def task_params
    params.permit(:avatar_image, :completed_files, :task_name, :assigned_to, :managed_by, :project_name, :project_id, :staff_id)
  end

  def deny_staff
    render_unauthorized unless current_admin
  end

  def deny_access
    render_unauthorized unless current_admin || (action_name == 'upload_completed_files' && current_staff && task_belongs_to_current_staff?)
  end

  # def deny_access
  #   render_unauthorized unless current_admin || (current_staff && task_belongs_to_current_staff?)
  # end

  def task_belongs_to_current_staff?
    task = Task.find_by(id: params[:id])
    task && task.staff_id == @current_staff.id
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
