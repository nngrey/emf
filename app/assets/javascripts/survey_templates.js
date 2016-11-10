$(document).on('turbolinks:load', function(){
  toggleFields();
  $('#add-option').hide();
  $('#performance-indicators').hide();

  // $('#question-type').change(function() {
  //   // var selected = $(this).val();
  //   if ($(this).val() === 'Multiple choice' || $(this).val() === 'Yes / No' || $(this).val() === "True / False") {
  //     $('#add-option').show();
  //   } else {
  //     $('#add-option').remove();
  //   }
  // });

  $("#question-type").change(function () {
    toggleFields();
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

function toggleFields() {
  var selected = $("#question-type").val();
  if (selected === 'Multiple choice' || selected === 'Yes / No' || selected === "True / False") {
    $("#add-option").show();
  } else {
    $("#add-option").hide();
  }
}