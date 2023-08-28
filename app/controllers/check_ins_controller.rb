class CheckInsController < ApplicationController
  before_action :set_staff

  def check_in
    @check_in = @staff.check_ins.create(check_in_at: Time.now)
    render json: @check_in, status: :created
  end

  def check_out
    @check_in = @staff.check_ins.last
    @check_in.update(check_out_at: Time.now) if @check_in
    render json: @check_in, status: :ok
  end

  private

  def set_staff
    @staff = Staff.find(params[:staff_id])
  end
end
