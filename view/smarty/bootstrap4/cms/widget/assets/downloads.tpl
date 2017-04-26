{* widget: assets action: index; translation: template.assets.downloads *}

{if $assets}
<div class="widget widget-assets-downloads clearfix {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {if $title}
        <h2 class="{$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
    {/if}
    <ul class="{$app.cms.properties->getWidgetProperty('style.list')}">
    {foreach $assets as $asset}
        <li>
        {if $asset->getSource() == "url"}
            <a href="{$asset->getValue()}" target="_blank">{$asset->getName()}</a>
        {else}
            {$fileObj = $asset->getValue()|decorate:'file'}
            <a href="{url id="assets.value" parameters=["asset" => $asset->getSlug()]}" class="download">
                {$asset->getName()}
                {if is_object($fileObj)}
                    <span class="download__meta">({$fileObj->getExtension()} {$fileObj->getSize()|decorate:'storage.size'})</span>
                {/if}
            </a>
        {/if}
        </li>
    {/foreach}
    </div>
</div>
{/if}
