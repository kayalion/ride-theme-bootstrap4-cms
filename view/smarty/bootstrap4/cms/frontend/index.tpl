{extends file="base/index"}

{if isset($app.cms.context)}
    {block name="head_title"}{$app.cms.context.title.node} | {$app.cms.context.title.site}{/block}
{/if}

{block name="head" append}
    {if isset($app.cms.context.canonical)}
        <link rel="canonical" href="{$app.cms.context.canonical}"/>
    {/if}

    {if isset($app.cms.context.localizedUrls)}
        {foreach $app.cms.context.localizedUrls as $localizedUrl}
            <link rel="alternate" hreflang="{$localizedUrl.locale|replace:"_":"-"}" href="{$localizedUrl.url}"/>
        {/foreach}
    {/if}

    {if isset($app.cms.context.pagination)}
        {$paginationUrl = $app.cms.context.pagination->getPreviousLink()}
        {if $paginationUrl}
            <link rel="prev" href="{$paginationUrl}"/>
        {/if}
        {$paginationUrl = $app.cms.context.pagination->getNextLink()}
        {if $paginationUrl}
            <link rel="next" href="{$paginationUrl}"/>
        {/if}
    {/if}

    {if isset($app.cms.node)}
        {$meta = $app.cms.node->getMeta($app.locale)}
        {if $meta}
            {foreach $meta as $metaName => $metaValue}
        <meta property="{$metaName}" content="{$metaValue}" />
            {/foreach}
        {/if}
    {/if}
{/block}

{block name="body_attributes" append} class="node-{$app.cms.node->getId()}"{/block}

{block name="container"}
    {include "helper/cms/frontend"}

    {call region region="header" class="region region-header"}
    {call region region="menu" class="region region-menu"}
    {call region region="title" class="region region-title"}
    {if isset($app.messages)}
        {include file="helper/messages" messages=$app.messages}
    {/if}
    {call region region="content" class="region region-content"}
    {call region region="footer" class="row region region-footer"}
{/block}

{block name="styles" append}
    {style src="bootstrap4/css/modules/cms-front.css" media="all"}
{/block}

{block name="scripts" append}
    {script src="bootstrap4/js/parsley.js"}
    {script src="bootstrap4/js/form.js"}
{/block}
