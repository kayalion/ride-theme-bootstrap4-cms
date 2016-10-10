{* widget: language.select; action: index; translation: view.language.select.default *}
<div class="widget widget-language-select {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    <ul class="nav {$app.cms.properties->getWidgetProperty('style.menu')}">
    {foreach $locales as $code => $data}
        {$locale = $data.locale}
        <li class="nav-item">
            <a class="nav-link{if $code == $app.locale} active{/if}" href="{$data.url}">{$locale->getName()}</a>
        </li>
    {/foreach}
    </ul>
</div>
