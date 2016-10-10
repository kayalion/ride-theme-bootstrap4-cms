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
            <link rel="alternate" hreflang="{$localizedUrl.locale}" href="{$localizedUrl.url}" />
        {/foreach}
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
    {foreach $layouts as $layout}
        {include file=$layout->getFrontendResource() inline}
    {/foreach}

    {function name="region" region=null class=null}
        {if isset($widgets.$region)}
        <div class="{$class}">
            {foreach $regions.$region as $section => $layout}
                {if isset($widgets.$region.$section)}
                    {$functionName = "layout-`$layout`"|replace:"-":"_"}
                    {$style = $app.cms.node->getSectionStyle($region, $section)}
                    {$title = $app.cms.node->getSectionTitle($region, $section, $app.locale)}
                    {$isFullWidth = $app.cms.node->isSectionFullWidth($region, $section)}

                    <div class="container{if $isFullWidth}-fluid{/if} section {$style}">
                        {if $title}
                            <h2 class="section-title">{$title}</h2>
                        {/if}
                        {call $functionName section=$section widgets=$widgets.$region.$section style=$style}
                    </div>
                {/if}
            {/foreach}
        </div>
        {/if}
    {/function}

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
