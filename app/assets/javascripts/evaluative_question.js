$(document).on('turbolinks:load', function(){
  $("#datepicker").datepicker();
});

// function nextStepLogicModel(current) {
//   var next = ''
//   console.log(current);
//   switch (current) {
//     case '#appropriateness':
//       next = '#effectiveness';
//       break;
//     case '#effectiveness':
//       next = '#efficiency';
//       break;
//     case '#efficiency':
//       next = '#impact';
//       break;
//     case '#impact':
//       next = '#sustainability';
//       break;
//     case '#sustainability':
//       next = '#sustainability';
//       break;
//   }
//   return next;
// }

// function previousStepLogicModel(current) {
//   var previous = ''
//   switch (current) {
//     case '#appropriateness':
//       previous = '#appropriateness';
//       break;
//     case '#effectiveness':
//       previous = '#appropriateness';
//       break;
//     case '#efficiency':
//       previous = '#effectiveness';
//       break;
//     case '#impact':
//       previous = '#efficiency';
//       break;
//     case '#sustainability':
//       previous = '#impact';
//       break;
//   }
//   return previous;
// }

// function showCorrectButtonsLogicModel(current) {
//   if(current == '#sustainability'){
//     $('#submit-button').show();
//     $('#next-button').hide();
//   } else if(current == '#appropriateness') {
//     $('#submit-button').hide();
//     $('#previous-button').hide();
//     $('#next-button').show();
//   } else {
//     $('#submit-button').hide();
//     $('#next-button').show();
//     $('#previous-button').show();
//   }
// }