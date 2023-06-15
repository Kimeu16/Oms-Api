class StaffsController < ApplicationController
  # before_action :authorize
  # skip_before_action :authorize, only:[:index, :show]

  # GET /staffs
  def index
    @staff = Staff.all
    render json: @staff
  end

  # GET /staffs/1
  def show
    @staff = set_staff
    render json: @staff
  end

  # POST /staffs
  def create
    @staff = Staff.create!(staff_params)
    render json: @staff, status: :created
  end

  # PATCH/PUT /staffs/1
  def update
    @staff = set_staff
    @staff.update(staff_params)
    render json: @staff, status: :created
  end

  # DELETE /staffs/1
  def destroy
    @staff = set_staff
    @staff.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def staff_params
      params.permit(:name, :joining_date, :reporting_to, :tech_stack)
    end

    def authorize
      return render json: { error: "Not authorized "}, status: :unauthorized unless session.include? :staff_id
    end


end
