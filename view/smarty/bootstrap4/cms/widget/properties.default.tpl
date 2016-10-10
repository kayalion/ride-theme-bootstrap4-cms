{url id="cms.node.content.region" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region] var="referer"}
<form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form">
    {call formRows form=$form}
    {call formActions referer=$referer}
</form>
