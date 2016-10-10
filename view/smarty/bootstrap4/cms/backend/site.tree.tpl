{function name="renderTreeNode" treeNode=null level=null}
    {$node = $treeNode->getNode()}
    {$nodeId = $node->getId()}
    {$nodeType = $node->getType()}
    {$children = $treeNode->getChildren()}
    {$actions = $treeNode->getActions()}
    {$isLocalized = $treeNode->isLocalized($locale)}

    <li class="node node-{$nodeType}{if $treeNode->isHidden()} node-unpublished{else} node-published{/if}{if $treeNode->isHomePage()} node-default{/if}{if !$isLocalized} node-unlocalized{else} node-localized{/if}" id="node-{$node->getId()}" data-node="{$node->getId()}">
        {if $children}
        <a href="#" class="toggle"></a>
        {else}
        <span class="toggle"></span>
        {/if}

        <div class="handle"><span class="icon"></span></div>
        <div class="dropdown">
            {$truncateLength = 20}
            {if $level > 2}
                {$truncateLength = 15}
            {/if}

            {$name = $node->getName($locale)}
            <a class="name{if !$isLocalized} text-danger{/if}" href="{$treeNode->getUrl()}" title="{$name|escape}">
                {$name|truncate:$truncateLength}
            </a>
            {if $node->getSecurity() !== false}
                <span class="fa fa-lock text-muted{if !$isLocalized} text-danger{/if}" title="{translate key="label.node.tooltip.secured"}"></span>
            {/if}
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"></a>
            <div class="dropdown-menu dropdown-menu-right" role="menu">

            {$orderedActions = [0 => [], 1 => [], 2 => [], 3 => []]}
            {foreach $actions as $actionName => $actionUrl}
                {if $actionName == 'robots'}
                    {* ignore *}
                {elseif $actionName == 'go'
                     || $actionName == 'preview'
                }
                    {$orderedActions[0][$actionName] = $actionUrl}
                {elseif $actionName == 'content'
                     || $actionName == 'meta'
                     || $actionName == 'visibility'
                     || $actionName == 'publish'
                     || $actionName == 'edit'
                 }
                    {$orderedActions[1][$actionName] = $actionUrl}
                {elseif $actionName == 'clone'
                     || $actionName == 'delete'
                 }
                    {$orderedActions[3][$actionName] = $actionUrl}
                {else}
                    {$orderedActions[2][$actionName] = $actionUrl}
                {/if}
            {/foreach}

            {foreach $orderedActions as $actionIndex => $actions}
                {foreach $actions as $actionName => $actionUrl}
                    <a class="dropdown-item action action-{$actionName}" href="{$actionUrl}"{if $actionName == 'go' || $actionName == 'preview'} target="_blank"{/if}>
                        {translate key="label.node.action.`$actionName`"}
                    </a>
                {/foreach}

                {if $actions && !$actions@last}
                    <div class="dropdown-divider"></div>
                {/if}
            {/foreach}
            </div>
        </div>

        {if $children}
        <ul class="children">
            {$level = $level + 1}
            {foreach $children as $child}
                {call renderTreeNode treeNode=$child level=$level}
            {/foreach}
        </ul>
        {/if}
    </li>
{/function}

<div class="loading">
    <span class="fa fa-spinner fa-pulse"></span>
</div>

<ul class="node-tree"
    data-label-success-save="{"success.site.structure"|translate}"
    data-label-error-save="{"error.site.structure"|translate}"
>
    {call renderTreeNode treeNode=$siteTreeNode level=0}
</ul>
