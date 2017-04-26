<form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
    {if $form->hasRow("existing")}
    <div class="row-existing clearfix d-none" data-url-text="{url id="api.orm.detail" parameters=["model" => "Text", "id" => "%id%"]}">
        <p>{translate key="label.text.existing.select"}</p>
        {call formWidget form=$form row="existing"}
        {call formWidget form=$form row="existing-new"}
        <div class="preview"></div>
    </div>
    {/if}

    <ul class="nav nav-tabs mb-2">
        <li class="nav-item"><a class="nav-link active" href="#text" data-toggle="tab">{translate key="title.text"}</a></li>
        <li class="nav-item"><a class="nav-link" href="#cta" data-toggle="tab">{translate key="title.cta"}</a></li>
        <li class="nav-item"><a class="nav-link" href="#view" data-toggle="tab">{translate key="title.view"}</a></li>
    </ul>

    <div class="tab-content">
        <div id="view" class="tab-pane">
            {call formRow form=$form row="template"}
        </div>
        <div id="cta" class="tab-pane">
            {call formRow form=$form row="cta"}
        </div>
        <div id="text" class="tab-pane active">
            {call formRow form=$form row="body"}

            {if $form->hasRow("existing")}
            <p class="text-right">
                <a href="#" id="btn-text-reuse">{translate key="button.text.existing"}</a>
            </p>
            {/if}

            {call formRows form=$form}
        </div>
    </div>

    {url var="referer" id="cms.node.content.region" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region]}
    {call formActions referer=$referer}
</form>
