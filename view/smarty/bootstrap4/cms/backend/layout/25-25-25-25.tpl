{function name="layout_25_25_25_25" site=null node=null section=null widgets=null inheritedWidgets=null actions=null}
<div class="row">
    {$class="col-md-3"}

    {$block = '1'}
    {call layoutBlock site=$site node=$node section=$section block=$block class=$class inheritedWidgets=$inheritedWidgets actions=$actions}

    {$block = '2'}
    {call layoutBlock site=$site node=$node section=$section block=$block class=$class inheritedWidgets=$inheritedWidgets actions=$actions}

    {$block = '3'}
    {call layoutBlock site=$site node=$node section=$section block=$block class=$class inheritedWidgets=$inheritedWidgets actions=$actions}

    {$block = '4'}
    {call layoutBlock site=$site node=$node section=$section block=$block class=$class inheritedWidgets=$inheritedWidgets actions=$actions}
</div>
{/function}
