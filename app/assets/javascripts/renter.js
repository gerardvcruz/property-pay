var ApplicationController = Paloma.controller('Application');

ApplicationController.prototype.renter = function() {
  $('#sign-in-link').click(function() {
    $('#sign-up').hide();
    $('#sign-in').show();
  });
  $('#sign-up-link').click(function() {
    $('#sign-in').hide();
    $('#sign-up').show();
  });
}
