{* widget: contact action: index; translation: view.contact.compact *}
<div class="widget widget-contact {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {include file="helper/form.prototype"}

    <form action="{$app.url.request}" method="post" role="form">
        <div class="form-group">
            {call formWidget form=$form row="name"}
            {call formWidgetErrors form=$form row="name"}
        </div>
        <div class="form-group">
            {call formWidget form=$form row="email"}
            {call formWidgetErrors form=$form row="email"}
        </div>
        <div class="form-group">
            {call formWidget form=$form row="message"}
            {call formWidgetErrors form=$form row="message"}
        </div>

        {call formRows form=$form}

        <div class="form-group">
            <input type="submit" class="btn btn-primary" value="{translate key="button.submit"}" />
        </div>
    </form>
</div>
