<div class="page-header m-b-2">
    <nav class="breadcrumb">
        <a class="breadcrumb-item" href="{url id="admin"}">
            {translate key="title.admin.home"}
        </a>
        <a class="breadcrumb-item" href="{url id="cms.site"}">
            {translate key="title.sites"}
        </a>
    {if isset($breadcrumbs)}
        {foreach $breadcrumbs as $url => $label}
        <a class="breadcrumb-item" href="{$url}">
            {$label}
        </a>
        {/foreach}
    {/if}
        <a class="breadcrumb-item" href="{$breadcrumbUrl}">
            {$breadcrumbLabel}
        </a>
    </nav>

    <h1>
    {if $node->getId()}
        {$node->getName($locale)}
    {else}
        {$title}
    {/if}
        <small class="text-muted">
            {$subtitle}
        </small>
    </h1>

    {if $node->getId() && !isset($disableNodeActions)}
    <div class="row">
        <div class="col-md-8">
        {if $node->getType() == 'folder'}
            <span class="text-muted">
                {translate key="label.node.url.none"}
            </span>
        {else}
            {$url = $node->getUrl($locale, $app.url.script)}
            <a class="m-r-1" href="{if isset($nodeActions.go)}{$nodeActions.go}{else}{$url}{/if}" target="_blank">{$url}</a>
            {if isset($nodeActions.preview)}
                <a class="btn btn-secondary btn-sm" href="{$nodeActions.preview}" target="_blank">{translate key="label.node.action.preview"}</a>
            {/if}
        {/if}
        </div>
        <div class="col-md-4">
            {$visibilityAction = null}
            {if isset($nodeActions.visibility)}
                {$visibilityAction = $nodeActions.visibility}
            {/if}

            {include "helper/cms/common"}
            {call visibilityIcons class="node-visibility pull-right" action=$visibilityAction item=$node}
        </div>
    </div>
    {/if}
</div>

{if $node->getId() && !isset($disableNodeActions)}
{$tabActions = []}
{$dropdownActions = []}
{foreach $nodeActions as $name => $url}
    {if $name == 'go'
     || $name == 'preview'
     || $name == 'robots'
    }

    {elseif $name == 'content'
         || $name == 'meta'
         || $name == 'visibility'
         || $name == 'publish'
    }
        {$tabActions[$name] = $url}
    {else}
        {$dropdownActions[$name] = $url}
    {/if}
{/foreach}

<div class="dropdown pull-right">
    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownTitle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <span class="fa fa-cog"></span>
    </button>
    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownTitle">
    {foreach $dropdownActions as $name => $url}
        <a class="dropdown-item" href="{$url}">{translate key="label.node.action.`$name`"}</a>
    {/foreach}

{$dropdownActions = []}
{url id="cms.node.clone" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()] var='url'}
{isGranted url=$url}
    {$dropdownActions['clone'] = $url}
{/isGranted}
{url id="cms.node.delete" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()] var='url'}
{isGranted url=$url}
    {$dropdownActions['delete'] = $url}
{/isGranted}
{if $dropdownActions}
        <li class="dropdown-divider"></li>
    {foreach $dropdownActions as $name => $url}
        <a class="dropdown-item" href="{$url}">
            {translate key="label.node.action.`$name`"}
        </a>
    {/foreach}
{/if}
    </div>
</div>

<ul class="nav nav-tabs m-b-2" role="tablist">
    {foreach $tabActions as $name => $url}
        {if $name == 'publish'}
            {continue}
        {/if}
    <li class="nav-item">
        <a class="nav-link{if $action == $name} active{/if}" href="{$url}">
            {translate key="label.node.action.`$name`"}
        </a>
    </li>
    {/foreach}

    {$name = 'publish'}
    {if isset($tabActions.$name)}
    <li class="nav-item">
        <a class="nav-link{if $action == $name} active{/if}" href="{$tabActions.$name}">
            {translate key="label.node.action.`$name`"}
        </a>
    </li>
    {/if}

    {url id="cms.{$node->getType()}.edit" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()] var='url'}
    {isGranted url=$url}
    <li class="nav-item">
         <a class="nav-link{if $action == 'edit'} active{/if}" href="{$url}">
            {translate key="label.node.action.edit"}
         </a>
    </li>
    {/isGranted}
</ul>
{/if}
