class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin_reg_desk!

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.order(:id).page(params[:page]).per(10)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
        
    @p_name=Array.new
    @e_name=Array.new
    status = 0
    
    @team.participants.each do |p|
      if ParticipantAttendance.where(participant_id: p.id).exists?
        @team.events.each do|e|
          if ParticipantAttendance.where(participant_id: p.id,event_id: e.id).exists?   
            @p_name<<p.name
            @e_name<<e.name
            status = -1
          end
        end
      end
    end
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @p_name=Array.new
    @e_name=Array.new
    status = 0
    
    @team.participants.each do |p|
      if ParticipantAttendance.where(participant_id: p.id).exists?
        @team.events.each do|e|
          if ParticipantAttendance.where(participant_id: p.id,event_id: e.id).exists?   
            @p_name<<p.name
            @e_name<<e.name
            status = -1
          end
        end
      end
    end

  respond_to do |format|
      if status == 0 &&  @team.save
        @team.events.each do |e|
          @team.participants.each do |p|
            @participant_attendance=ParticipantAttendance.create(team_id: @team.id,participant_id: p.id,event_id: e.id,status: "Absent")  
          end
        end
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        flash[:alert] = "Some of the participants are already in selected teams"     
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update


    respond_to do |format|
      if status == 0 || @team.update(team_params)
        @team.events.each do |e|
          if !ParticipantAttendance.where(team_id: @team.id,event_id: e.id).exists?
            @team.participants.each do |p|
              ParticipantAttendance.create(team_id: @team.id,participant_id: p.id,event_id: e.id,status: "Absent")
            end
          else
            @team.participants.each do |p|
              if !ParticipantAttendance.where(team_id: @team.id,participant_id: p.id).exists?
                @team.events.each do |e|
                ParticipantAttendance.create(team_id: @team.id,participant_id: p.id,event_id: e.id,status: "Absent")
                end
              end 
            end
          end 
        end          
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        flash[:alert] = "Some of the participants are already in selected teams" 
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(participant_ids:[],event_ids:[])
    end
end
