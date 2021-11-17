class WeathersController < ApplicationController
  def index

  end

  def edit
    @cold_weather = Weather.find_by_name 'Cold'
    @warm_weather = Weather.find_by_name 'Warm'
    @hot_weather = Weather.find_by_name 'Hot'
  end

  def update_all

  end
end
