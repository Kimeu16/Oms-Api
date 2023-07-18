require 'net/smtp'

class StaffsController < ApplicationController
  before_action :authenticate_staff, only: [:show, :create, :update, :destroy]
  before_action :deny_access, only: [:destroy, :create, :update, :show]

  def index
    @staff = Staff.all
    render json: @staff, status: :ok
  end




def send_pass(email_hash)
  smtp_server = 'smtp.gmail.com'
  smtp_port = 587
  domain = 'gmail.com'
  enable_ssl = true

  message = <<~MESSAGE
    From: #{email_hash[:sender_email]}
    To: #{email_hash[:recipient_email]}
    Subject: #{email_hash[:subject]}

    #{email_hash[:body]}
    MESSAGE

  Net::SMTP.start(smtp_server, smtp_port, domain, email_hash[:sender_email], email_hash[:sender_password], :login) do |smtp|
    smtp.enable_starttls if enable_ssl
    smtp.send_message(message, email_hash[:sender_email], email_hash[:recipient_email])
  end
end

# signup request for staff
  def create
    pass = SecureRandom.alphanumeric(10).upcase
    staff_pars = staff_params
    staff_pars[:password] = pass

    staff = Staff.create!(staff_pars)

    email_hash = {
      sender_email: 'ram.bharathbrands@gmail.com',
      sender_password: 'eccfutcatpsykoho',
      recipient_email: staff_params[:email],
      subject: "Staff details",
      body: "Password: #{pass}"
    }


    if staff
      send_pass(email_hash)

      session[:staff_id] = staff.id
      render json: staff
    else
      render json: { error: staff.errors.full_messages }, status: :unprocessable_entity
    end
  end

    # request me
  def show
    staff = Staff.find_by(id: session[:staff_id])
    if staff
      session[:staff_id] = staff.id
      render json: staff
    else
      render json: { error: "unauthorized" }, status: :unauthorized
    end
  end

  def destroy
    @staff = set_staff
    @staff.destroy
    head :no_content
  end

  private
  def set_staff
    staff = Staff.find[:id]
  end

  def staff_params
    params.permit(:staff_name, :joining_date, :reporting_to, :email, :tech_stack, :password, :password_confirmation, :isStaff, :admin_id, :manager_id)
  end

  def deny_access
    render_unauthorized unless authenticate_admin
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

end
