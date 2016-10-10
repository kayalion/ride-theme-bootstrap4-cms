{* widget: menu; action: index; translation: view.menu.pills *}

<div class="widget widget-menu {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {if $title}
        <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
    {/if}

    <ul class="nav nav-pills {$app.cms.properties->getWidgetProperty('style.menu')}">
    {foreach $items as $node}
        {if $node->hideInMenu() || (!$app.user && $node->hideForAnonymousUsers()) || ($app.user && $node->hideForAuthenticatedUsers())}
            {continue}
        {/if}

        {if $node->isPublished() && $nodeTypes[$node->getType()]->getFrontendCallback() && $node->isAvailableInLocale($app.locale) && $node->isAllowed($app.security)}
            <li class="nav-item">
            <a class="nav-link{if $app.cms.node->hasParent($node->getId()) || $app.cms.node->getId() == $node->getId()} active{/if}" href="{$app.url.script}{$node->getRoute($app.locale)}">{$node->getName($app.locale, "menu")}</a>
        </li>
        {/if}
    {/foreach}
    </ul>
</div>
