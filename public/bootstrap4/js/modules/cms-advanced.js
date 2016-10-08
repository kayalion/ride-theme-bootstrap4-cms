var rideCms = rideCms || {};

rideCms.advanced = (function($, undefined) {
  var $document = $(document);

  var _initialize = function() {
    $document.on('click', '.btn-properties-show', function(e) {
      e.preventDefault();

      $('.btn-properties-show').addClass('hidden-xs-up');
      $('.full-configuration').removeClass('hidden-xs-up');
      $('.btn-properties-hide').removeClass('hidden-xs-up');
    });
    $document.on('click', '.btn-properties-hide', function(e) {
      e.preventDefault();

      $('.btn-properties-hide').addClass('hidden-xs-up');;
      $('.full-configuration').addClass('hidden-xs-up');;
      $('.btn-properties-show').removeClass('hidden-xs-up');
    });
  };

  return {
    initialize: _initialize
  };
})(jQuery);

// Run the initializer
$(document).ready(function() {
  rideCms.advanced.initialize();
});
