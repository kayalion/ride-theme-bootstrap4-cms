{function name="layout_25_50_25" section=null widgets=null}
    {$breakpoint = $app.cms.node->getSectionGridBreakpoint($region, $section, 'md')}
    <div class="row section section-{$section} section-{$region}-{$section} {$style}">
        {call layout_block region=$region section=$section block="1" style="col-`$breakpoint`-3"}
        {call layout_block region=$region section=$section block="2" style="col-`$breakpoint`-6"}
        {call layout_block region=$region section=$section block="3" style="col-`$breakpoint`-3"}
    </div>
{/function}
