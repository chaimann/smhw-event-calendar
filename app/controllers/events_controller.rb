class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def create
    event = Event.new(event_params)
    if event.save
      render json: event
    else
      invalid_request
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end)
  end
end
