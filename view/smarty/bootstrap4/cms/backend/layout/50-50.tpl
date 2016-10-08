{function name="layout_50_50" site=null node=null section=null widgets=null inheritedWidgets=null actions=null}
<div class="row">
    {$class="col-md-6"}

    {$block = '1'}
    {call layoutBlock site=$site node=$node section=$section block=$block class=$class widgets=$widgets inheritedWidgets=$inheritedWidgets actions=$actions}

    {$block = '2'}
    {call layoutBlock site=$site node=$node section=$section block=$block class=$class widgets=$widgets inheritedWidgets=$inheritedWidgets actions=$actions}
</div>
{/function}
