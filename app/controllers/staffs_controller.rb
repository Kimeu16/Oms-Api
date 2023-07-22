require 'net/smtp'

class StaffsController < ApplicationController
  before_action :authenticate_staff, only: [:show, :create, :update, :destroy]
  before_action :deny_access, only: [:destroy, :create, :update, :show]

  def index
    @staff = Staff.all
    render json: @staff, status: :ok
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
      send_pass(email_hash) # Call the send_pass method here

      # Generate a token and send it in the response instead of using sessions
      # token = encode_token({ staff_id: staff.id })
      render json: staff, status: :created
    else
      render json: { error: staff.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # request me
  def show
    render json: current_staff
  end

  def destroy
    @staff = set_staff
    @staff.destroy
    head :no_content
  end

  private

  def set_staff
    staff = Staff.find(params[:id])
  end

  def staff_params
    params.permit(:staff_name, :joining_date, :reporting_to, :email, :tech_stack)
  end

  def deny_access
    render_unauthorized unless authenticate_admin
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  # Method to send an email with staff's password
  def send_pass(email_hash)
    message = <<~MESSAGE
      From: <#{email_hash[:sender_email]}>
      To: <#{email_hash[:recipient_email]}>
      Subject: #{email_hash[:subject]}

      #{email_hash[:body]}
    MESSAGE

    Net::SMTP.start('smtp.gmail.com', 587, 'localhost', email_hash[:sender_email], email_hash[:sender_password], :login) do |smtp|
      smtp.send_message(message, email_hash[:sender_email], email_hash[:recipient_email])
    end
  end
end
