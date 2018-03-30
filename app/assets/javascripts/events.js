$(function() {
  var $calendar = $('#calendar');

  $calendar.fullCalendar({
    events: '/events.json',
    selectable: true
  });
});
