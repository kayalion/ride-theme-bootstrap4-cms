{*
    Renders a section header
*}

{function name="sectionPanel" site=null node=null section=null layouts=null layout=null widgets=null inheritedWidgets=null actions=null}
<div class="section panel panel-default card mb-3" data-section="{$section}">
    <div class="card-header">
        {call sectionHeader layouts=$layouts layout=$layout}
    </div>
    <div class="card-block">
        {call sectionContent site=$site node=$node section=$section layout=$layout widgets=$widgets inheritedWidgets=$inheritedWidgets actions=$actions}
    </div>
</div>
{/function}

{function name="sectionHeader" layouts=null layout=null}
{$sectionTitle = $node->getSectionTitle($region, $section, $locale)}
{$sectionGridBreakpoint = $node->getSectionGridBreakpoint($region, $section)}
{$isFullWidth = $node->isSectionFullWidth($region, $section)}
<div class="row">
    <div class="col-md-8">
        <span class="section-handle fa fa-arrows mr-3"></span>
        <span class="section-layouts">
        {foreach $layouts as $l}
            {$layoutName = $l->getName()}
            <a href="#" class="layout layout-{$layoutName}{if $layoutName == $layout} layout-active{/if}" title="{"layout.`$layoutName`"|translate|escape}" data-layout="{$layoutName}">
                <img src="{image src="bootstrap4/img/cms/layout/`$layoutName`.png" transformation="resize" width=30 height=30}" />
            </a>
        {/foreach}
        </span>
    </div>
    <div class="col-md-4">
        <div class="btn-group pull-right section-actions">
            <a class="btn btn-secondary btn-sm btn-modal section-properties" data-action="section-properties" href="{url id="cms.node.content.section.properties" parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section]}?referer={$app.url.request|urlencode}" title="{translate key="label.widget.action.properties"}">
                <span class="fa fa-cog{if $sectionTitle || $isFullWidth || $sectionGridBreakpoint} text-primary{/if}"></span>
            </a>
            {isGranted permission="cms.region.`$node->getTheme()`.`$region`.section.style"}
            <a class="btn btn-secondary btn-sm btn-modal section-style" data-action="section-style" href="{url id="cms.node.content.section.style" parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section]}?referer={$app.url.request|urlencode}" title="{translate key="label.widget.action.style"}">
                <span class="fa fa-paint-brush{if $node->getSectionStyle($region, $section)} text-primary{/if}"></span>
            </a>
            {/isGranted}
            {isGranted permission="cms.region.`$node->getTheme()`.`$region`.section.manage"}
            <a class="btn btn-secondary btn-sm section-delete" href="#" data-confirm="{"label.confirm.section.delete"|translate|escape}" title="{translate key="button.delete"}">
                <span class="fa fa-remove"></span>
            </a>
            {/isGranted}
        </div>
    </div>
</div>
<div class="section-title">
{if $sectionTitle}
    <a class="btn-modal section-properties" data-action="section-properties" href="{url id="cms.node.content.section.properties" parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section]}?referer={$app.url.request|urlencode}" title="{translate key="label.widget.action.properties"}">
        {$sectionTitle}
    </a>
{/if}
</div>
{/function}

{function name="sectionContent" site=null node=null section=null layout=null widgets=null inheritedWidgets=null actions=null}
<div class="section-content">
    {$functionName = "layout-`$layout`"|replace:"-":"_"}
    {call $functionName site=$site node=$node section=$section widgets=$widgets inheritedWidgets=$inheritedWidgets actions=$actions}
</div>
{/function}

{function name="layoutBlock" site=null node=null section=null block=null class=null widgets=null inheritedWidgets=null actions=null}
<div class="{$class} block" id="block-{$section}-{$block}" data-section="{$section}" data-block="{$block}">
    <div class="block-content">
{if isset($widgets[$block])}
    {$blockInheritedWidgets = []}
    {if isset($inheritedWidgets[$block])}
        {$blockInheritedWidgets = $inheritedWidgets[$block]}
    {/if}

    {foreach $widgets[$block] as $widgetId => $widget}
        {call widgetPanel site=$site node=$node widget=$widget widgetId=$widgetId inheritedWidgets=$blockInheritedWidgets actions=$actions}
    {/foreach}
{/if}
    </div>
    <div class="block-actions">
        <button class="btn btn-secondary btn-block widget-add">
            <span class="fa fa-plus"></span>
            {translate key="button.widget.add"}
        </button>
    </div>
</div>
{/function}

{function name="widgetPanel" site=null node=null widget=null widgetId=null inheritedWidgets=$inheritedWidgets actions=$actions}
    {$widgetName = $widget->getName()}
    {$widgetTitle = "widget.`$widgetName`"|translate}
    {$widgetProperties = $widget->getProperties()}
    {$widgetActions = []}
    {$widgetVisibilityAction = null}
    {$widgetDeleteAction = null}

    {foreach $actions as $actionName => $action}
        {if $action->isAvailableForWidget($node, $widget)}
            {url var="actionUrl" id=$action->getRoute() parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section, "block" => $block, "widget" => $widgetId]}

            {isGranted url=$actionUrl permission="cms.widget.`$widgetName`.`$actionName`" strategy="AND" var="isWidgetActionAllowed"}{/isGranted}
            {if $isWidgetActionAllowed}
                {$widgetActions[$actionName] = $actionUrl}
            {/if}
        {/if}
    {/foreach}

    {if isset($widgetActions.visibility)}
        {$widgetVisibilityAction = $widgetActions.visibility}
    {/if}

    {url var="actionUrl" id="cms.node.content.widget.delete" parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section, "block" => $block, "widget" => $widgetId]}
    {isGranted url=$actionUrl permission="cms.widget.`$widgetName`.delete" strategy="AND" var="isWidgetActionAllowed"}{/isGranted}
    {if $isWidgetActionAllowed}
        {$widgetDeleteAction = $actionUrl}
    {/if}

<div class="widget{if !$widgetProperties->isPublished() || !$widgetProperties->isAvailableInLocale($locale)} widget-muted{/if} card {if isset($inheritedWidgets[$widgetId])} inherited{/if} card p-l-1 p-t-1 p-r-1 p-b-1" data-widget="{$widgetId}">
    <div class="widget-header card-header clearfix">

    {if $widgetActions || $widgetDeleteAction}
    <div class="clearfix">
        <div class="btn-group float-right">
            {if $widgetActions}
            <div class="btn-group">
                <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" id="dropdown{$widgetId}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" title="{translate key="label.widget.action.properties"}">
                    <span class="fa fa-cog"></span>
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdown{$widgetId}">
                {foreach $widgetActions as $actionName => $actionUrl}
                    {if $actionName == 'style'}
                        {continue}
                    {/if}

                    {translate key="label.widget.action.`$actionName`" var="actionLabel"}
                    <a class="dropdown-item{if $actionName == 'cache'} btn-modal{/if}" data-action="widget-{$actionName}"href="{$actionUrl}?referer={$app.url.request|urlencode}" title="{$actionLabel}">
                        {$actionLabel}
                    </a>
                {/foreach}
                </div>
            </div>
            {/if}

            {if isset($widgetActions.style)}
                <a class="btn btn-secondary btn-sm btn-modal widget-style" data-action="widget-style" href="{$widgetActions.style}" title="{translate key="label.widget.action.style"}">
                    {$hasStyles = false}
                    {$widgetStyleOptions = $widget->getWidgetStyleOptions()}
                    {foreach $widgetStyleOptions as $widgetStyleName => $widgetStyleLabel}
                        {if $widgetProperties->getWidgetProperty("style.`$widgetStyleName`")}
                            {$hasStyles = true}

                            {break}
                        {/if}
                    {/foreach}
                    <span class="fa fa-paint-brush{if $hasStyles} text-primary{/if}"></span>
                </a>
            {/if}
            {if $widgetDeleteAction}
                <a class="btn btn-secondary btn-sm widget-delete" href="{$widgetDeleteAction}" data-confirm="{"label.confirm.widget.delete"|translate|escape}" title="{translate key="button.delete"}">
                    <span class="fa fa-remove"></span>
                </a>
            {/if}
        </div>

        <span class="widget-handle fa fa-arrows"></span>
    </div>
    {/if}
        <div class="widget-title text-left">
        {call visibilityIcons class="widget-visibility float-right ml-2" action=$widgetVisibilityAction item=$widgetProperties}

        {if !$widgetActions && !$widgetDeleteAction}
            <span class="widget-handle fa fa-arrows"></span>
        {/if}

            {* <img src="{image src=$widget->getIcon() default="bootstrap4/img/widget.png"}" /> *}
            {if isset($widgetActions.properties) && $widget->getPropertiesCallback()}
                <a class="name" href="{$widgetActions.properties}">
                    {$widgetTitle}
                </a>
            {else}
                <span class="name">{$widgetTitle}</span>
            {/if}
        </div>
    </div>
    {$propertiesPreview = $widget->getPropertiesPreview()}
    {if $propertiesPreview}
    <div class="widget-content">
        {if isset($widgetActions.properties) && $widget->getPropertiesCallback()}
            <a class="properties" href="{$widgetActions.properties}">
                {$propertiesPreview}
            </a>
        {else}
            {$propertiesPreview}
        {/if}
    </div>
    {/if}
</div>
{/function}
