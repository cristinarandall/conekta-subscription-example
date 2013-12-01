

var conektaSuccessResponseHandler = function(response) {
  var $form = $('#card-form');

    var token_id = response.id;
    // Insert the token_id into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="conektaTokenId" />').val(token_id));
    // and submit
    $form.get(0).submit();
};


var conektaErrorResponseHandler = function(response) {
  var $form = $('#card-form');

   // Show the errors on the form
    $form.find('.card-errors').text(response.message);
    $form.find('button').prop('disabled', false);
};

jQuery(function($) {

        Conekta.setPublishableKey($('meta[name="conekta-key"]').attr('content'));


 $('#card-form').submit(function(event) {
    var $form = $(this);

    // Prevent the boton from submitting multiple times
    $form.find('button').prop('disabled', true);

    Conekta.token.create($form, conektaSuccessResponseHandler, conektaErrorResponseHandler);

    // Prevent form information from being sent to the server 
    return false;
  });



});
