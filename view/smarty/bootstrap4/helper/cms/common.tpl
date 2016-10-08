{function visibilityIcons class=null action=null item=null}
    {if $action}
        <a class="{$class}" href="{$action}">
    {else}
        <span class="{$class}">
    {/if}

    {if $app.locales|count > 1}
        {foreach $app.locales as $localeCode => $locale}
            {if $item->isAvailableInLocale($localeCode)}
                <span class="tag tag-success" title="{translate key="label.node.tooltip.localized" language=$locale->getName()}">{$localeCode}</span>
            {else}
                <span class="tag tag-danger" title="{translate key="label.node.tooltip.unlocalized" language=$locale->getName()}">{$localeCode}</span>
            {/if}
        {/foreach}

        &nbsp;
    {/if}

    {if $item->isPublished()}
        <span class="fa fa-eye text-success" title="{translate key="label.node.tooltip.published"}"></span>
    {else}
        <span class="fa fa-eye-slash text-danger" title="{translate key="label.node.tooltip.unpublished"}"></span>
    {/if}

    &nbsp;

    {if $item->getSecurity() === false}
        <span class="fa fa-unlock text-success" title="{translate key="label.node.tooltip.unsecured"}"></span>
    {else}
        <span class="fa fa-lock text-warning" title="{translate key="label.node.tooltip.secured"}"></span>
    {/if}

    {if $action}
        </a>
    {else}
        </span>
    {/if}
{/function}
