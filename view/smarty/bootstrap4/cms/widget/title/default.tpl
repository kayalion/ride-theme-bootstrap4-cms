{* widget: title; action: index; translation: view.template.default *}
<div class="widget widget-title {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {if $title === null}
        {$title = $app.cms.context.title.node}
    {/if}

    {if $anchor}
    <a name="{$anchor}"></a>
    {/if}

    <h{$heading} class="{$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h{$heading}>
</div>
