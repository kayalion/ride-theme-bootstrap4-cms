{function visibilityIcons class=null action=null item=null}
    {$type = 'widget'}
    {if $item instanceof \ride\library\cms\node\Node}
        {$type = 'node'}
    {/if}

    {if $action}
        <a class="visibility-icons {$class}" href="{$action}">
    {else}
        <span class="visibility-icons {$class}">
    {/if}

    {if $item->getSecurity()}
        <span class="fa fa-lock text-muted" title="{translate key="label.`$type`.tooltip.secured"}"></span>

        &nbsp;
    {/if}

    {if $item->isPublished()}
        <span class="fa fa-eye text-success" title="{translate key="label.`$type`.tooltip.published"}"></span>
    {else}
        <span class="fa fa-eye-slash text-danger" title="{translate key="label.`$type`.tooltip.unpublished"}"></span>
    {/if}

    {if $app.locales|count > 1}
        &nbsp;

        {foreach $app.locales as $localeCode => $locale}
            {if $item->isAvailableInLocale($localeCode)}
                <span class="badge badge-success" title="{translate key="label.`$type`.tooltip.localized" language=$locale->getName()}">{$localeCode}</span>
            {else}
                <span class="badge badge-danger" title="{translate key="label.`$type`.tooltip.unlocalized" language=$locale->getName()}">{$localeCode}</span>
            {/if}
        {/foreach}
    {/if}

    {if $action}
        </a>
    {else}
        </span>
    {/if}
{/function}
