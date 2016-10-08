{extends file="cms/backend/index"}

{block name="head_title" prepend}{if $node->getId()}{$node->getName($locale)}{else}{translate key="title.folder.add"}{/if} | {/block}

{block name="taskbar_panels" append}
    {if $node->getId()}
        {url id="cms.redirect.edit" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId()] var="urlPublish"}
        {url id="cms.redirect.edit" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()] var="urlLocales"}
    {else}
        {url id="cms.redirect.add" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%"] var="urlPublish"}
        {url id="cms.redirect.add" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $site->getRevision()] var="urlLocales"}
    {/if}

    {if !$site->isAutoPublish()}
        {include file="helper/cms/taskbar"}

        {call taskbarPanelPublish url=$urlPublish revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {call taskbarPanelLocales url=$urlLocales locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    {$title = $site->getName($locale)}
    {if $node->getId()}
        {$subtitle = "title.redirect.edit"|translate}
        {$breadcrumbLabel = "label.node.action.edit"|translate}
        {$action = "edit"}
    {else}
        {$subtitle = "title.redirect.add"|translate}
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

    <form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form">
        {call formRow form=$form row="name"}
        {call formRow form=$form row="route"}

        <div class="form-group row-redirect-type clearfix">
            <label>{translate key="label.redirect.to"}</label>
            <div class="form-check">
                <label class="form-check-label">
                    {call formWidget form=$form row="redirect-type" part="node"}
                    {translate key="label.node"}
                </label>

                {call formWidget form=$form row="redirect-node"}
            </div>

            <div class="form-check">
                <label class="form-check-label">
                    {call formWidget form=$form row="redirect-type" part="url"}
                    {translate key="label.url"}
                </label>

                {call formWidget form=$form row="redirect-url"}
            </div>
        </div>
        {call formRows form=$form}
        {call formActions referer=$referer}
    </form>
{/block}
