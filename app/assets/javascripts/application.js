//= require jquery
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-datepicker
//= cable
//= easing
//= jquery-ui
//= jquery.flexisel
//= jquery.magnific-popup
//= move-top
//= SmoothScroll.min

$(document).ready(function () {
  $(".popup-with-zoom-anim").magnificPopup({
    type: "inline",
    fixedContentPos: false,
    fixedBgPos: true,
    overflowY: "auto",
    closeBtnInside: true,
    preloader: false,
    midClick: true,
    removalDelay: 300,
    mainClass: "my-mfp-zoom-in"
  });

});
$(window).load(function () {
  $("#slider-range").slider({
    range: true,
    min: 0,
    max: 9000,
    values: [50, 6000],
    slide: function (event, ui) {
      $("#amount").val("$" + ui.values[0] + " - $" + ui.values[1]);
    }
  });
  $("#amount").val("$" + $("#slider-range").slider("values", 0) + " - $" + $("#slider-range").slider("values", 1));

});

$(window).load(function () {
  $("#flexiselDemo1").flexisel({
    visibleItems: 3,
    animationSpeed: 1000,
    autoPlay: true,
    autoPlaySpeed: 3000,
    pauseOnHover: true,
    enableResponsiveBreakpoints: true,
    responsiveBreakpoints: {
      portrait: {
        changePoint: 480,
        visibleItems: 1
      },
      landscape: {
        changePoint: 640,
        visibleItems: 2
      },
      tablet: {
        changePoint: 768,
        visibleItems: 2
      }
    }
  });

});
jQuery(document).ready(function ($) {
  $(".scroll").click(function (event) {
    event.preventDefault();

    $("html,body").animate({
      scrollTop: $(this.hash).offset().top
    }, 1000);
  });
});

$(document).ready(function () {
  $().UItoTop({
    easingType: "easeOutQuart"
  });

});
