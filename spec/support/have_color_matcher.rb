RSpec::Matchers.define :have_color do |expected_color|
  match do |element|
    element.native.css_value('background-color') == expected_color
  end

  failure_message do |actual|
    "expected the element's color to be #{expected_color} but got #{actual.native.css_value('background-color')}"
  end

  failure_message_when_negated do |actual|
    "expected the element's color not to be #{expected_color}"
  end
end
