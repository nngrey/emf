$(document).ready(function(){
  $('#add-option').hide();
  $('#performance-indicators').hide();
  $('#question-type').change(function() {
    var selected = $(this).val();
    if (selected === 'Multiple choice' || selected === 'Yes / No' || selected == "True / False") {
      $('#add-option').show();
    } else {
      $('#add-option').remove();
    }
  });
  $('#evaluative-question').change(function() {
    var q = $(this).val();
    console.log(q);
  });
  $('#foo').change(function() {
    if ($(this).val() === 'Yes') {
      $('#performance-indicators').show();
    } else {
      $('#performance-indicators').remove();
    }
  });
});