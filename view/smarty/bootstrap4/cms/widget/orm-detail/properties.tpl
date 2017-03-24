{include file="helper/form.prototype"}

<form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
<fieldset>
    <div class="tabbable">
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link active" href="#query" data-toggle="tab">{translate key="title.query"}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#parameters" data-toggle="tab">{translate key="title.parameters.url"}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#mapper" data-toggle="tab">{translate key="title.content.mapper"}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#meta" data-toggle="tab">{translate key="title.node.meta"}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#view" data-toggle="tab">{translate key="title.view"}</a>
            </li>
        </ul>

        <div class="tab-content">
            <div id="query" class="tab-pane active">
                {call formRow form=$form row="model"}
                {call formRow form=$form row="field-id"}
                {call formRow form=$form row="include-unlocalized"}
            </div>

            <div id="parameters" class="tab-pane">
                {call formRow form=$form row="parameters-none"}
            </div>

            <div id="mapper" class="tab-pane">
                {call formRow form=$form row="primary"}
            </div>

            <div id="meta" class="tab-pane">
                {call formRow form=$form row="meta-og"}
                {call formRow form=$form row="format-title-og"}
                {call formRow form=$form row="format-teaser-og"}
                {call formRow form=$form row="format-image-og"}
            </div>

            <div id="view" class="tab-pane">
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
