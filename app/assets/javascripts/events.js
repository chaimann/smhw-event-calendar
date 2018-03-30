$(function() {
  var $calendar = $('#calendar');

  $calendar.fullCalendar({
    events: '/events.json',
    selectable: true,
    select: function(start, end, jsEvent) {
      var newEvtTitle = prompt('Enter event title');

      if (newEvtTitle === null) {
        unselect();
        return;
      }

      var evtData = {
        title: newEvtTitle || 'New event',
        start: start.format(),
        end: end.format()
      };

      saveEvent(evtData, renderEvent);
    }
  });

  function renderEvent(data) {
    $calendar.fullCalendar('renderEvent', data);
  }

  function saveEvent(data, onSuccess) {
    $.ajax({
      url: '/events.json',
      method: 'POST',
      headers: {
        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
      },
      data: { event: data },
      success: onSuccess,
      error: function() {
        alert('Something went wrong!');
      },
      complete: unselect
    })
  }

  function unselect() {
    $calendar.fullCalendar('unselect');
  }
});
