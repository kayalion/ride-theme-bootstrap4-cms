{extends file="cms/backend/index"}

{block name="head_title" prepend}{$node->getName($locale)} | {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="helper/cms/taskbar"}

        {url id="cms.node.content.widget.properties" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId(), "region" => $region, "widget" => $widgetId] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.content.widget.properties" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region, "widget" => $widgetId] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    {url id="cms.node.content" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region] var="url"}
    {$breadcrumbs[$url] = "label.node.action.content"|translate}

    {translate key="title.widget.properties" widget=$widgetName var="subtitle"}
    {include "helper/cms/titlebar"
        node=$node
        subtitle=$subtitle
        breadcrumbUrl=$app.url.request
        breadcrumbLabel=$subtitle
        action="content"
    }
{/block}

{block name="content_body" append}
    {include file="helper/form.prototype"}

    <form class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        <ul class="nav nav-tabs">
        {foreach $templates as $file => $content}
            <li class="nav-item">
                <a class="nav-link{if $content@first} active{/if}" href="#{$file|replace:".":"-"}" data-toggle="tab">
                    {$file}
                </a>
            </li>
        {/foreach}
        </ul>

        <div class="tab-content">
        {foreach $templates as $file => $content}
            <div id="{$file|replace:".":"-"}" class="tab-pane clearfix{if $content@first} active{/if}">
                <br />
                {call formWidget form=$form row="content" part=$file}
                {call formWidgetErrors form=$form row="content" part=$file}
                <br />

                {call formRow form=$form row="path" part=$file}
            </div>
        {/foreach}
        </div>

        {call formActions referer=$referer}
    </form>
{/block}
