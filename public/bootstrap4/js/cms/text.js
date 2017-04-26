var rideCms = rideCms || {};

rideCms.text = (function($, undefined) {
  var $document = $(document);
  var $textExistingNew = $('#form-text-existingNew');
  var $textExisting = $('.row-existing');
  var $textExistingSelect = $('select', $textExisting);
  var $btnSubmit = $('.btn-submit');
  var $btnCancel = $('.btn-cancel');

  var _initialize = function() {
    $textExistingNew.change(function(e) {
        e.preventDefault();

        handleTextReuse(this.checked);
    });
    handleTextReuse($textExistingNew.is(':checked'));

    $textExisting.on('change', 'select', function() {
      var $this = $(this);

      var locale = $textExisting.data('locale');
      var url = $textExisting.data('url-text');
      url = url.replace('%25id%25', $this.val());

      $.ajax({
        url: url,
        type: "GET",
        beforeSend: function(xhr) { xhr.setRequestHeader('Accept-Language', locale);},
        success: function(data) {
          var preview = '';
          if (data.title) {
              preview += '<h3>' + data.title + '</h3>';
          }
          if (data.subtitle) {
              preview += '<h4>' + data.subtitle + '</h4>';
          }
          if (data.body) {
              preview += data.body;
          }

          $('.preview', $textExisting).html(preview);
        }
      });
    });

    $('#btn-text-reuse').click(function(e) {
      e.preventDefault();

      $('.tab').addClass('hidden-xs-up');
      $textExisting.removeClass('hidden-xs-up').data('id', $textExistingSelect.val());

      $btnCancel.click(function(e) {
        e.preventDefault();

        $textExistingSelect.val($textExisting.data('id'));

        $('.tab').removeClass('hidden-xs-up');
        $textExisting.addClass('hidden-xs-up');

        $btnCancel.unbind();
        $btnSubmit.unbind();
      });

      $btnSubmit.click(function(e) {
        var oldTextId = $textExisting.data('id');
        var textId = $textExistingSelect.val();
        if (textId && textId != oldTextId) {
          var form = $('#form-text');

          var url = form.attr('action') + '?text=' + textId;
          if ($textExistingNew.is(':checked')) {
              url += '&new=1';
          }

          form.attr('action', url);
        } else {
          $btnCancel.trigger('click');

          e.preventDefault();
        }
      });
    });
  };

  var handleTextReuse = function(isChecked) {
    var $alert = $('.notice--warning');
    if (isChecked) {
        $alert.addClass('superhidden');
    } else {
        $alert.removeClass('superhidden');
    }
  };

  return {
    initialize: _initialize
  };
})(jQuery);

// Run the initializer
$(document).ready(function() {
  rideCms.text.initialize();
});
