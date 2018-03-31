require 'rails_helper'

describe 'events creation', js: true do
  let(:default_title) { 'New event' }
  let(:event_cell) { first(".fc-content-skeleton table tbody tr td:nth-child(#{day_no})") }

  before :each do
    visit '/events'
  end

  context 'when clicked on a day' do
    let(:wed_cell) { first('td.fc-wed') }
    let(:day_no) { 3 }
    let(:prompt_trigger) { -> { wed_cell.click } }

    it_behaves_like 'showing prompt for event title'

    context 'when prompt dismissed' do
      it_behaves_like 'not creating event'
    end

    context 'when prompt is submitted' do
      before :each do
        accept_prompt(prompt_options, &prompt_trigger)
        sleep 0.1
      end

      context 'with event title' do
        let(:event_title) { "Test Event #{rand(1..1000)}" }
        let(:prompt_options) { { with: event_title } }

        it_behaves_like 'creating event'
        it_behaves_like 'showing event in calendar'
      end

      context 'without event title' do
        let(:event_title) { default_title }
        let(:prompt_options) { {} }

        it_behaves_like 'creating event'
        it_behaves_like 'showing event in calendar'
      end
    end
  end

  context 'when multiple days selected' do
    let(:mon_cell) { first('td.fc-mon') }
    let(:tue_cell) { first('td.fc-tue') }
    let(:prompt_trigger) { -> { mon_cell.drag_to tue_cell } }
    let(:event_title) { "Test Event #{rand(1..1000)}" }
    let(:prompt_options) { { with: event_title } }
    let(:day_no) { 1 }

    it_behaves_like 'showing prompt for event title'

    context 'when prompt dismissed' do
      it_behaves_like 'not creating event'
    end

    context 'when prompt is submitted' do
      before :each do
        accept_prompt(prompt_options, &prompt_trigger)
        sleep 0.1
      end

      it_behaves_like 'creating event'
      it_behaves_like 'showing event in calendar'

      it 'spans event into multiple cells' do
        expect(event_cell['colspan']).to eq('2')
      end

      it 'creates event with correct dates' do
        expected_start = Date.parse(mon_cell['data-date'])
        expected_end = Date.parse(tue_cell['data-date']) + 1

        expect(Event.find_by(title: event_title, start: expected_start, end: expected_end)).not_to be_nil
      end
    end
  end
end
