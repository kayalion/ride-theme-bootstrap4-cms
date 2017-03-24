{function name="layout_block" section=null region=null block=null style=null}
    <div class="{$style} block block-{$block} block-{$region}-{$section}-{$block}" data-section="{$section}" data-block="{$block}">
    {if isset($widgets[$block])}
        {foreach $widgets[$block] as $widget}
            {$widget}
        {/foreach}
    {/if}
    </div>
{/function}

{foreach $layouts as $layout}
    {include file=$layout->getFrontendResource() inline}
{/foreach}

{function name="region" region=null class=null}
    {if isset($widgets.$region)}
    <div class="{$class}">
        {foreach $regions.$region as $section => $layout}
            {if isset($widgets.$region.$section)}
                {$functionName = "layout-`$layout`"|replace:"-":"_"}
                {$style = $app.cms.node->getSectionStyle($region, $section)}
                {$title = $app.cms.node->getSectionTitle($region, $section, $app.locale)}
                {$isFullWidth = $app.cms.node->isSectionFullWidth($region, $section)}

                <div class="container{if $isFullWidth}-fluid{/if} section {$style}">
                    {if $title}
                        <h2 class="section-title">{$title}</h2>
                    {/if}
                    {call $functionName section=$section widgets=$widgets.$region.$section style=$style}
                </div>
            {/if}
        {/foreach}
    </div>
    {/if}
{/function}
