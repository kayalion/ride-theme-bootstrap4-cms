{extends file="cms/backend/index"}

{block name="head_title" prepend}{$node->getName($locale)} | {/block}

{block name="content_title" append}
    {if $node->getType() == 'site'}
        {$subtitle = "title.site.`$type`"|translate}
    {else}
        {$subtitle = "title.node.`$type`"|translate}
    {/if}
    {include "helper/cms/titlebar"
        node=$node
        subtitle=$subtitle
        breadcrumbUrl=$app.url.request
        breadcrumbLabel=$subtitle
        action="confirm"
    }
{/block}

{block name="content_body" append}
    {include file="helper/form.prototype"}

    {if $node->getId() == $node->getRootNodeId() && $type == 'delete'}
        <div class="alert alert-warning">
            <p>{translate key="warning.site.delete"}</p>
        </div>
    {/if}

    <form action="{$app.url.request}" method="POST" role="form">
        <div class="form-group">
            <p>{translate key="label.confirm.node.`$type`" node=$node->getName($locale)}</p>
        </div>

        {call formActions referer=$referer submit="button.`$type`"}
    </form>
{/block}
