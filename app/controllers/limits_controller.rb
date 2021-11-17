class LimitsController < ApplicationController
  def index
    limits

    redirect_to edit_url if @cold_warm_limit.degrees.nil? || @warm_hot_limit.degrees.nil?
  end

  def edit
    limits
  end

  def update
    if limits_params[:warm_hot].to_i <= limits_params[:cold_warm].to_i
      redirect_to edit_url, alert: 'The limit between cold and warm must be smaller that the one between warm and hot'
      return
    end
    limits

    @warm_hot_limit.update degrees: limits_params[:warm_hot]
    @cold_warm_limit.update degrees: limits_params[:cold_warm]

    render :index
  end

  def find_weather
    response = FindTodaysWeather.find params[:postcode]
    redirect_to limits_url, notice: weather_message(response)
  rescue BadWeatherRequest => e
    redirect_to limits_url, alert: e.message
  end

  private

  def limits
    @warm_hot_limit = Limit.find_by_between 'warm-hot'
    @cold_warm_limit = Limit.find_by_between 'cold-warm'
  end

  def limits_params
    params.permit :cold_warm, :warm_hot
  end

  def weather_message(degrees)
    limits

    "Today is going to be #{if degrees < @cold_warm_limit.degrees
                              'COLD'
                            elsif degrees < @warm_hot_limit.degrees
                              'WARM'
                            else
                              'HOT'
                            end}."
  end
end
