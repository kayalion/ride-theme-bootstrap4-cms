{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
<fieldset>
    <div class="tabbable">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#tabQuery" data-toggle="tab">{translate key="title.query"}</a></li>
            <li><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
        </ul>

        <div class="tab-content">
            <div id="tabQuery" class="tab-pane active">
                {call formRow form=$form row="model"}
                {call formRow form=$form row="entry"}
                {call formRow form=$form row="include-unlocalized"}
            </div>

            <div id="tabView" class="tab-pane">
                {call formRow form=$form row="template"}
                {call formRow form=$form row="view-processor"}
                {call formRow form=$form row="title"}

                <h4>{translate key="title.formats.data"}</h4>

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
