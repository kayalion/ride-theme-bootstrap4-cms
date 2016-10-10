var rideCms = rideCms || {};

rideCms.edit = (function($, undefined) {
  var $document = $(document);
  var $inputName = $document.find('input[name=name]');
  var $inputRoute = $document.find('input[name=route]');
  var $inputRouteGroup = $inputRoute.parents('.form-group');
  var $alternateNames;
  var node = '';
  var autoRoute = false;
  var autoRoutePrefix = '';
  var urlRouteValidate = '';
  var isRouteChanged = false;
  var oldNameValue;
  var oldRouteValue;

  var _initialize = function() {
    $alternateNames = $('.alternate-names');
    $alternateNames.addClass('hidden-xs-up');

    $document.on('click', '.btn-alternate-names', function(e) {
      e.preventDefault();

      $alternateNames.toggleClass('hidden-xs-up');
    });

    initializeAutomaticRoute();

    $inputName.focus();
  };

  var initializeAutomaticRoute = function() {
    if ($inputRoute.length == 0) {
      return;
    }

    oldNameValue = $inputName.val();
    oldRouteValue = $inputRoute.val();

    var $form = $inputRoute.parents('form');

    autoRoute = $inputRoute.val() == '' ? true : false;
    autoRoutePrefix = $form.data('route-prefix');
    node = $form.data('node');
    urlRouteValidate = $form.data('url-route-validate');

    if (urlRouteValidate) {
      $inputRouteGroup.append('<div class="loading"><span class="fa fa-spinner fa-pulse"></span></div>');
    }

    $inputRoute.on('blur', function(e) {
      validateRoute();
    });
    // use keydown and keyup so we only respond to actual changes
    $inputRoute.on('keydown', function(e) {
      oldRouteValue = $inputRoute.val();
    });
    $inputRoute.on('keyup', function(e) {
      if (oldRouteValue != $inputRoute.val()) {
        if ($inputRoute.val() == '') {
          autoRoute = true;
        } else {
          autoRoute = false;
        }

        onRouteChange();
      }
    });

    $inputName.on('blur', function(e) {
      if (autoRoute && isRouteChanged) {
        performAutoRoute();
        validateRoute();
      }
    });
    // use keydown and keyup so we only respond to actual changes
    $inputName.on('keydown', function(e) {
      oldNameValue = $inputName.val();
    });
    $inputName.on('keyup', function(e) {
      if (oldNameValue != $inputName.val()) {
          performAutoRoute();
      }
    });
  };

  var performAutoRoute = function() {
    if (autoRoute != true) {
      return;
    }

    var name = $inputName.val();
    if (name != '') {
      oldRouteValue = autoRoutePrefix + '/' + rideApp.common.convertToSlug(name);
    } else {
      oldRouteValue = '';
    }

    $inputRoute.val(oldRouteValue);

    onRouteChange();
  };

  var validateRoute = function() {
    if (!urlRouteValidate || !isRouteChanged) {
      return;
    }

    isRouteChanged = false;

    var route = $inputRoute.val();
    if (route == '') {
      return;
    }

    $inputRouteGroup.addClass('is-loading');

    // check the route through the CMS
    $.post(urlRouteValidate, { node: node, route: route }, function(data) {
      var isValid = data.isValid;

      if (!isValid) {
        if (data.route) {
          isValid = true;
          rideApp.common.notifyWarning(data.error);
        } else {
          rideApp.common.notifyError(data.error);
        }
      }

      if (isValid) {
        $inputRoute.val(data.route);

        onRouteChange(true);
      } else {
        onRouteChange(false);
      }

      isRouteChanged = false;

      $inputRouteGroup.removeClass('is-loading');
    }).fail(function(data) {
      $inputRouteGroup.removeClass('is-loading');
    });
  };

  var onRouteChange = function(isValid) {
    oldRouteValue = $inputRoute.val();
    isRouteChanged = true;

    $inputRoute
      .removeClass('form-control-success')
      .removeClass('form-control-danger');
    $inputRouteGroup
      .removeClass('has-success')
      .removeClass('has-danger');

    if (isValid === true) {
      $inputRoute.addClass('form-control-success');
      $inputRouteGroup.addClass('has-success');
    } else if (isValid === false) {
      $inputRoute.addClass('form-control-danger');
      $inputRouteGroup.addClass('has-danger');
    }
  };

  return {
    initialize: _initialize
  };
})(jQuery);

// Run the initializer
$(document).ready(function() {
  rideCms.edit.initialize();
});
