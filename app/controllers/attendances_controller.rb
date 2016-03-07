class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin_coordinator!
  before_action :authenticate_reg_desk!, only: [:create,:new]
  # GET /attendances
  # GET /attendances.json
  def index
     if coordinator_signed_in? 
      @user = current_coordinator
      @attendances = Attendance.where(event_id: @user.event_id).order(:id)
    else
      @attendances = Attendance.order(:id).page(params[:page]).per(10)
    end  
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  # POST /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to @attendance, notice: 'Attendance was successfully created.' }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def perattendance
    rval= params[:round]
    current_attendance = Attendance.find_by id: params[:aid]
    if params[:mark_present]=="present"
      if rval.chomp.to_i <= current_attendance.round 
        ParticipantAttendance.where(id: params[:p_ids]).update_all(round: params[:round],status: 'Present')
      end
    else
      if rval.chomp.to_i <= current_attendance.round
        ParticipantAttendance.where(id: params[:p_ids]).update_all(round: params[:round],status: 'Absent')
      end
    end
    redirect_to attendance_path(params[:aid])
  end  

  def pattendance
    params[:a_ids]
    if params[:mark_present]=="present"
      Attendance.where(id: params[:a_ids]).update_all(status: 'Present', round: params[:round])
      team = Attendance.where(id: params[:a_ids]) 
        
        team.each do |team|
          if Result.where(team_id: team.team_id,event_id: team.event_id).exists?
              Result.where(team_id: team.team_id,event_id: team.event_id).update_all(round: params[:round])
          else
              Result.create(team_id: team.team_id,event_id: team.event_id, round: params[:round])
          end 
        end    
    
    else
      Attendance.where(id: params[:a_ids]).update_all(status: 'Absent', round: params[:round])
    end    
    redirect_to attendances_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(:team_id, :event_id, :round, :status, a_ids:[], p_ids:[])
    end
end
