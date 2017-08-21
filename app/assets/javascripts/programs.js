//This code keeps the user on the current tab after a page refresh but interferes with the
//timeline graph in certain situations. Need to refactor.

/*

$(document).on('turbolinks:load', function() {
  var lastTab = localStorage.getItem('lastTab');
  // $('.container, .tab-content').removeClass('hidden');
  if (lastTab) {
    $('[data-target="' + lastTab + '"]').tab('show');
  } else {
    $('a[data-toggle="tab"]:first').tab('show');
  }
  $('a[data-toggle="tab"]').on('shown.bs.tab', function () {
    localStorage.setItem('lastTab', $(this).data('target'));
  });
});

*/
