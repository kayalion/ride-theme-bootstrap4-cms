{function name="taskbarPanelPublish" url=null revision=null revisions=null}
    <li class="nav-item btn-group">
        <a href="#" class="nav-link dropdown-toggle" id="taskbarDropdownRevisions" data-toggle="dropdown" aria-haspopup="true">
            {translate key="label.revision"}: <strong>{$revision}</strong>
        </a>
        <div class="dropdown-menu" aria-labelledby="taskbarDropdownRevisions">
        {foreach $revisions as $r}
            <a class="dropdown-item" href="{$url|replace:"%25revision%25":$r}">{$r}</a>
        {/foreach}
        </div>
    </li>
    <li class="nav-item">
        <form action="{url id="cms.node.publish" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale, "node" => $site->getId()]}">
            <button class="btn btn-primary navbar-btn">{translate key="button.publish"}</button>
        </form>
    </li>
{/function}
