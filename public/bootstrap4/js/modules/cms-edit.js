var rideCms = rideCms || {};

rideCms.edit = (function($, undefined) {
  var $document = $(document);
  var $alternateNames;

  var _initialize = function() {
    $alternateNames = $('.alternate-names');
    $alternateNames.addClass('hidden-xs-up');

    $document.on('click', '.btn-alternate-names', function(e) {
      e.preventDefault();

      $alternateNames.toggleClass('hidden-xs-up');
    });
  };

  return {
    initialize: _initialize
  };
})(jQuery);

// Run the initializer
$(document).ready(function() {
  rideCms.edit.initialize();
});
