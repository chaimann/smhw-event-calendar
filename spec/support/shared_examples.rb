shared_examples_for 'creating event' do
  let(:created_event) { Event.find_by(title: event_title) }

  it 'creates event with name' do
    expect(created_event).not_to be_nil
  end
end

shared_examples_for 'showing event in calendar' do
  it 'shows event in calendar in correct cell' do
    expect(event_cell['class']).to eq('fc-event-container')
    expect(event_cell).to have_content(event_title)
  end
end

shared_examples_for 'showing prompt for event title' do
  it 'shows a prompt for event title' do
    prompt_text = dismiss_prompt(&prompt_trigger)
    expect(prompt_text).to eq('Enter event title')
  end
end

shared_examples_for 'not creating event' do
  it 'does not create an event' do
    dismiss_prompt(&prompt_trigger)
    expect(Event.count).to be_zero
  end
end
