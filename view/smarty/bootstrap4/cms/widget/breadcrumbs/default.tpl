{* widget: breadcrumbs; action: index; translation: view.breadcrumbs.default *}
<div class="widget widget-breadcrumbs {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    <nav class="breadcrumb {$app.cms.properties->getWidgetProperty('style.menu')}">
    {foreach $app.cms.context.breadcrumbs as $url => $label}
        <a class="breadcrumb-item" href="{$url}">{$label}</a>
    {/foreach}
    </nav>
</div>
