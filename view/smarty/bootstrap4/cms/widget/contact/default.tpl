{* widget: contact action: index; translation: view.contact.default *}
<div class="widget widget-contact {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {include file="helper/form.prototype"}

    <form action="{$app.url.request}" method="post" role="form">
        {call formRows form=$form}
        {call formActions submit="button.submit"}
    </form>
</div>
{5 / 0}
