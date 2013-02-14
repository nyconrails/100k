// Custom slider by NYC Dev Shop for 100kin10

$(window).load(function() {
  if ( $('#custom_slider').length ) {

  var sliderActive = false;
  var $slider = $('#custom_slider');
  var $triggers = $('#custom_slider_triggers');
  var current_slide_item = 0;

  // Initialize
  $($slider).find('.sliderli').not(":first").hide().css('left', '600px');
  $($slider).find('.sliderli').first().addClass('active');
  $($triggers).find('.sliderli').first().addClass('active');

  // Functions
  function slide(item) {

    current_slide_item = item;

    var current_item = $('.sliderli.active', $slider);
    var new_item = $('.sliderli', $slider).eq(item);

    $(current_item).css('z-index', '10');
    $(new_item).css({'z-index': '5', 'left': '0px'}).show();

    $(current_item).fadeOut('medium', function() {
      var ind = parseInt( $(new_item).index() );
      $('.triggerli', $triggers).removeClass('active').eq(ind).addClass('active');
      $(current_item).css({'z-index': '1', 'left': '600px'}).removeClass('active');
      $(new_item).addClass('active');
    });
  }

  function auto_slide_next() {
    if (sliderActive) {
      var next = (current_slide_item == 3) ? 0 : current_slide_item + 1;
      slide(next);
    }
  }

  // Clicking triggers
  $('.triggerli', $triggers).click(function() {
    var ind = parseInt( $(this).index() );
    stopSlider();
    slide(ind);
    setTimeout(function() { startSlider(); }, 4000);
  });

  // Auto scroll
  sliderActive = true;
  setInterval(function() { auto_slide_next() }, 4000);


  // Videos and sliders
  // Pause slider when videos are playing
  var myVideo;

  function stopSlider() {
    sliderActive = false;
  }

  function startSlider() {
    sliderActive = true;
  }

  var stopSlider = function() {
    sliderActive = false;
  };

  var startSlider = function() {
    sliderActive = true;
  };

  _V_("my_video_a").ready(function() {
    var myVideo = this;

    myVideo.addEvent("play", stopSlider);
    myVideo.addEvent("ended", startSlider);
  });

  _V_("my_video_b").ready(function() {
    var myVideob = this;

    myVideob.addEvent("play", stopSlider);
    myVideob.addEvent("ended", startSlider);
  });


  }
});