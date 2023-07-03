class ApplicationController < ActionController::API
  wrap_parameters format: []
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found


  private

  def render_invalid(invalid)
    puts "Unprocessable entity"
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end


  def render_not_found(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end

end
