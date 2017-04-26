<div class="message message-danger" role="alert">
    <h3>{$widgetName}#{$widgetId}</h3>
    {foreach $exceptionArray as $exception}
        <p><strong>{$exception.type}{if $exception.message}: {$exception.message}{/if}</strong></p>
        <small><pre>{$exception.trace}</pre></small>
        {if !$exception@last}
        <p>Causes</p>
        {/if}
    {/foreach}
</div>
