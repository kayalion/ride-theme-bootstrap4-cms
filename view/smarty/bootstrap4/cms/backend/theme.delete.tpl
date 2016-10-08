{extends file="base/index"}

{block name="head_title" prepend}{$theme->getDisplayName()} | {/block}

{block name="content_title" append}
    <nav class="breadcrumb">
        <a class="breadcrumb-item" href="{url id="admin"}">
            {translate key="title.admin.home"}
        </a>
        <a class="breadcrumb-item" href="{url id="cms.theme"}">
            {translate key="title.themes"}
        </a>
        <a class="breadcrumb-item" href="{url id="cms.theme.edit" parameters=["theme" => $theme->getName()]}">
            {$theme->getDisplayName()}
        </a>
        <a class="breadcrumb-item" href="{$app.url.request}">
            {translate key="title.theme.delete"}
        </a>
    </nav>

    <div class="page-header m-b-1">
        <h1>
            {$theme->getDisplayName()}
            <small class="text-muted">
                {translate key="title.theme.delete"}
            </small>
        </h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="helper/form.prototype"}

    <form action="{$app.url.request}" method="POST" role="form">
        <div class="form-group">
            <p>{translate key="label.confirm.theme.delete" theme=$theme->getDisplayName()}</p>
        </div>

        {call formActions referer=$referer submit="button.delete"}
    </form>
{/block}
