{extends file="cms/backend/index"}

{block name="head_title" prepend}{$node->getName($locale)} | {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="helper/cms/taskbar"}

        {url id="cms.node.content.region" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId(), "region" => $region] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.content.region" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    {include "helper/cms/titlebar"
        node=$node
        subtitle="title.node.layout"|translate
        breadcrumbUrl=$app.url.request
        breadcrumbLabel="label.node.action.content"|translate
        action="content"
    }
{/block}

{block name="content_body" append}
    {include file="helper/cms/content"}
    {foreach $layouts as $layout}
        {include file=$layout->getBackendResource() inline}
    {/foreach}

    {include file="helper/form.prototype"}
    {if count($form->getRow('region')->getWidget()->getOptions()) > 1}
    <form id="{$form->getId()}" action="{url id="cms.node.content" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()]}" method="POST" class="form-inline" role="form">
        <p>{translate key="label.region.select"} {call formWidget form=$form row="region"}</p>
    </form>
    {/if}

    <div class="section-container">
        <div class="loading">
            <span class="fa fa-spinner fa-pulse fa-2x"></span>
        </div>

        {isGranted permission="cms.region.`$node->getTheme()`.`$region`.section.manage" var="allowSectionManage"}{/isGranted}

        {if $allowSectionManage}
        <p>
            <button class="btn btn-secondary section-add">
                <span class="fa fa-plus"></span>
                {translate key="button.section.add"}
            </button>
        </p>
        {/if}

        <div class="sections"
             data-url="{$baseAction}"
             data-label-success-order="{"success.content.ordered"|translate|escape}"
             data-label-success-section-add="{"success.section.added"|translate|escape}"
             data-label-success-section-delete="{"success.section.deleted"|translate|escape}"
             data-label-success-section-save="{"success.section.saved"|translate|escape}"
             data-label-success-widget-add="{"success.widget.added"|translate|escape}"
             data-label-success-widget-save="{"success.widget.saved"|translate|escape}"
             data-label-success-widget-delete="{"success.widget.deleted"|translate|escape}"
             data-label-error-order="{"error.sections.ordered"|translate|escape}"
             data-label-error-section-add="{"error.section.added"|translate|escape}"
             data-label-error-section-delete="{"error.section.deleted"|translate|escape}"
             data-label-error-section-save="{"error.section.saved"|translate|escape}"
             data-label-error-widget-add="{"error.widget.added"|translate|escape}"
             data-label-error-widget-save="{"error.widget.saved"|translate|escape}"
             data-label-error-widget-delete="{"error.widget.deleted"|translate|escape}"
                      >
    {foreach $sections as $section => $layout}
        {if $layout}
            {call sectionPanel site=$site node=$node section=$section layouts=$layouts layout=$layout widgets=$regionWidgets[$section] inheritedWidgets=$inheritedWidgets[$section] actions=$actions}
        {/if}
    {/foreach}
        </div>

        {if $allowSectionManage}
        <p>
            <button class="btn btn-secondary section-add">
                <span class="fa fa-plus"></span>
                {translate key="button.section.add"}
            </button>
        </p>
        {/if}
    </div>

    <div class="modal modal-widget-add fade" id="modalWidgetAdd" tabindex="-1" role="dialog" aria-labelledby="modalWidgetAddLabel" aria-hidden="true">
        <div class="modal-dialog modal-full">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">{translate key="button.close"}</span></button>
                    <h4 class="modal-title" id="modalWidgetAddLabel">{translate key="button.widget.add"}</h4>
                </div>
                <div class="modal-body">
                <form action="#" class="form-widget-add">
                    <input name="section" type="hidden" />
                    <input name="block" type="hidden" />

                    <p>{translate key="label.widgets.available.description"}</p>

                    <div class="form-group">
                        <input type="text" class="form-control" id="form-widget-filter" placeholder="{"label.widget.filter"|translate|escape}" autocomplete="off" />
                    </div>

                    <div class="row">
                    {foreach $availableWidgets as $name => $widget}
                        {isGranted permission="cms.widget.`$name`.manage"}
                    <div class="col-sm-6 col-md-4 widget" data-widget="{$name}">
                        <div class="radio">
                            <label>
                                <input name="widget" value="{$name}" type="radio">
                                <img src="{image src=$widget->getIcon() default="img/widget.png"}" class="handle" />
                                {translate key="widget.`$name`"}
                            </label>
                        </div>
                    </div>
                        {/isGranted}
                   {/foreach}
                    </div>
                </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-link" data-dismiss="modal">{translate key="button.cancel"}</button>
                    <button type="button" class="btn btn-primary widget-add-submit disabled">{translate key="button.add"}</button>
                    <button type="button" class="btn btn-primary widget-add-submit-close disabled">{translate key="button.add.close"}</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal modal-action fade" id="modalAction" tabindex="-1" role="dialog" aria-labelledby="modalActionLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span> <span class="sr-only">{'button.close'|translate}</span></button>
                    <h4 class="modal-title" id="modalActionLabel"></h4>
                </div>
                <div class="modal-body"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-link" data-dismiss="modal">{'button.cancel'|translate}</button>
                    <button type="button" class="btn btn-primary modal-action-submit">{'button.save'|translate}</button>
                </div>
            </div>
        </div>
    </div>
{/block}

{block name="scripts" append}
    {script src="bootstrap4/js/modules/cms-content.js"}
{/block}
