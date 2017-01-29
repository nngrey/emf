$(function() {
  var lastTab = localStorage.getItem('lastTab');
  $('.container, .tab-content').removeClass('hidden');
  if (lastTab) {
    $('[data-target="' + lastTab + '"]').tab('show');
  }
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    localStorage.setItem('lastTab', $(this).data('target'));
  });
});