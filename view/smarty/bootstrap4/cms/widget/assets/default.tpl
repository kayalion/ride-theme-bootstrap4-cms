{* widget: assets action: index; translation: widget.assets *}
{if $assets}
<div class="widget widget-assets clearfix {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {if $title}
        <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
    {/if}
    <div class="row">
    hallo
    {foreach $assets as $asset}
        <iframe src="{$asset->getEmbedUrl()}" width="640" height="360" frameborder="0" title="{$asset->getName()|escape}"" webkitallowfullscreen mozallowfullscreen allowfullscreen>
        </iframe>

        <div class="col-md-2">
            <a href="{url id="assets.value" parameters=["asset" => $asset->getId()]}" title="{$asset->getName()|escape}">
        {if $asset->getThumbnail()}
                <img src="{image src=$asset->getThumbnail() width=200 height=200 transformation="crop"}" class="img-responsive" />
        {/if}
            </a>
        </div>
        {if $asset@iteration is div by 6}
    </div><div class="row">
        {/if}
    {/foreach}
    </div>
</div>
{/if}
