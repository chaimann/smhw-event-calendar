require 'rails_helper'

describe 'events index page', js: true do
  let(:today_bg_color) { 'rgb(252, 248, 227)' }
  let(:today_cell) { first('td.fc-today') { |el| el['data-date'] == Date.today.to_s } }
  let(:days_count) { all('td.fc-day').size }

  before do
    Event.create(title: 'New event', start: Date.today, end: Date.tomorrow)
  end

  before :each do
    visit '/events'
  end

  it 'shows calendar with events' do
    expect(page).to have_css('div#calendar')
    expect(page).to have_content('New event')
  end

  it 'shows a weekly calendar' do
    expect(days_count).to eq(7)
  end

  it 'highlights today' do
    expect(today_cell).to have_color(today_bg_color)
  end
end
