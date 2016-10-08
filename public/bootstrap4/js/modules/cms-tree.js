var rideCms = rideCms || {};

rideCms.tree = (function($, undefined) {
  var $document = $(document);
  var treeAction;
  var toggleAction;
  var orderAction;

  var _initialize = function($element, collapsedNodes, selectedNode) {
    var urlTree = $element.data('src');
    if (!urlTree) {
      return;
    }

    toggleAction = $element.data('url-toggle');
    orderAction = $element.data('url-order');

    $element.load(urlTree, function() {
      var $tree = $('.node-tree', $element);

      // select current node
      if (selectedNode) {
          $tree.find('.node').removeClass('selected');
          $tree.find('.node[data-node="' + selectedNode + '"]').addClass('selected');
      }

      // implement the expand/collapse function of the node tree
      for (var collapsedNode in collapsedNodes) {
          $tree.find('.node[data-node="' + collapsedNode + '"]').addClass('collapsed');
      }

      $tree.on('click', '.node .toggle', function(e) {
          e.preventDefault();

          $element.addClass('is-loading');

          var $parent = $(this).parents('.node').first();
          var nodeId = $parent.data('node');

          $parent.toggleClass('collapsed');

          if (toggleAction) {
            $.post(toggleAction.replace('%25node%25', nodeId), function() {
                $element.removeClass('is-loading');
            });
          } else {
            $element.removeClass('is-loading');
          }
      });

        // implement the sortable tree
      var nestedSortableConfig = {
        listType: 'ul',
        items: '.node',
        handle: '.handle',
        helper: 'clone',
        opacity: .6,
        placeholder: 'placeholder',
        protectRoot: true,
        isTree: true,
        update: function(){
          var order = $tree.nestedSortable('serialize');
          $tree.nestedSortable('destroy')

          $element.addClass('is-loading');

          $.post(orderAction, {data: order}, function(data) {
            $tree.nestedSortable(nestedSortableConfig)

            $element.removeClass('is-loading');

            rideApp.common.notifySuccess($tree.data('label-success-save'));
          }).fail(function() {
            $element.removeClass('is-loading');

            rideApp.common.notifyError($tree.data('label-error-save'));
          });
        }
      };
      $tree.nestedSortable(nestedSortableConfig);

      $element.removeClass('is-loading');
    });
  };

  return {
    initialize: _initialize
  };
})(jQuery);
