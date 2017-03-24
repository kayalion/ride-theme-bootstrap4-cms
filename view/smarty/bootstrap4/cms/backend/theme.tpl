{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.themes"} | {/block}

{block name="content_title" append}
    <nav class="breadcrumb">
        <a class="breadcrumb-item" href="{url id="admin"}">
            {translate key="title.admin.home"}
        </a>
        <a class="breadcrumb-item" href="{url id="cms.theme"}">
            {translate key="title.themes"}
        </a>
    </nav>

    <div class="page-header mb-2">
        <h1>
            {translate key="title.themes"}
        </h1>
    </div>
{/block}

{block name="content_body" append}
    <p>
        <a href="{url id="cms.theme.add"}" class="btn btn-secondary">
            {translate key="button.theme.add"}
        </a>
    </p>
    <ul>
    {foreach $themes as $theme}
        <li>
            <a href="{url id="cms.theme.edit" parameters=["theme" => $theme->getName()]}">
                {$theme->getDisplayName()}
            </a>
        </li>
    {/foreach}
    </ul>
{/block}
