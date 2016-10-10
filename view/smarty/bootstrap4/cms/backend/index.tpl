{extends file="base/index.sidebar"}

{block name="sidebar"}
    {if isset($nodeCreateActions)}
    <div class="btn-group btn-block m-b-1">
        <div class="btn-group">
            <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
                <span class="fa fa-plus"></span>
                {translate key="button.create"}
            </button>
            <div class="dropdown-menu" role="menu">
            {foreach $nodeCreateActions as $nodeTypeName => $nodeActionUrl}
                <a class="dropdown-item" href="{$nodeActionUrl}">
                    {translate key="label.node.type.`$nodeTypeName`"}
                </a>
            {/foreach}
            </div>
        </div>
        {if isset($site)}
        <a class="btn btn-secondary" href="{url id="cms.site.trash" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale]}">
            {translate key="title.trash"}
            <span class="fa fa-trash"></span>
        </a>
        {/if}
    </div>
    {/if}

    <div class="form-group">
        <div class="input-group">
            <span class="input-group-addon" id="basic-addon1">
                <span class="fa fa-search"></span>
            </span>
            <input type="text" class="form-control disabled" id="form-node-filter" placeholder="{"label.node.filter"|translate|escape}" autocomplete="off" />
        </div>
    </div>

    <div class="btn-group">
    <button class="btn btn-secondary btn-sm btn-expand-all">
        <span class="fa fa-plus-square-o"></span>
        {translate key="button.expand.all"}
    </button>
    <button class="btn btn-secondary btn-sm btn-collapse-all">
        <span class="fa fa-minus-square-o"></span>
        {translate key="button.collapse.all"}
    </button>
    </div>

    {if isset($site)}
    <div class="site-tree is-loading"
         data-src="{url id="cms.site.tree" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale]}"
         data-url-toggle-all="{url id="cms.site.collapse" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale]}"
         data-url-toggle-node="{url id="cms.node.collapse" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale, "node" => "%node%"]}"
         data-url-order="{url id="cms.site.order" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale]}"
     >
        <div class="loading">
            <span class="fa fa-spinner fa-pulse"></span>
        </div>
    </div>
    {/if}
{/block}

{block name="styles" append}
    {style src="bootstrap4/css/selectize.css" media="all"}
    {style src="bootstrap4/css/modules/cms.css" media="all"}
{/block}

{block name="scripts" append}
    {script src="bootstrap4/js/jquery-ui.js"}
    {script src="bootstrap4/js/jquery-ui-nested-sortable.js"}
    {script src="bootstrap4/js/jquery-bootstrap-growl.js"}
    {script src="bootstrap4/js/parsley.js"}
    {script src="bootstrap4/js/selectize.js"}
    {script src="bootstrap4/js/form.js"}
    {script src="bootstrap4/js/modules/cms-tree.js"}
{/block}

{block name="scripts_inline" append}
    {if isset($site)}
    <script type="text/javascript">
        $(function() {
            rideCms.tree.initialize(
                $('.site-tree'),
                {$collapsedNodes},
                {if isset($node)}'{$node->getId()}'{else}null{/if}
            );
        });
    </script>
    {/if}
{/block}
