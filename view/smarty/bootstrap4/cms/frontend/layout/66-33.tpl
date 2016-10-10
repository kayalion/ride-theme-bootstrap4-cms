{function name="layout_66_33" section=null widgets=null}
    <div class="row section section-{$section} section-{$region}-{$section} {$style}">
    {$block = '1'}
        <div class="col-md-8 block block-{$block} block-{$region}-{$section}-{$block}" data-section="{$section}" data-block="{$block}">
    {if isset($widgets[$block])}
        {foreach $widgets[$block] as $widget}
            {$widget}
        {/foreach}
    {/if}
        </div>
    {$block = '2'}
        <div class="col-md-4 block block-{$block} block-{$region}-{$section}-{$block}" data-section="{$section}" data-block="{$block}">
    {if isset($widgets[$block])}
        {foreach $widgets[$block] as $widget}
            {$widget}
        {/foreach}
    {/if}
        </div>
    </div>
{/function}
