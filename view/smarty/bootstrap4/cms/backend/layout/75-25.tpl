{function name="layout_75_25" site=null node=null section=null widgets=null inheritedWidgets=null actions=null}
<div class="row">
    {$class="col-md-3"}
    {$block = '9'}
    {call layoutBlock site=$site node=$node section=$section block=$block class=$class widgets=$widgets inheritedWidgets=$inheritedWidgets actions=$actions}

    {$class="col-md-6"}
    {$block = '3'}
    {call layoutBlock site=$site node=$node section=$section block=$block class=$class widgets=$widgets inheritedWidgets=$inheritedWidgets actions=$actions}
</div>
{/function}
