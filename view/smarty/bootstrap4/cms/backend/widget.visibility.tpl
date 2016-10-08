{extends file="cms/backend/index"}

{block name="head_title" prepend}{$node->getName($locale)} | {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="helper/cms/taskbar"}

        {url id="cms.node.content.widget.visibility" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId(), "region" => $region, "widget" => $widgetId] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.content.widget.visibility" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region, "widget" => $widgetId] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    {url id="cms.node.content" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region] var="url"}
    {$breadcrumbs[$url] = "label.node.action.content"|translate}

    {translate key="title.widget.visibility" widget=$widgetName var="subtitle"}
    {include "helper/cms/titlebar"
        node=$node
        subtitle=$subtitle
        breadcrumbUrl=$app.url.request
        breadcrumbLabel=$subtitle
        action="content"
    }
{/block}

{block name="content_body" append}
    <p>{translate key="label.widget.action.visibility.intro"}</p>

    {include file="helper/form.prototype"}

    <form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form">
        {call formRows form=$form}
        {call formActions referer=$referer}
    </form>
{/block}
