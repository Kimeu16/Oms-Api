class CheckInOutsController < ApplicationController
  before_action :authenticate_staff, only: [:check_in, :check_out, :index, :show, :destroy]

  def index
    check_in_outs = CheckInOut.all
    render json: check_in_outs, each_serializer: CheckInOutSerializer
  end

  def show
    check_in_out = CheckInOut.find(params[:id])
    render json: check_in_out
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'CheckInOut not found' }, status: :not_found
  end

  def check_in
    if @current_staff
      current_time = Time.now
      local_time = current_time.in_time_zone('Nairobi')

      check_in_out = CheckInOut.create(
        check_in: local_time,
        staff_id: @current_staff.id,
        name: @current_staff.staff_name
      )

      render json: {
        check_in_out: check_in_out,
        name: @current_staff.staff_name
      }, status: :created
    else
      render_unauthorized
    end
  end

  def check_out
    if @current_staff
      check_in_out = CheckInOut.where(check_out: nil).last
      if check_in_out
        check_in_out.update(check_out: Time.now)
        render json: check_in_out, status: :created
      else
        render json: { error: 'No active check-in found' }, status: :not_found
      end
    else
      render_unauthorized
    end
  end

  def destroy
    check_in_out = CheckInOut.find(params[:id])
    check_in_out.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'CheckInOut not found' }, status: :not_found
  end

  private

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end

