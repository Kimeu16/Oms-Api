class TimesheetsController < ApplicationController
  before_action :authorize
  skip_before_action :authorize, only:[:index, :show]

  # GET /timesheet
  def index
    @timesheet = Timesheet.all
    render json: @timesheet
  end

  # GET /timesheet/1
  def show
    @timesheet = set_timesheet
    render json: @timesheet
  end

  # POST /timesheet
  def create
    @timesheet = Timesheet.create!(timesheet_params)
    render json: @timesheet, status: :created
  end

  # PATCH/PUT /timesheet/1
  def update
    @timesheet = set_timesheet
    @timesheet.update(timesheet_params)
    render json: @timesheet, status: :created
  end

  # DELETE /timesheet/1
  def destroy
    @timesheet = set_timesheet
    @timesheet.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timesheet
      @timesheet = Timesheet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def timesheet_params
      params.permit(:date, :start_time, :end_time, :task_id, :progress_details, :action)
    end

    def authorize
      return render json: { error: "Not authorized "}, status: :unauthorized unless session.include? :staff_id
    end

end
