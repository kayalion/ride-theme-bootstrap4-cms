{function name="layout_25_75" site=null node=null section=null widgets=null inheritedWidgets=null actions=null}
<div class="row">
    {$class="col-md-3"}
    {$block = '1'}
    {call layoutBlock site=$site node=$node section=$section block=$block class=$class widgets=$widgets inheritedWidgets=$inheritedWidgets actions=$actions}

    {$class="col-md-9"}
    {$block = '2'}
    {call layoutBlock site=$site node=$node section=$section block=$block class=$class widgets=$widgets inheritedWidgets=$inheritedWidgets actions=$actions}
</div>
{/function}
