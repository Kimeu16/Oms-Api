class TimesheetsController < ApplicationController
  before_action :set_timesheet, only: %i[ show update destroy ]

  # GET /timesheets
  def index
    @timesheets = Timesheet.all

    render json: @timesheets
  end

 # GET /timesheets/1
def show
  @timesheet = set_timesheet
  render json: @timesheet
end

  # POST /timesheets
  def create
    @timesheet = Timesheet.new(timesheet_params)

    if @timesheet.save
      render json: @timesheet, status: :created, location: @timesheet
    else
      render json: @timesheet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /timesheets/1
  def update
    if @timesheet.update(timesheet_params)
      render json: @timesheet
    else
      render json: @timesheet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /timesheets/1
  def destroy
    @timesheet.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timesheet
      @timesheet = Timesheet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def timesheet_params
      params.require(:timesheet).permit(:date, :start_time, :end_time, :task_id, :progress_details, :action)
    end
end
