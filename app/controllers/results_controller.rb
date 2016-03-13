class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin_coordinator!
  # GET /results
  # GET /results.json
  def index
    if coordinator_signed_in? 
      @user = current_coordinator
      @results = Result.where(event_id: @user.event_id).order(round: :desc).page(params[:page]).per(5)
    else
      @results = Result.all
    end
  end

  # GET /results/1
  # GET /results/1.json
  def show
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: 'Result was successfully created.' }
        format.json { render :show, status: :created, location: @result }
      else
        format.html { render :new }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def markresult
    if Result.where(id: params[:r_id]).exists?
      result_item = Result.find_by id: params[:r_id]
      result_item.update(result_info: params[:result_info])
      redirect_to results_path
    #Result.where(id: params[:r_id]).update(result_info: params[:result_info])
    else
      redirect_to results_path
    end
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:team_id, :event_id, :round, :result_info , params[:r_id], params[:result_info])
    end
end
