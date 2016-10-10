{function name="layout_100_no_grid" section=null widgets=null}
    {$block = '1'}
    {if isset($widgets[$block])}
        {foreach $widgets[$block] as $widget}
            {$widget}
        {/foreach}
    {/if}
{/function}
