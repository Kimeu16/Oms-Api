class ClientsController < ApplicationController
  before_action :authorize
  skip_before_action :authorize, only:[:index, :show]

  # GET /clients
  def index
    @clients = Client.all
    render json: @clients
  end

  # GET /clients/1
  def show
    @client = set_client
    render json: @client
  end

  # POST /clients
  def create
    @client = Client.create!(client_params)
    render json: @client, status: :created
  end

  # PATCH/PUT /clients/1
  def update
    @client = set_client
    @client.update(client_params)
    render json: @client, status: :created
  end

  # DELETE /clients/1
  def destroy
    @client = set_client
    @client.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.permit(:name, :description)
    end

    def authorize
      return render json: { error: "Not authorized "}, status: :unauthorized unless session.include? :client_id
    end
end
