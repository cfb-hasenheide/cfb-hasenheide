class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @upcoming_events = Event.upcoming.page(params[:page])
    @past_events = Event.past.page(params[:page])
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @players = User.players
    @yes_replies = Reply.by_event_and_status(@event, :yes)
    @no_replies = Reply.by_event_and_status(@event, :no)
    @waiting_replies = Reply.by_event_and_status(@event, :waiting)
    @maybee_replies = Reply.by_event_and_status(@event, :maybee)
    @watch_replies = Reply.by_event_and_status(@event, :watch)
    @no_reply_players = User.didnt_reply_to_event(@event.id)
    @reply = Reply.for_event_and_user(@event, current_user)
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event wurde erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_path, notice: 'Event wurde erfolgreich aktualisiert.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event wurde erfolgreich gelöscht.' }
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
      params.require(:event).permit(:kind,
                                    :name,
                                    :datetime,
                                    :description,
                                    :address,
                                    :minimum,
                                    :maximum)
    end
end
