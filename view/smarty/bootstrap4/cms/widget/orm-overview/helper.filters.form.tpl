<form action="{$app.cms.node->getUrl($app.locale, $app.url.script)}" method="GET">
    {foreach $filters as $filterName => $filter}
        {$isMulti = $filter.type == "multi.or" || $filter.type == "multi.and"}
    <div class="filter filter-{$filterName}">
        <h3>{$filterName}</h3>
        <ul class="list-unstyled">
            {if !$isMulti}
                <li>
                    <label>
                        <input name="{$filterName}" type="radio" value="" {if !$filter.value} checked="checked"{/if}>
                    </label>
                </li>
            {/if}
        {foreach $filter.options as $value => $label}
            <li>
                <label>
                    <input name="{$filterName}{if $isMulti}[]{/if}" type="{if $isMulti}checkbox{else}radio{/if}" value="{$value}" {if $filter.values.$label == $filter.value || (is_array($filter.value) && in_array($filter.values.$label, $filter.value))} checked="checked"{/if}>
                    {$label}
                </label>
            </li>
        {/foreach}
        </ul>
    </div>
    {/foreach}

    <input type="submit" value="{translate key="button.filter"}">
</form>
