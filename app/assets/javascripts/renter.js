var ApplicationController = Paloma.controller('Application');

ApplicationController.prototype.renter = function() {
  $('#sign-in-link').click(function() {
    $('sign-in-link').addClass('small');
    $('sign-up-link').removeClass('small');
    $('#sign-up').hide();
    $('#sign-in').show();
  });
  $('#sign-up-link').click(function() {
    $('sign-up-link').addClass('small');
    $('sign-in-link').removeClass('small');
    $('#sign-in').hide();
    $('#sign-up').show();
  });
}
