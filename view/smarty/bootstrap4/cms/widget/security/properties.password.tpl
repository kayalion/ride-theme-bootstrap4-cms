{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
    <fieldset>
        <div class="tab">
            <div class="tabbable">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tabWidget" data-toggle="tab">{translate key="widget.password"}</a></li>
                    <li><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
                </ul>
            </div>

            <div class="tab-content">
                <div id="tabWidget" class="tab-pane active">
                    {call formRow form=$form row="subject"}
                    {call formRow form=$form row="message"}
                                    </div>

                <div id="tabView" class="tab-pane">
                    {call formRow form=$form row="template_request"}
                    {call formRow form=$form row="template_reset"}
                </div>
            </div>
        </div>

        {call formRows form=$form}

        <div class="form-group">
            <div class="col-lg-12">
                <input id="btn-submit" type="submit" name="action" class="btn btn-default" value="{translate key="button.save"}" />
                <a id="btn-cancel" class="btn" href="{url id="cms.node.content.region" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region]}">{translate key="button.cancel"}</a>
            </div>
        </div>
    </fieldset>
</form>
