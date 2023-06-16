class SessionsController < ApplicationController
  #login

  # POST '/login'
  def create
      staff = Staff.find_by(email: params[:email])
      admin = Admin.find_by(email: params[:email])
      if staff&.authenticate(params[:password])
        session[:staff_id] = staff.id
        render json: staff, status: :ok

      elsif admin&.authenticate(params[:password])
        session[:admin_id] = admin.id
        render json: admin, status: :ok

      else
        render json: { errors: 'Invalid Password or Username'}, status: :unauthorized
      end
  end


    # DELETE '/logout'
    def destroy
      if session[:staff_id]
        session.delete :staff_id
        head :no_content
      elsif session[:admin_id]
        session.delete :admin_id
        head :no_content
      else
        render json: {errors: ["You must be logged in to access this content"] }, status: :unauthorized
      end
    end

      # session.delete :student_id || school_owner_id || educator_id

    # def destroy
    #   session.delete :staff_id
    # end

    # def destroy
    #   session.delete :admin_id
    # end
end
