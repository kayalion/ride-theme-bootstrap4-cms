{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
<fieldset>
    <div class="tabbable">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#tabQuery" data-toggle="tab">{translate key="title.query"}</a></li>
            <li><a href="#tabParameters" data-toggle="tab">{translate key="title.parameters.url"}</a></li>
            <li><a href="#tabMapper" data-toggle="tab">{translate key="title.content.mapper"}</a></li>
            <li><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
        </ul>

        <div class="tab-content">
            <div id="tabQuery" class="tab-pane active">
                {call formRow form=$form row="model"}
                {call formRow form=$form row="include-unlocalized"}

                <h4>{translate key="title.condition"}</h4>
                {call formRow form=$form row="condition"}
                {call formRow form=$form row="filters"}

                <h4>{translate key="title.order"}</h4>
                <div class="form-group clearfix">
                    <label class="col-md-2 control-label">{translate key="label.order.field"}</label>
                    <div class="col-md-10">
                        {call formWidget form=$form row="order-field"}
                        {call formWidget form=$form row="order-direction"}
                        <button class="btn btn-default btn-order-add" id="form-content-properties-order-add">{translate key="button.add"}</button>
                        <span class="help-block">{translate key="label.order.field.description"}</span>
                    </div>
                </div>

                {call formRow form=$form row="order"}

                <h4>{translate key="title.pagination"}</h4>

                {call formRow form=$form row="pagination-enable"}

                {call formRow form=$form row="pagination-rows" class="pagination-attribute"}

                {call formRow form=$form row="pagination-offset" class="pagination-attribute"}
            </div>

            <div id="tabParameters" class="tab-pane">
                <p>{translate key="label.parameters.description"}</p>
                <div class="control-group">
                    <label class="col-md-2 control-label">{translate key="label.parameters"}</label>
                    <div class="col-md-10">
                        <div class="clearfix">
                            <label class="radio">
                                {call formWidget form=$form row="parameters-type" part="none"}
                                {translate key="label.parameters.none"}
                            </label>
                        </div>
                        <div class="clearfix">
                            <label class="radio">
                                {call formWidget form=$form row="parameters-type" part="numeric"}
                                {translate key="label.parameters.numeric"}
                            </label>
                            <span class="help-block">{translate key="label.parameters.numeric.description"}</span>
                            {call formRow form=$form row="parameters-number" class="parameters-enable parameters-numeric"}
                        </div>
                        <div class="clearfix">
                            <label class="radio">
                                {call formWidget form=$form row="parameters-type" part="named"}
                                {translate key="label.parameters.named"}
                            </label>
                            <span class="help-block">{translate key="label.parameters.named.description"}</span>
                            {call formRow form=$form row="parameters-name" class="parameters-enable parameters-named"}
                        </div>
                    </div>
                </div>
                {call formRow form=$form row="parameters-none"}
            </div>

            <div id="tabMapper" class="tab-pane">
                {call formRow form=$form row="content-mapper"}
            </div>

            <div id="tabView" class="tab-pane">
                {call formRow form=$form row="template"}
                {call formRow form=$form row="view-processor"}
                {call formRow form=$form row="title"}
                {call formRow form=$form row="empty-result-view"}
                {call formRow form=$form row="empty-result-message"}

                <h4 class="pagination-attribute">{translate key="title.pagination"}</h4>

                {call formRow form=$form row="pagination-show" class="pagination-attribute"}
                {call formRow form=$form row="pagination-ajax" class="pagination-attribute pagination-ajax"}
                {call formRow form=$form row="more-show" class="pagination-attribute"}
                {call formRow form=$form row="more-label" class="pagination-attribute more-attribute"}
                {call formRow form=$form row="more-node" class="pagination-attribute more-attribute"}

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
