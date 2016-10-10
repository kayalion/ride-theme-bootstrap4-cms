{* widget: password; action: reset; translation: template.password.reset *}
{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
    <fieldset>
        {call formRow form=$form row="user"}

        <div class="form-group">
            <div class="col-lg-offset-2 col-lg-10">
                <input type="submit" class="btn btn-default" value="{translate key="button.submit"}" />
            </div>
        </div>
    </fieldset>
</form>
