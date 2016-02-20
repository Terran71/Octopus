class EventsController < DashboardController
  before_action :set_nested_project, only: [ :approval_response]
  before_action :set_event, only: [:approval_response]
  before_action :set_current_user_participation, only: [:approval_response]
  before_action :store_location, only: []

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  def edit
  end

  # def response
  #   @project_date = ProjectDate.find(@event.project_date_id)
  #   @project = Project.find(@project_date.project_id)
  #   @event.editor_participant_id = @project.participants.where(user_id: current_user.id).first.id
  #   @event.save
  #  if params[:approval] == "false"
  #   @event.status = "reschedule"
  #   @event.save
  #   BlockedTime.create!(time_start: @event.time_start, time_end: @event.time_end, project_date_id: @event.project_date_id)
  #   # ProjectMailer.event_status(@event).deliver_later
  #   # EventResponseJob.perform_later(@event, @event.editor_participant_id, @event.status)
  #   redirect_to @project_date, notice: 'Rescheduling Requested.'
  #  elsif params[:approval] == "true"
  #   @event.status = "approved"
  #   @event.save
  #   # EventResponseJob.perform_later(@event, @event.editor_participant_id, @event.status)
  #   redirect_to @project_date, notice: 'Appointment was approved.'
  #  end
  #      redirect_to @project_date, notice: 'ERP.'

  # end

  def approval_response
    if params[:approval] == "false"
      @event.update_attributes(status: "reschedule", editor_participant_id: @current_user_participation.id)
      # BlockedTime.create!(time_start: @event.time_start, time_end: @event.time_end, project_date_id: @event.project_date_id)
      # EventResponseJob.perform_later(@event, @event.status)
      redirect_to project_project_date_path(project_id: @event.project_id, id: @event.project_date_id),  notice: 'Appointment was approved.'
    elsif params[:approval] == "true"
      @event.update_attributes(status: "approved", editor_participant_id: @current_user_participation.id)
      # EventResponseJob.perform_later(@event, @event.status)
      redirect_to project_project_date_path(project_id: @event.project_id, id: @event.project_date_id),  notice: 'Appointment was approved.'
    else
    end
  end

  # def response
  #   # @project_date = ProjectDate.find(@event.project_date_id)
  #   # @project = Project.find(@project_date.project_id)
  #   # @event.editor_participant_id = @current_user_participation.id
  #   # @event.save
  #  if params[:approval] == "false"
  #   @event.status = "reschedule"
  #   @event.save
  #   # BlockedTime.create!(time_start: @event.time_start, time_end: @event.time_end, project_date_id: @event.project_date_id)
  #   # ProjectMailer.event_status(@event).deliver_later
  #   # EventResponseJob.perform_later(@event, @event.editor_participant_id, @event.status)
  #   redirect_to project_project_date_path(project_id: @event.project_id, id: @event.project_date_id),  notice: 'Rescheduling Requested.'
  #  elsif params[:approval] == "true"
  #   @event.update_attributes(status: "approved")
  #   # @event.status = "approved"
  #   # @event.save
  #   # EventResponseJob.perform_later(@event, @event.editor_participant_id, @event.status)
  #   redirect_to root_path
  #   # redirect_to project_project_date_path(project_id: @event.project_id, id: @event.project_date_id),  notice: 'Appointment was approved.'
  #   else
  #     redirect_to project_project_date_path(project_id: @event.project_id, id: @event.project_date_id),  notice: 'erb'

  #  end

  # end

  # def update
  #   # respond_to do |format|
  #   #   if @event.update(event_params)
  #   #     format.html { redirect_to @event, notice: 'Event was successfully updated.' }
  #   #     format.json { render :show, status: :ok, location: @event }
  #   #   else
  #   #     format.html { render :edit }
  #   #     format.json { render json: @event.errors, status: :unprocessable_entity }
  #   #   end
  #   # end
  # end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
       params.require(:event).permit(:id, :project_date_id, :project_id, :participant_id, :description, :status, :editor_participant_id,
                                      :date_start, :date_end, :all_day, :repeat, :time_start, :time_end, :category, :attendees_count, :address_id,
                                    attendees_attributes: [:id, :status, :participant_id]  )
    end
end
