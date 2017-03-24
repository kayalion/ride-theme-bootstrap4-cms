{include file="helper/form.prototype"}

<form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
    <ul class="nav nav-tabs mb-2">
        <li class="nav-item"><a class="nav-link active" href="#general" data-toggle="tab">{translate key="widget.contact"}</a></li>
        <li class="nav-item"><a class="nav-link" href="#view" data-toggle="tab">{translate key="title.view"}</a></li>
    </ul>

    <div class="tab-content">
        <div id="view" class="tab-pane">
            {call formRow form=$form row="template"}
        </div>
        <div id="general" class="tab-pane active">
            {call formRows form=$form}
        </div>
    </div>

    {url var="referer" id="cms.node.content.region" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region]}
    {call formActions referer=$referer}
</form>
