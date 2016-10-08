{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.site.structure"} | {$site->getName($locale)} | {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="helper/cms/taskbar"}

        {url id="cms.site.structure" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%"] var="url"}
        {call taskbarPanelPublish url=$url revision=$site->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.site.structure" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $site->getRevision()] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    {include "helper/cms/titlebar"
        node=$site
        subtitle="title.site.structure"|translate
        breadcrumbUrl=$app.url.request
        breadcrumbLabel="title.site.structure"|translate
        action="structure"
    }
{/block}

{block name="content_body" append}
    <p>{translate key="label.node.action.structure.intro"}</p>
    {include file="helper/form.prototype"}

    <form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form">
        {call formRows form=$form}
        {call formActions referer=$referer}
    </form>
{/block}
