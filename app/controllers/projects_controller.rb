class ProjectsController < ApplicationController
  # before_action :authorize
  # skip_before_action :authorize, only:[:index, :show]

  # GET /projects
  def index
    @project = Project.all
    render json: @project
  end

  # GET /projects/1
  def show
    @project = set_project
    render json: @project
  end

  # POST /projects
  def create
    @project = Project.create!(project_params)
    render json: @project, status: :created
  end

  # PATCH/PUT /projects/1
  def update
    @project = set_project
    @project.update(leave_type_params)
    render json: @project, status: :created
  end

  # DELETE /projects/1
  def destroy
    @project = set_project
    @project.destroy
    head :no_content
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.permit(:name, :client_name, :description, :action)
    end

    def authorize
      return render json: { error: "Not authorized "}, status: :unauthorized unless session.include? :client_id
    end
end
