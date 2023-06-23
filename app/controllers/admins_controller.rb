class AdminsController < ApplicationController
  # before_action :authorize
  # skip_before_action :authorize, only:[:show]

    def index
      @admin = Admin.all
      render json: @admin
    end

  #signup request for Admin
      def create
        admin = Admin.create!(admin_params)
        if admin
          session[:admin_id] = admin.id
          render json: admin
        else
          render json: { error: admin.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # request me
      def show
          admin = Admin.find_by(id: session[:admin_id])
          if admin
            session[:admin_id] = admin.id
            render json: admin
          else
            render json: { error: "unauthorized" }, status: :unauthorized
          end
      end

      def destroy
        @admin = set_admin
        @admin.destroy
        head :no_content
      end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_admin
        @admin = Admin.find(params[:id])
      end

      def admin_params
        params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :isadmin)
      end

end
