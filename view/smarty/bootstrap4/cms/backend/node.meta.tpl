{extends file="cms/backend/index"}

{block name="head_title" prepend}{$node->getName($locale)} | {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="helper/cms/taskbar"}

        {url id="cms.node.meta" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId()] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.meta" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    {include "helper/cms/titlebar"
        node=$node
        subtitle="title.node.meta"|translate
        breadcrumbUrl=$app.url.request
        breadcrumbLabel="label.node.action.meta"|translate
        action="meta"
    }
{/block}

{block name="content_body" append}
    <p>{translate key="label.node.action.meta.intro"}</p>

    {if $parentMeta}
        <h3>{translate key="title.meta.inherited"}</h3>
        <dl class="dl-horizontal">
        {foreach $parentMeta as $property => $value}
            <dt>{$property}</dt>
            <dd>{$value}</dd>
        {/foreach}
        </dl>
    {/if}

    {include file="helper/form.prototype"}
    <form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
        <h3>{translate key="title.meta.general"}</h3>
        {call formRow form=$form row='title'}
        {call formRow form=$form row='description'}
        {call formRow form=$form row='keywords'}

        <h3>{translate key="title.meta.open.graph"}</h3>
        {call formRow form=$form row='og-title'}
        {call formRow form=$form row='og-description'}
        {call formRow form=$form row='og-image'}

        <h3>{translate key="title.meta.custom"}</h3>
        {call formRows form=$form}

        {call formActions referer=$referer}
    </form>
{/block}
