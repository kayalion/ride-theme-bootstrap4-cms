var rideCms = rideCms || {};

rideCms.content = (function($, undefined) {
  var $document = $(document);
  var $sections = $('.sections');
  var $sectionContainer = $('.section-container');
  var $modalAction = $('.modal-action');
  var $modalActionButtons = $modalAction.find('.btn-primary');
  var $modalWidgetAdd = $('.modal-widget-add');
  var $modalWidgetAddButtons = $modalWidgetAdd.find('.btn-primary');
  var $formWidgetAdd = $('.form-widget-add');
  var $widgetFilter = $('#form-widget-filter');
  var $widgets = $formWidgetAdd.find('.widget');
  var baseUrl = $sections.data('url');

  var _initialize = function() {
    $(window).keydown(function(e) {
      if (e.keyCode == 13) {
        e.preventDefault();

        return false;
      }
    });

    // auto submit region change
    $document.on('change', 'select[name=region]', function() {
      setLoading(true);

      $('#form-region-select').submit();
    });

    // add a new section
    $document.on('click', '.section-add', function(e) {
      e.preventDefault();

      if ($(this).hasClass('disabled')) {
        return;
      }

      setLoading(true);

      $.post(baseUrl + '/sections', function(html) {
        $sections.append(html);

        initModalActions();
        initWidgetOrder(baseUrl, true);

        $('.section:last', $sections).scrollTop();

        setLoading(false);

        rideApp.common.notifySuccess($sections.data('label-success-section-add'));
      }).fail(function() {
        rideApp.common.notifyError($sections.data('label-error-section-add'));
      });
    });

    // delete a section
    $document.on('click', '.section-delete', function(e) {
      e.preventDefault();

      var $this = $(this);

      if ($this.hasClass('disabled')) {
        return;
      }

      if (!confirm($this.data('confirm'))) {
        return;
      }

      setLoading(true);

      var $section = $this.closest('.section');
      $.ajax({
        url: baseUrl + '/sections/' + $section.data('section'),
        type: 'DELETE',
        success: function(result) {
          $section.remove();

          initWidgetOrder(baseUrl, true);

          setLoading(false);

          rideApp.common.notifySuccess($sections.data('label-success-section-delete'));
        },
        error: function() {
          rideApp.common.notifyError($sections.data('label-error-section-delete'));
        }
      });
    });

    // initialize sortable for the sections
    $sections.sortable({
      handle: '.section-handle',
      items: '> .section',
      placeholder: 'placeholder',
      update: function(event, ui) {
        updateOrder(baseUrl);
      }
    });

    // change section layout
    $document.on('click', '.section-layouts > a', function(e) {
      e.preventDefault();

      setLoading(true);

      var $this = $(this);
      var $section = $this.closest('.section');

      $.post(baseUrl + '/sections/' + $section.data('section') + '/layout/' +  $this.data('layout'), function(html) {
        $section.replaceWith(html);

        initModalActions();
        initWidgetOrder(baseUrl, true);

        setLoading(false);

        rideApp.common.notifySuccess($sections.data('label-success-section-save'));
      }).fail(function() {
        rideApp.common.notifyError($sections.data('label-error-section-save'));
      });
    });

    // open widget add modal through link
    $document.on('click', '.widget-add', function(event) {
      var $button = $(this);

      if ($button.hasClass('disabled')) {
        return;
      }

      var $block = $button.parents('.block');
      var $section = $button.parents('.section');

      if ($block.length == 0) {
          $block = $('.block', $section).first();
      }

      $('input[name=section]').val($section.data('section'));
      $('input[name=block]').val($block.data('block'));

      $modalWidgetAdd.modal('show');
    });

    // open widget add modal through double click
    $sections.on('dblclick', '.block', function(e) {
        if ($(e.target).parents('.widget').length) {
          return;
        }

        var $this = $(this);

        var block = $this.data('block');
        var section = $this.parents('.section').data('section');

        $('input[name=section]').val(section);
        $('input[name=block]').val(block);

        $modalWidgetAdd.modal('show');
    });

    // focus filter field when widget add modal shown
    $modalWidgetAdd.on('shown.bs.modal', function () {
      $widgetFilter.focus();
    });

    // filter widgets
    $widgetFilter.on('keyup', function(e) {
      if (e.which == 13) {
        e.preventDefault();

        if ($widgets.find('input[type=radio]:visible').filter(':checked').length == 1) {
          widgetAdd();

          $modalWidgetAdd.modal('hide');
        }

        return;
      }

      var regexp = new RegExp($widgetFilter.val(), 'i');

      $widgets.find('input[type=radio]').prop('checked', false);
      $modalWidgetAddButtons.addClass('disabled');

      $widgets.hide();
      var $filteredWidgets = $widgets.filter(function() {
        var string = $(this).text().trim();

        return regexp.test(string);
      }).show();

      if ($filteredWidgets.length == 1) {
        $widgets.find('input[type=radio]:visible').prop('checked', true);
        $modalWidgetAddButtons.removeClass('disabled');
      }
    });

    // enable add button on widget selection
    $modalWidgetAdd.on('click', 'label', function() {
      $modalWidgetAddButtons.removeClass('disabled');
    });

    // widget add button
    $document.on('click', '.widget-add-submit', function(e) {
      e.preventDefault();

      if ($(this).hasClass('disabled')) {
        return;
      }

      widgetAdd();
    });

    // widget add and close button
    $document.on('click', '.widget-add-submit-close', function(e) {
      e.preventDefault();

      if ($(this).hasClass('disabled')) {
        return;
      }

      widgetAdd();

      $modalWidgetAdd.modal('hide');
    });

    // delete a widget
    $document.on('click', '.widget-delete', function(e) {
      e.preventDefault();

      var $this = $(this);

      if ($this.hasClass('disabled')) {
        return;
      }

      if (!confirm($this.data('confirm'))) {
          return;
      }

      setLoading(true);

      var $section = $this.closest('.section');
      var $block = $this.closest('.block');
      var $widget = $this.closest('.widget');

      $.ajax({
        url: baseUrl + '/sections/' + $section.data('section') + '/block/' + $block.data('block') + '/widget/' + $widget.data('widget'),
        type: 'DELETE',
        success: function(result) {
          $widget.remove();

          setLoading(false);

          rideApp.common.notifySuccess($sections.data('label-success-widget-delete'));
        },
        error: function() {
          rideApp.common.notifyError($sections.data('label-error-widget-delete'));
        }
      });
    });

    // focus first field when action modal is shown
    $modalAction.on('shown.bs.modal', function () {
      $modalAction.find('input[type=text]').first().focus();
    });

    // submit form of action modal
    $modalActionButtons.on('click', function (e) {
      e.preventDefault();

      if ($(this).hasClass('disabled')) {
        return;
      }

      handleModalSubmit();
    });

    initModalActions();
    initWidgetOrder(baseUrl);
  };

  // open modal actions in action modal
  var initModalActions = function() {
    $sections.find('.btn-modal:not(.is-initialized)').addClass('is-initialized').on('click', function (e) {
      e.preventDefault();

      var $action = $(this);

      var href = $action.attr('href');
      if (href[0] == '#') {
        return;
      }

      setLoading(true);

      $modalAction.data('action', $action.data('action'));
      $modalAction.data('section', $action.parents('.section').data('section'));
      $modalAction.data('widget', $action.parents('.widget').data('widget'));

      $modalAction.find('.modal-body').load(href + ' form', function () {
        $modalAction.find('.modal-title').text($action.attr('title'));
        $modalAction.find('.form-actions').hide();
        $modalAction.find('form[role=form]').on('submit', handleModalSubmit);
        $modalAction.find('form[role=form]').on('keydown', function(e) {
          if (e.keyCode == 13) {
            handleModalSubmit();
          }
        });

        $modalAction.modal('show');

        setLoading(false);
      });
    });
  };

  var handleModalSubmit = function(e) {
    if (e) {
      e.preventDefault();
    }

    var $loadingElement = $modalAction.find('.modal-body,.modal-footer');

    setLoading(true, $loadingElement);
    setLoading(true);

    var action = $modalAction.data('action');
    var section = $modalAction.data('section');
    var widget = $modalAction.data('widget');

    var $form = $modalAction.find('form');
    var formValues = $form.serialize();

    $.post($form.attr('action'), formValues, function () {
      switch (action) {
        case 'section-properties':
          var $sectionProperties = $sections.find('.section[data-section="' + section + '"] .section-properties').first();

          var sectionTitle = $form.find('input[name=title]').val();
          var sectionLink = '<a class="btn-modal" href="' + $sectionProperties.attr('href') + '">' + sectionTitle + '</a>';

          $sections.find('.section[data-section="' + section + '"] .section-title').html(sectionLink);

          initModalActions();

          if ($form.find('input[name=isFullWidth]').prop('checked')) {
            $sections.find('.section[data-section="' + section + '"] .section-properties .fa').addClass('text-primary');
          } else {
            $sections.find('.section[data-section="' + section + '"] .section-properties .fa').removeClass('text-primary');
          }

          break;
        case 'section-style':
          if ($form.find('input[name=style]').val()) {
            $sections.find('.section[data-section="' + section + '"] .section-style .fa').addClass('text-primary');
          } else {
            $sections.find('.section[data-section="' + section + '"] .section-style .fa').removeClass('text-primary');
          }

          break;
        case 'widget-style':
          var value = '';
          $form.find('input[type=text]').each(function() {
            value += $(this).val();
          });

          if (value != '') {
            $sections.find('.widget[data-widget="' + widget + '"] .widget-style .fa').addClass('text-primary');
          } else {
            $sections.find('.widget[data-widget="' + widget + '"] .widget-style .fa').removeClass('text-primary');
          }

          break;
      };

      $modalAction.modal('hide');

      setLoading(false, $loadingElement);
      setLoading(false);

      if (widget) {
        rideApp.common.notifySuccess($sections.data('label-success-widget-save'));
      } else {
        rideApp.common.notifySuccess($sections.data('label-success-section-save'));
      }
    }).fail(function() {
      if (widget) {
        rideApp.common.notifySuccess($sections.data('label-error-widget-save'));
      } else {
        rideApp.common.notifySuccess($sections.data('label-error-section-save'));
      }
    });

    return false;
  }

  // initialize the sortable for the widgets
  var initWidgetOrder = function (baseUrl, reset) {
    var $blocks = $('.section .block-content');

    if (reset != undefined && reset) {
      $blocks.each(function() {
        try {
          $(this).sortable('destroy')
        } catch (error) {

        }
      });
    }

    $blocks.sortable({
      handle: '.widget-handle',
      items: '> .widget',
      placeholder: 'placeholder',
      connectWith: $blocks,
      update: function (event, ui) {
        if (this !== ui.item.parent()[0]) {
          // don't update twice
          return;
        }

        updateOrder(baseUrl);
      }
    });
  };

  // perform the order update to the cms
  var updateOrder = function(baseUrl) {
    setLoading(true);

    // generate overview of the widgets in their blocks and sections
    var order = {};
    $('.section').each(function() {
      var $section = $(this);
      var section = 'section' + $section.data('section');

      if (order[section] == undefined) {
        order[section] = {};
      }

      $('.block', $section).each(function() {
        var $block = $(this);
        var block = $block.data('block');

        var $widgets = $('.widget', $block);
        if ($widgets.length) {
          order[section][block] = [];
          $widgets.each(function() {
            order[section][block].push($(this).data('widget'));
          });
        } else {
          order[section][block] = 0;
        }
      });
    });

    // post the order the cms
    $.post(baseUrl + '/order', { order: order }, function(data) {
      setLoading(false);

      rideApp.common.notifySuccess($sections.data('label-success-order'));
    }).fail(function() {
      rideApp.common.notifyError($sections.data('label-error-order'));
    });
  };

  // perform a widget add to the cms
  var widgetAdd = function() {
    var widget = $('input[name=widget]:checked').val();
    var section = $('input[name=section]').val();
    var block = $('input[name=block]').val();

    var $block = $('.section[data-section=' + section + '] .block[data-block=' + block + ']', $sections);
    if ($block.length != 1) {
      alert('no block found');

      return;
    }

    var $loadingElement = $modalWidgetAdd.find('.modal-content');

    setLoading(true);
    setLoading(true, $loadingElement);

	  $.post(baseUrl + '/sections/' + section + '/block/' + block + '/widget/' + widget, function(html) {
      $block.find('.block-content').append(html);

      initModalActions();
      initWidgetOrder(baseUrl, true);

      setLoading(false, $loadingElement);
      setLoading(false);

      rideApp.common.notifySuccess($sections.data('label-success-widget-add'));
    }).fail(function() {
      rideApp.common.notifyError($sections.data('label-error-widget-add'));
    });

    $widgets.show();
    $widgetFilter.val('');
  };

  var setLoading = function(isLoading, $element) {
    if ($element === undefined) {
      $element = $sectionContainer;
    }

    if (isLoading) {
      $element.addClass('is-loading');
      $element.find('.btn').prop('disabled', true).addClass('disabled');
    } else {
      $element.removeClass('is-loading');
      $element.find('.btn').prop('disabled', false).removeClass('disabled');
    }
  };

  return {
    initialize: _initialize
  };
})(jQuery);

// Run the initializer
$(document).ready(function() {
  rideCms.content.initialize();
});
