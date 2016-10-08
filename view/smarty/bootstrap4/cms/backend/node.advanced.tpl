{extends file="cms/backend/index"}

{block name="head_title" prepend}{$node->getName($locale)} | {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="helper/cms/taskbar"}

        {url id="cms.node.advanced" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId()] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.advanced" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    {include "helper/cms/titlebar"
        node=$node
        subtitle="title.node.advanced"|translate
        breadcrumbUrl=$app.url.request
        breadcrumbLabel="label.node.action.advanced"|translate
        action="advanced"
    }
{/block}

{block name="content_body" append}
    <p>{translate key="label.node.action.advanced.intro"}</p>
    {include file="helper/form.prototype"}

    <form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form">
        <div class="form-group">
            {call formWidget form=$form row="properties"}
            {call formWidgetErrors form=$form row="properties"}
        </div>

        {call formRows form=$form}
        {call formActions referer=$referer}
    </form>

    <p>
        <a href="#" class="btn-properties-show">{translate key="button.properties.show"}</a>
        <a href="#" class="btn-properties-hide hidden-xs-up">{translate key="button.properties.hide"}</a>
    </p>
    <div class="full-configuration hidden-xs-up">
        {$nodeProperties}
    </div>
{/block}

{block name="scripts" append}
    {script src="bootstrap4/js/modules/cms-advanced.js"}
{/block}
