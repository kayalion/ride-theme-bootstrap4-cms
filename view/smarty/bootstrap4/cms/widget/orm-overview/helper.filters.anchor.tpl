{foreach $filters as $filterName => $filter}
<div class="filter filter-{$filterName}">
    <h3>{$filterName}</h3>
    <ul class="list-unstyled">
    {foreach $filter.urls as $label => $url}
        <li><a class="btn btn-default{if $filter.values.$label == $filter.value || (is_array($filter.value) && in_array($filter.values.$label, $filter.value))} active{/if}" href="{$url}">{$label}</a></li>
    {/foreach}
    </ul>
    <a href="{$filter.empty}">{translate key="button.view.all"}</a>
</div>
{/foreach}
