$(document).on('turbolinks:load', function(){
  var current = '#inputs';
  $('#activities').hide();
  $('#outputs').hide();
  $('#outcomes').hide();
  $('#impacts').hide();
  $('#previous-button').hide();
  $('#submit-button').hide();

  $('#next-button').click(function () {
    next = nextStep(current);
    $(current).hide();
    $(next).show();
    current = next;
    showCorrectButtons(current);
  });

  $('#previous-button').click(function () {
    previous = previousStep(current);
    $(current).hide();
    $(previous).show();
    current = previous;
    showCorrectButtons(current);
  });
});

function nextStep(current) {
  var next = ''
  switch (current) {
    case '#inputs':
      next = '#activities';
      break;
    case '#activities':
      next = '#outputs';
      break;
    case '#outputs':
      next = '#outcomes';
      break;
    case '#outcomes':
      next = '#impacts';
      break;
    case '#impacts':
      next = '#impacts';
      break;
  }
  return next;
}

function previousStep(current) {
  var previous = ''
  switch (current) {
    case '#inputs':
      previous = '#inputs';
      break;
    case '#activities':
      previous = '#inputs';
      break;
    case '#outputs':
      previous = '#activities';
      break;
    case '#outcomes':
      previous = '#outputs';
      break;
    case '#impacts':
      previous = '#outcomes';
      break;
  }
  return previous;
}

function showCorrectButtons(current) {
  if(current == '#impacts'){
    $('#submit-button').show();
    $('#next-button').hide();
  } else if(current == '#inputs') {
    $('#submit-button').hide();
    $('#previous-button').hide();
    $('#next-button').show();
  } else {
    $('#submit-button').hide();
    $('#next-button').show();
    $('#previous-button').show();
  }
}