var rideCms = rideCms || {};

rideCms.tree = (function($, undefined) {
  var $document = $(document);
  var $container;
  var $tree;
  var $nodeFilter = $('#form-node-filter');
  var treeAction;
  var toggleAllAction;
  var toggleNodeAction;
  var orderAction;

  var _initialize = function($element, collapsedNodes, selectedNode) {
    var urlTree = $element.data('src');
    if (!urlTree) {
      return;
    }

    $container = $element;

    toggleNodeAction = $container.data('url-toggle-node');
    toggleAllAction = $container.data('url-toggle-all');
    orderAction = $container.data('url-order');

    $container.load(urlTree, function() {
      $tree = $('.node-tree', $container);

      $nodeFilter.removeClass('disabled');
      $('.btn-expand-all,.btn-collapse-all').removeClass('disabled');

      // select current node
      if (selectedNode) {
        $tree.find('.node').removeClass('selected');
        $tree.find('.node[data-node="' + selectedNode + '"]').addClass('selected');
      }

      // restore collapse state
      for (var collapsedNode in collapsedNodes) {
        $tree.find('.node[data-node="' + collapsedNode + '"]').addClass('collapsed');
      }

      // collapse/expand a single node
      $tree.on('click', '.node .toggle', function(e) {
        e.preventDefault();

        var $parent = $(this).parents('.node').first();
        var nodeId = $parent.data('node');

        $parent.toggleClass('collapsed');

        if (toggleNodeAction) {
          $.post(toggleNodeAction.replace('%25node%25', nodeId), function() {
          });
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

          rideApp.common.setLoading(true, $container);

          $.post(orderAction, {data: order}, function(data) {
            $tree.nestedSortable(nestedSortableConfig)

            rideApp.common.setLoading(false, $container);
            rideApp.common.notifySuccess($tree.data('label-success-save'));
          }).fail(function() {
            rideApp.common.setLoading(false, $container);
            rideApp.common.notifyError($tree.data('label-error-save'));
          });
        }
      };
      $tree.nestedSortable(nestedSortableConfig);

      rideApp.common.setLoading(false, $container);
    });

    // collapse all nodes
    $document.on('click', '.btn-collapse-all', function() {
      if (!toggleAllAction) {
        return;
      }

      var nodes = [];
      var $expandedNodes = $tree.find('.node:not(.node-site):not(.collapsed)')

      $expandedNodes.each(function() {
        var $this = $(this);

        if ($this.find('.node').length == 0) {
          return;
        }

        nodes.push($(this).data('node'));
      });
      $expandedNodes.addClass('collapsed');

      $.post(toggleAllAction, {nodes: nodes});
    });

    // expand all nodes
    $document.on('click', '.btn-expand-all', function() {
      if (!toggleAllAction) {
        return;
      }

      var nodes = [];
      var $collapsedNodes = $tree.find('.node:not(.node-site).collapsed')

      $collapsedNodes.each(function() {
        nodes.push($(this).data('node'));
      });
      $collapsedNodes.removeClass('collapsed');

      $.post(toggleAllAction, {nodes: nodes});
    });

    // filter nodes
    $document.on('show.bs.offcanvas', '.sidebar', function() {
      $nodeFilter.focus();
    });

    $nodeFilter.on('keyup', function(e) {
      if (e.which == 13) {
        e.preventDefault();
      }

      var regexp = new RegExp($nodeFilter.val(), 'i');

      $nodes = $tree.find('.node').hide();

      var $filteredNodes = $nodes.filter(function() {
        var string = $(this).find('.name').text().trim();

        return regexp.test(string);
      }).show();
    });
  };

  return {
    initialize: _initialize
  };
})(jQuery);
