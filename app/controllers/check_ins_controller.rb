class CheckInsController < ApplicationController
  before_action :authenticate_staff
  before_action :set_check_in, only: [:check_out]

  def check_in
    @check_in = staff.check_ins.create(check_in_at: Time.now)
    render json: @check_in, status: :created
  end

  def check_out
    if @check_in.update(check_out_at: Time.now)
      render json: @check_in, status: :ok
    else
      render json: { error: 'Failed to update check-out time.' }, status: :unprocessable_entity
    end
  end

  private

  def set_check_in
    @check_in = staff.check_ins.last
    return render json: { error: 'No check-in found for the staff.' }, status: :not_found unless @check_in
  end
end
