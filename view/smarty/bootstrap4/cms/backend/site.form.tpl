{extends file="cms/backend/index"}

{block name="head_title" prepend}{if $node->getId()}{translate key="title.site.edit"}{else}{translate key="title.site.add"}{/if} | {/block}

{block name="taskbar_panels" append}
    {if isset($site) && $site->getId()}
        {if $node->getId()}
            {if !$site->isAutoPublish()}
                {include file="helper/cms/taskbar"}

                {url id="cms.site.edit" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%"] var="urlPublish"}

                {call taskbarPanelPublish url=$urlPublish revision=$node->getRevision() revisions=$site->getRevisions()}
            {/if}

            {url id="cms.site.edit" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $site->getRevision()] var="urlLocales"}
        {else}
            {url id="cms.site.add" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%"] var="urlPublish"}
        {/if}
    {else}
        {url id="cms.site.add" parameters=["locale" => "%locale%"] var="urlLocales"}
    {/if}

    {call taskbarPanelLocales url=$urlLocales locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    {$title = "title.sites"|translate}
    {if $node->getId()}
        {$subtitle = "title.site.edit"|translate}
        {$breadcrumbLabel = "label.node.action.edit"|translate}
        {$action = "edit"}
    {else}
        {$subtitle = "title.site.add"|translate}
        {$breadcrumbLabel = "button.add"|translate}
        {$action = "add"}
    {/if}
    {include "helper/cms/titlebar"
        node=$node
        title=$title
        subtitle=$subtitle
        breadcrumbUrl=$app.url.request
        breadcrumbLabel=$breadcrumbLabel
        action=$action
    }
{/block}

{block name="content_body" append}
    {include file="helper/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        {call formRows form=$form}
        {call formActions referer=$referer}
    </form>
{/block}
