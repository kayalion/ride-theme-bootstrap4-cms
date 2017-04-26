{* widget: text; action: index; translation: widget.text *}
<div class="widget widget-text clearfix {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
{if $title}
    <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title|text}</h2>
{/if}
{if $subtitle}
    <h3 class="toc {$app.cms.properties->getWidgetProperty('style.subtitle')}">{$subtitle|text}</h3>
{/if}
{if $image}
    {if $html}
        {if $imageAlignment == 'justify' || $imageAlignment == 'none'}
            <img src="{image src=$image}" class="img-responsive" />
            {$html|text}
            {foreach $callToActions as $callToAction}
                <a href="{$callToAction->getUrl()}" class="btn btn-default cta{if $callToAction->getIcon()} cta-{$callToAction->getIcon()}{/if}">{$callToAction->getLabel()|text}</a>
            {/foreach}
        {else}
        <div class="row">
            <div class="col-md-6">
                {if $imageAlignment == 'left'}
                    <img src="{image src=$image}" class="img-responsive" />
                {else}
                    {$html|text}
                    {foreach $callToActions as $callToAction}
                        <a href="{$callToAction->getUrl()}" class="btn btn-default cta{if $callToAction->getIcon()} cta-{$callToAction->getIcon()}{/if}">{$callToAction->getLabel()|text}</a>
                    {/foreach}
                {/if}
            </div>
            <div class="col-md-6">
                {if $imageAlignment == 'left'}
                    {$html|text}
                    {foreach $callToActions as $callToAction}
                        <a href="{$callToAction->getUrl()}" class="btn btn-default cta{if $callToAction->getIcon()} cta-{$callToAction->getIcon()}{/if}">{$callToAction->getLabel()|text}</a>
                    {/foreach}
                {else}
                    <img src="{image src=$image}" class="img-responsive" />
                {/if}
            </div>
        </div>
        {/if}
    {else}
        <img src="{image src=$image}" class="img-responsive" />
        {foreach $callToActions as $callToAction}
            <a href="{$callToAction->getUrl()}" class="btn btn-default cta{if $callToAction->getIcon()} cta-{$callToAction->getIcon()}{/if}">{$callToAction->getLabel()|text}</a>
        {/foreach}
    {/if}
{else}
    {$html|text}
    {if $callToActions}
    <div class="btn-group">
    {foreach $callToActions as $callToAction}
        <a href="{$callToAction->getUrl()}" class="btn btn-secondary cta{if $callToAction->getType()} cta-{$callToAction->getType()}{/if}">{$callToAction->getLabel()|text}</a>
    {/foreach}
    </div>
    {/if}
{/if}
</div>
