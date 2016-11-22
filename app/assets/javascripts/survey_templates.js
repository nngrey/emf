$(document).on('turbolinks:load', function(){
  $('.dropdown-toggle').dropdown();
  toggleFields();
  $('#add-option').hide();
  $('#performance-indicators').hide();
  $("#question-type").change(function () {
    toggleFields();
  });

  $('#foo').change(function() {
    if ($(this).val() === 'Yes') {
      $('#performance-indicators').show();
    } else {
      $('#performance-indicators').hide();
    }
  });

  $('#indicators')
    .on("cocoon:before-insert", function(e, added_indicator) {
    added_indicator.find('#indicator').val('');
  });

  $('#survey-questions')
    .on("cocoon:before-insert", function(e, added_question) {
    toggleFields();
    // added_question.find('#new_question').val(added_question.find('#new_question').val().replace(/\s+/g, ''));
    added_question.find('#new_question').val('');
    added_question.find('#option').val('');
    added_question.find('#performance-indicators').hide();
    added_question.find('#add-option').hide();
  });

  $('#survey-questions')
    .on("cocoon:after-insert", function(e, added_question) {

    var foo = added_question.find('#foo');
    var performanceIndicators = added_question.find('#performance-indicators');
    var questionType = added_question.find('#question-type');

    foo.change(function() {
      if ($(this).val() === 'Yes') {
        performanceIndicators.show();
      } else {
        performanceIndicators.hide();
      }
    });

    questionType.change(function () {
      var selected = $(this).val();
      var addOption = added_question.find('#add-option');
      var addQuestionButton = added_question.find('#add-question-button');
      if (selected === 'Multiple choice'){
        addOption.show();
        addQuestionButton.trigger('click');
      } else {
        addOption.hide();
      }
    });
  });


  $('.display_format').change(function() {
    var selected = $(this).val();
    var id = $(this).data("id");
    url = "/data_questions/" + id;
    $.ajax({
      type: "POST",
      url: url,
      data: { _method:'PUT', display_value: selected },
      dataType: 'json',
      success: function(msg) {
        alert( "Display setting has been updated" );
      }
    });
  });

});

function toggleFields() {
  var selected = $("#question-type").val();
  if (selected === 'Multiple choice') {
    $("#add-option").show();
  } else {
    $("#add-option").hide();
  }
}