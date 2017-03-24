{url id="cms.node.content.region" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region] var="referer"}
<form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form">
    <ul class="nav nav-tabs mb-2">
        <li class="nav-item">
            <a class="nav-link active" href="#title" data-toggle="tab">{translate key="widget.title"}</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#view" data-toggle="tab">{translate key="title.view"}</a>
        </li>
    </ul>

    <div class="tab-content">
        <div id="view" class="tab-pane">
            {call formRow form=$form row="template"}
        </div>
        <div id="title" class="tab-pane active">
            {call formRows form=$form}
        </div>
    </div>

    {call formActions referer=$referer}
</form>


