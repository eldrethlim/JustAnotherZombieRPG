$(function() {
  // Get last update time from the load page.
  var lastUpdate = $("#game_update_time").text();
  var lastUpdateUrl = $("#game_update_time").attr("data-url");

  if (lastUpdate) {
    window.setInterval(function() {
      // Every second request new time from the server.
      $.get(lastUpdateUrl, function (data) {
       // If the differ, reload the page.
        if (lastUpdate != data) {
          window.location.reload();
        }
      })
    }, 1000);
  }
});