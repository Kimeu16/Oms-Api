class TimesheetsController < ApplicationController
  before_action :authenticate_staff, only: [:index, :show, :create, :update, :destroy]
  # before_action :deny_access, only: [:destroy, :show]

  # GET /timesheets
  def index
    timesheets = @current_staff.timesheets # Retrieve timesheets associated with the current staff member
    render json: timesheets, status: :ok
  end

  # GET /timesheets/1
  def show
    if authenticate_staff
      timesheet = @current_staff.timesheets.find_by(id: params[:id])
      if timesheet
        render json: timesheet
      else
        render json: { error: "Timesheet not found" }, status: :not_found
      end
    else
      render_unauthorized
    end
  end


  # POST /timesheets
  def create
    timesheet = @current_staff.timesheets.build(timesheet_params)
    timesheet.staff_id = @current_staff.id
    if timesheet.save
      render json: timesheet, status: :created
    else
      render json: { error: timesheet.errors.full_messages }, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /timesheets/1
  def update
    timesheet = current_staff.timesheets.find_by(id: params[:id])
    if timesheet
      if timesheet.update(timesheet_params)
        render json: timesheet
      else
        render json: { error: timesheet.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Timesheet not found" }, status: :not_found
    end
  end

  # DELETE /timesheets/1
  def destroy
    timesheet = current_staff.timesheets.find_by(id: params[:id])
    if timesheet
      timesheet.destroy
      head :no_content
    else
      render json: { error: "Timesheet not found" }, status: :not_found
    end
  end

  private

  def timesheet_params
    params.permit(:date, :start_time, :end_time, :progress_details, :task_id, :staff_id)
  end

  # def deny_access
  #   render_unauthorized unless current_staff
  # end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
