{extends file="base/index"}

{block name="head_title" prepend}{if $theme}{translate key="title.theme.edit"} - {$theme->getDisplayName()}{else}{translate key="title.theme.add"}{/if} - {/block}

{block name="content_title" append}
    <nav class="breadcrumb">
        <a class="breadcrumb-item" href="{url id="admin"}">
            {translate key="title.admin.home"}
        </a>
        <a class="breadcrumb-item" href="{url id="cms.theme"}">
            {translate key="title.themes"}
        </a>
        <a class="breadcrumb-item" href="{$app.url.request}">
        {if $theme}
            {$theme->getDisplayName()}
        {else}
            {translate key="title.theme.add"}
        {/if}
        </a>
    </nav>

    <div class="page-header mb-2">
        <h1>
            {translate key="title.themes"}
            <small class="text-muted">
        {if $theme}
            {$theme->getDisplayName()}
        {else}
            {translate key="title.theme.add"}
        {/if}
            </small>
        </h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="helper/form.prototype"}

    <form id="{$form->getId()}" class="form-selectize" action="{$app.url.request}" method="POST" role="form">
        <ul class="nav nav-tabs mb-2">
            <li class="nav-item">
                <a class="nav-link active" href="#general" data-toggle="tab">
                    {translate key="label.general"}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#template" data-toggle="tab">
                    {translate key="label.template"}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#regions" data-toggle="tab">
                    {translate key="label.regions"}
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#layouts" data-toggle="tab">
                    {translate key="label.layouts"}
                </a>
            </li>
        </ul>

        <div class="tab-content">
            <div id="template" class="tab-pane">
                {call formRow form=$form row="engines"}
            </div>
            <div id="regions" class="tab-pane">
                {call formRow form=$form row="regions"}
            </div>
            <div id="layouts" class="tab-pane">
                {call formRow form=$form row="layouts"}
            </div>
            <div id="general" class="tab-pane active">
                {call formRows form=$form}
            </div>
        </div>

        {call formActions referer=$referer}
    </form>
    {if $urlDelete}
        <a href="{$urlDelete}" class="text-danger">{translate key="button.theme.delete"}</a>
    {/if}
{/block}

{block name="styles" append}
    {style src="bootstrap4/css/selectize.css" media="all"}
{/block}

{block name="scripts" append}
    {script src="bootstrap4/js/jquery-ui.js"}
    {script src="bootstrap4/js/selectize.js"}
    {script src="bootstrap4/js/parsley.js"}
    {script src="bootstrap4/js/form.js"}
    {script src="bootstrap4/js/tabs.js"}
{/block}
