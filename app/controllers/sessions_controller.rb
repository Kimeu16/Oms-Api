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
        head :no_content
      end
    end
end
