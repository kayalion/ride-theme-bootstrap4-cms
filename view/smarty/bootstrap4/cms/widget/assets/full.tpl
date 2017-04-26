{* widget: assets action: index; name: Plain image *}

{if $assets}
<div class="widget widget-assets widget-assets-image clearfix {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {if $title}
        <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
    {/if}
    {foreach $assets as $asset}
        {if $asset->getType() == 'video'}
            <a href="{$asset->getValue()|replace:"watch?v=":"embed/"}?rel=0wmode=transparent" rel="colorbox" class="colorbox-video" title="{$asset->getName()|escape}">
                <img src="{image src=$asset->getThumbnail() transformation="resize" width=800 height=800}" class="img-fluid">
            </a>
        {else}
            <a href="{image src=$asset->getValue()}" rel="colorbox" class="colorbox" title="{$asset->getName()|escape}">
                <img src="{image src=$asset->getValue() transformation="resize" width=800 height=800}" class="img-fluid">
            </a>
        {/if}
    {/foreach}
</div>
{/if}
