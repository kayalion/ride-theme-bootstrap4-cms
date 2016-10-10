{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
<fieldset>
    <div class="tabbable">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#tabQuery" data-toggle="tab">{translate key="title.query"}</a></li>
            <li><a href="#tabParameters" data-toggle="tab">{translate key="title.parameters.url"}</a></li>
            <li><a href="#tabMapper" data-toggle="tab">{translate key="title.content.mapper"}</a></li>
            <li><a href="#tabMeta" data-toggle="tab">{translate key="title.node.meta"}</a></li>
            <li><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
        </ul>

        <div class="tab-content">
            <div id="tabQuery" class="tab-pane active">
                {call formRow form=$form row="model"}
                {call formRow form=$form row="field-id"}
                {call formRow form=$form row="include-unlocalized"}
            </div>

            <div id="tabParameters" class="tab-pane">
                {call formRow form=$form row="parameters-none"}
            </div>

            <div id="tabMapper" class="tab-pane">
                {call formRow form=$form row="primary"}
            </div>

            <div id="tabMeta" class="tab-pane">
                {call formRow form=$form row="meta-og"}
                {call formRow form=$form row="format-title-og"}
                {call formRow form=$form row="format-teaser-og"}
                {call formRow form=$form row="format-image-og"}
            </div>

            <div id="tabView" class="tab-pane">
                {call formRow form=$form row="template"}
                {call formRow form=$form row="view-processor"}
                {call formRow form=$form row="title"}
                {call formRow form=$form row="format-title"}
                {call formRow form=$form row="format-teaser"}
                {call formRow form=$form row="format-image"}
                {call formRow form=$form row="format-date"}
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="col-lg-offset-2 col-lg-10">
            <input type="submit" class="btn btn-default" value="{translate key="button.save"}" />
            <input type="submit" name="cancel" class="btn btn-link" value="{translate key="button.cancel"}" />
        </div>
    </div>
</fieldset>
</form>
