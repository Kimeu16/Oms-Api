require 'net/smtp'

class StaffsController < ApplicationController
  before_action :authorize
  skip_before_action :authorize

  def index
    @staff = Staff.all
    render json: @staff
  end

  # def show
  #   @staff = set_staff
  #   render json: @staff
  # end

#   def send_pass(email, password)
#     smtp_server = 'smtp.gmail.com'
#     smtp_domain = 'gmail.com'
#     smtp_port = 587
#     smtp_username = 'ram.bharathbrands@gmail.com'
#     smtp_password = 'eccfutcatpsykoho'

# message = <<MESSAGE_END
# From: Erick <#{smtp_username}>
# To: Erick <#{email}>
# Subject:  Password = #{password}

# This is a test email sent via SMTP.
# MESSAGE_END

#     smtp = Net::SMTP.new(smtp_server, smtp_port)
#     smtp.enable_starttls

#     Net::SMTP.start(smtp_server, smtp_port, smtp_domain, smtp_username, smtp_password, :login, enable_starttls_auto: true) do |sm|
#       sm.send_message(message, smtp_username, email)
#     end


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
      render json: {id: staff.id, staff_name: staff.staff_name, joining_date: staff.joining_date, reporting_to: staff.reporting_to, email: staff.email,tech_stack:staff.tech_stack}
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
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    def staff_params
      params.permit(:id, :staff_name, :joining_date, :reporting_to, :email, :tech_stack, :isStaff, :admin_id, :manager_id)
    end

    def authorize
      return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :admin_id
    end
end
