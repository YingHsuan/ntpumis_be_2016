class EventsController < ApplicationController
  EVENT_TYPE ={
    :domestic => "所上活動",
    :lecture => "專題演講"
  }
  def index
    @events = Event.all
  end
  def new
    @event = Event.new
    @event_type = JSON.parse(JSON[EVENT_TYPE])
  end
end
