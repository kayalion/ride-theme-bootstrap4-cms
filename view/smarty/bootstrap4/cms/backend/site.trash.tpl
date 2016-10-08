{extends file="cms/backend/index"}

{block name="head_title" prepend}{$site->getName($locale)} | {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="helper/cms/taskbar"}

        {url id="cms.site.trash" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%"] var="url"}
        {call taskbarPanelPublish url=$url revision=$site->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.site.trash" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $site->getRevision()] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    {include "helper/cms/titlebar"
        node=$site
        subtitle="title.trash"|translate
        breadcrumbUrl=$app.url.request
        breadcrumbLabel="title.trash"|translate
        disableNodeActions=true
    }
{/block}

{block name="content_body" append}
    {if $trashNodes}
        {include file="helper/form.prototype"}

        <form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form">
            {call formRows form=$form}
            {call formActions referer=$referer submit="button.restore"}
        </form>
    {else}
        <p>{translate key="label.trash.empty"}</p>
    {/if}
{/block}
