//= require active_admin/base

$(document).ready(function() {

  $('.version_data').hide();

  $('.version_data_trigger').click(function(e) {
    $(this).parent().next().slideToggle();
    e.preventDefault();
  });

});