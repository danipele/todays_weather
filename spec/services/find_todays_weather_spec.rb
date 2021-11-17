require 'rails_helper'
require 'spec_helper'

RSpec.describe FindTodaysWeather do
  describe '#find' do
    it 'should raise missing parameter' do
      expect { FindTodaysWeather.find('') }.to raise_error(BadWeatherRequest, 'Parameter q is missing.')
    end

    it 'should raise no valid location' do
      expect { FindTodaysWeather.find('r583g') }.to raise_error(BadWeatherRequest, 'No matching location found.')
    end

    it 'should not raise any error' do
      expect { FindTodaysWeather.find('ip130sr') }.to_not raise_error(BadWeatherRequest)
    end

    it 'should return a float' do
      expect(FindTodaysWeather.find('ip130sr')).to be_a Float
    end
  end
end
