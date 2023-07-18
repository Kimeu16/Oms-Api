class ManagersController < ApplicationController
  before_action :deny_access, only: [:destroy, :create, :update, :show]

    # GET /  Managers
    def index
      @managers = Manager.all
      render json: @managers
    end

    # GET /  Managers/1
    def show
      @managers = set_manager
      render json: @managers
    end

    # POST /  Managers
    def create
      @managers = Manager.create(manager_params)
      render json: @managers, status: :created
    end

    # PATCH/PUT /  Managers/1
    def update
      @managers = set_manager
      @managers.update(manager_params)
      render json: @managers, status: :created
    end

    # DELETE /  Managers/1
    def destroy
      @managers = set_manager
      @managers.destroy
      head :no_content
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_manager
        @managers = Manager.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def manager_params
        params.permit(:id, :first_name, :last_name, :title)
      end

      def deny_access
        render_unauthorized unless authenticate_admin
      end

      def render_unauthorized
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
end
