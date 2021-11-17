require 'rails_helper'
require 'spec_helper'

RSpec.describe LimitsController, type: :controller do
  before(:each) do
    Limit.destroy_all
  end

  describe 'GET #index' do
    let!(:cold_warm) { Limit.create between: 'cold-warm', degrees: nil }
    let!(:warm_hot) { Limit.create between: 'warm-hot', degrees: nil }

    it 'should redirect to edit' do
      get :index

      expect(response). to redirect_to(edit_path)
    end
  end

  describe 'POST #update' do
    context 'invalid params' do
      let(:cold_warm_param) { 10.00 }
      let(:warm_hot_param) { 9.00 }

      it 'should redirect to edit with a message' do
        post :update, params: { cold_warm: cold_warm_param, warm_hot: warm_hot_param }

        expect(response).to redirect_to(edit_path)
        expect(flash[:alert]).to be_present
      end
    end

    context 'valid params' do
      let(:cold_warm_param) { 10.00 }
      let(:warm_hot_param) { 11.00 }
      let!(:cold_warm) { Limit.create between: 'cold-warm', degrees: 9.50 }
      let!(:warm_hot) { Limit.create between: 'warm-hot', degrees: 13.23 }

      it 'should update the limits' do
        post :update, params: { cold_warm: cold_warm_param, warm_hot: warm_hot_param }

        expect(Limit.find_by_between('cold-warm').degrees).to eq(cold_warm_param)
        expect(Limit.find_by_between('warm-hot').degrees).to eq(warm_hot_param)
      end

      it 'should render index' do
        post :update, params: { cold_warm: cold_warm_param, warm_hot: warm_hot_param }

        expect(response).to render_template(:index)
      end
    end
  end

  describe 'POST #find_weather' do
    context 'rescue an error' do
      before(:each) do
        allow(FindTodaysWeather).to receive(:find).and_raise(BadWeatherRequest)
      end

      it 'should redirect with alert' do
        post :find_weather

        expect(response).to redirect_to(limits_path)
        expect(flash[:alert]).to be_present
      end
    end

    context 'response with a valid response' do
      let!(:cold_warm) { Limit.create between: 'cold-warm', degrees: 9.50 }
      let!(:warm_hot) { Limit.create between: 'warm-hot', degrees: 20.23 }

      before(:each) do
        allow(FindTodaysWeather).to receive(:find).and_return(15.00)
      end

      it 'should redirect with alert' do
        post :find_weather

        expect(response).to redirect_to(limits_path)
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to eq('Today is going to be WARM.')
      end
    end
  end
end
