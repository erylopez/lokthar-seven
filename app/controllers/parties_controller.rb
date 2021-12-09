class PartiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_party, only: [:show, :edit, :update, :destroy, :publish]

  def index
    @events = Event.all
  end

  def show
    @attendees = @party.event.event_attendees.map do |attendee|
      {
        id: attendee.id,
        name: attendee.name,
        nickname: attendee.nickname,
        roles: [attendee.role_1, attendee.role_2, attendee.role_3]
      }
    end
  end

  def new
    event  = Event.find(params[:event_id])
    @party = event.build_event_party
  end

  def create
    event  = Event.find(party_params[:event_id])
    @party = event.build_event_party(title: party_params[:title])
    @party.party_format = party_params.except(:title, :event_id)

    if @party.save
      redirect_to parties_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @party.update(members: party_params.except(:title, :event_id))
      redirect_to party_path(@party)
    else
      render :show
    end
  end

  def destroy
    event = @party.event
    @party.destroy
    redirect_to new_party_path(event_id: event)
  end

  protected

  def set_party
    @party = EventParty.find(params[:id] || params[:party_id])
  end

  def party_params
    params.require(:event_party).permit(:title, :event_id,
      :p0_m1, :p0_m2, :p0_m3, :p0_m4, :p0_m5,
      :p1_m1, :p1_m2, :p1_m3, :p1_m4, :p1_m5,
      :p2_m1, :p2_m2, :p2_m3, :p2_m4, :p2_m5,
      :p3_m1, :p3_m2, :p3_m3, :p3_m4, :p3_m5,
      :p4_m1, :p4_m2, :p4_m3, :p4_m4, :p4_m5,
      :p5_m1, :p5_m2, :p5_m3, :p5_m4, :p5_m5,
      :p6_m1, :p6_m2, :p6_m3, :p6_m4, :p6_m5,
      :p7_m1, :p7_m2, :p7_m3, :p7_m4, :p7_m5,
      :p8_m1, :p8_m2, :p8_m3, :p8_m4, :p8_m5,
      :p9_m1, :p9_m2, :p9_m3, :p9_m4, :p9_m5
    )
  end
end
