{extends file="base/index.sidebar"}

{block name="head_title" prepend}{translate key="title.sites"} | {/block}

{block name="content_title" append}
    <nav class="breadcrumb">
        <a class="breadcrumb-item" href="{url id="admin"}">
            {translate key="title.admin.home"}
        </a>
        <a class="breadcrumb-item" href="{url id="cms.site"}">
            {translate key="title.sites"}
        </a>
    </nav>

    <div class="page-header m-b-1">
        <h1>{translate key="title.sites"}</h1>
    </div>
{/block}

{block name="sidebar" append}
    {url var="actionUrl" id="cms.site.add" parameters=["locale" => $locale]}
    {isGranted url=$actionUrl}

    <div class="btn-group">
        <button id="btn-create-actions" type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            {translate key="button.create"} <span class="caret"></span>
        </button>
        <div class="dropdown-menu" aria-labelledby="btn-create-actions">
            <a class="dropdown-item" href="{$actionUrl}" >
                {translate key="label.node.type.site"}
            </a>
        </div>
    </div>
    {/isGranted}
{/block}

{block name="content_body" append}
    <ul>
    {foreach $sites as $site}
        <li><a href="{$site.url}">{$site.name}</a></li>
    {/foreach}
    </ul>
{/block}

{block name="scripts" append}
    {script src="bootstrap4/js/modules/cms-edit.js"}
{/block}
