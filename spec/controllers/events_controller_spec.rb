require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe '#index' do
    it 'returns 200 response' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template('index')
    end

    context 'when json format is requested' do
      render_views
      let!(:event) { Event.create(title: 'New event', start: Date.today, end: Date.today + 1) }
      let(:json) { JSON.parse(response.body, symbolize_names: true) }

      it 'returns list of events as JSON' do
        get :index, params: { format: :json }
        expect(response.content_type).to eq('application/json')
        expect(json).to be_an(Array)
        expect(json[0]).to eq(title: event.title, start: event.start.to_s, end: event.end.to_s)
      end
    end
  end

  describe '#create' do
    let(:json) { JSON.parse(response.body, symbolize_names: true) }

    context 'when event is valid' do
      let(:params) do
        { event: { title: 'Test event', start: Date.today.to_s, end: (Date.today + 1).to_s }, format: :json }
      end

      it 'creates an event' do
        expect { post :create, params: params }.to change(Event, :count).by(1)
      end

      it 'returns created event as JSON' do
        post :create, params: params
        expect(json[:title]).to eq(params[:event][:title])
        expect(json[:start]).to eq(params[:event][:start])
        expect(json[:end]).to eq(params[:event][:end])
      end
    end

    context 'when event is invalid' do
      let(:params) do
        { event: { start: Date.today.to_s, end: (Date.today + 1).to_s }, format: :json }
      end

      it 'returns 422 response' do
        post :create, params: params
        expect(response.status).to eq(422)
      end
    end
  end
end
