class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy, :publish, :republish]

  def index
    @events = Event.where(listed: true).order(created_at: :desc)
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to events_path
    else
      render :edit
    end
  end

  def destroy
    @event.update(listed: false)
    redirect_to events_path
  end

  def publish
    @event.update(published_at: Time.now)
    DiscordMessenger::EventBasic.new(event: @event, setup: params[:setup_id]).deliver

    redirect_to @event
  end

  def republish
    DiscordMessenger::EventBasic.new(event: @event).republish
    redirect_to @event
  end

  protected

  def set_event
    @event = Event.find(params[:id] || params[:event_id])
  end

  def event_params
    params.require(:event).permit(:activity, :name, :starts_at,
      :location, :tanks_needed, :healers_needed, :melee_dps_needed,
      :ranged_dps_needed, :mages_needed, :event_details, :event_image_url
    )
  end

end
