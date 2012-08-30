// Custom slider by NYC Dev Shop for 100kin10

$(document).ready(function() {
  if ( $('#custom_slider').length ) {


  var $slider = $('#custom_slider');
  var $triggers = $('#custom_slider_triggers');
  var current_slide_item = 0;

  // Initialize
  $($slider).find('li').not(":first").hide().css('left', '600px');
  $($slider).find('li').first().addClass('active');
  $($triggers).find('li').first().addClass('active');

  // Functions
  function slide(item) {

    current_slide_item = item;

    var current_item = $('.active', $slider);
    var new_item = $('li', $slider).eq(item);

    $(current_item).css('z-index', '10');
    $(new_item).css({'z-index': '5', 'left': '0px'}).show();

    $(current_item).fadeOut('medium', function() {
      var ind = parseInt( $(new_item).index() );
      $('li', $triggers).removeClass('active').eq(ind).addClass('active');
      $(current_item).css({'z-index': '1', 'left': '600px'}).removeClass('active');
      $(new_item).addClass('active');
    });
  }

  function auto_slide_next() {
    var next = (current_slide_item == 2) ? 0 : current_slide_item + 1;
    slide(next);
  }

  // Clicking triggers
  $('li', $triggers).click(function() {
    var ind = parseInt( $(this).index() );
    slide(ind);
  });

  // Auto scroll
  setInterval(function() { auto_slide_next() }, 4000);


  }
});