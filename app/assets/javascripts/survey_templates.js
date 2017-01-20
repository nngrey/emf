$(document).on('turbolinks:load', function(){
  $('.dropdown-toggle').dropdown();
  toggleFields();
  $('#add-option').hide();
  $('#multiple-answers').hide();
  $('#performance-indicators').hide();
  $('.options1').hide();
  $('.options2').hide();

  // $('#label').hide();
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
    added_indicator.find('.indicator').val('');
  });

// Clicks link on new collection date to open field
  $('#indicators')
    .on("cocoon:after-insert", function(e, added_indicator) {
    added_indicator.find('#add-date').trigger('click');
  });

  $('#add-option')
    .on("cocoon:before-insert", function(e, added_option) {
    added_option.find('#option').val('');
  });

  $('#survey-questions')
    .on("cocoon:before-insert", function(e, added_question) {
    toggleFields();
    // added_question.find('#new_question').val(added_question.find('#new_question').val().replace(/\s+/g, ''));
    added_question.find('#new_question').val('');
    added_question.find('#option').val('');
    added_question.find('#performance-indicators').hide();
    added_question.find('#add-option').hide();
    // added_question.find('#multiple-answers').hide();
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
      var multipleAnswers = added_question.find('#multiple-answers');
      var addQuestionButton = added_question.find('#add-question-button');
      if (selected === 'Multiple choice'){
        multipleAnswers.show();
        addOption.show();
        addQuestionButton.trigger('click');
      } else {
        addOption.hide();
        multipleAnswers.hide();
      }
    });
  });


  $('.display_format').change(function() {
    var selected = $(this).val();
    var id = $(this).data("id");
    var url = "/data_questions/" + id;
    $.ajax({
      type: "POST",
      url: url,
      data: { _method:'PUT', display_value: selected },
      dataType: 'json',
      success: function() {
        alert( "Display setting has been updated" );
      }
    });
  });

  $('.analysis_display_format').change(function() {
    var selected = $(this).val();
    var id = $(this).data("id");
    var url = "/analyses/" + id;
    $.ajax({
      type: "POST",
      url: url,
      data: { _method:'PUT', display_value: selected },
      dataType: 'json',
      success: function() {
        alert( "Display setting has been updated" );
      }
    });
  });

  $('#bar').change(function() {
    $('.options1').hide();
    $("#label1").show();
    var questionIds = $('#blah').val().split(' ');
    var questionId = $(this).val();
    var index = questionIds.indexOf(questionId);
    if (index > -1) {
        questionIds.splice(index, 1);
    }
    var arrayLength = questionIds.length;
    for (var i = 0; i < arrayLength; i++) {
        $("#options1_for_" + questionIds[i]).remove();
    }
    $("#options1_for_" + questionId).show();
    $("#options1_for_" + questionId).change(function() {
      var optionId = $(this).val();
    });
  });

  $('#baz').change(function() {
    $('.options2').hide();
    $("#label2").show();
    var questionIds2 = $('#blah').val().split(' ');
    var questionId2 = $(this).val();
    var index = questionIds2.indexOf(questionId2);
    if (index > -1) {
        questionIds2.splice(index, 1);
    }
    var arrayLength = questionIds2.length;
    for (var i = 0; i < arrayLength; i++) {
        $("#options2_for_" + questionIds2[i]).remove();
    }
    $("#options2_for_" + questionId2).show();
    $("#options2_for_" + questionId2).change(function() {
      var optionId2 = $(this).val();
    });
  });

  $('.question-list').sortable({
    axis: 'y',
    update: function() {
      var data = $(this).sortable('serialize');
      $.ajax({
        type: "POST",
        url: '/data_questions/sort',
        data: data,
        dataType: 'json',
        success: function() {}
      });
    }
  });
});

function toggleFields() {
  var selected = $("#question-type").val();
  if (selected === 'Multiple choice') {
    $("#add-option").show();
    $('#multiple-answers').show();
  } else {
    $("#add-option").hide();
    $('#multiple-answers').hide();
  }
}