<?php

namespace ride\theme\bootstrap;

use ride\library\cms\theme\Theme;

/**
 * Interface for a template theme
 */
class Bootstrap4CmsTheme extends Bootstrap4Theme implements Theme {

    /**
     * Regions of this theme
     * @var unknown
     */
    protected $regions = array(
        'content' => 'content',
        'header' => 'header',
        'menu' => 'menu',
        'title' => 'title',
        'footer' => 'footer',
    );

    /**
     * Checks if a region exists in this layout
     * @return boolean
     */
    public function hasRegion($region) {
        return isset($this->regions[$region]);
    }

    /**
     * Gets the regions for this theme
     * @return array Array with the region name as key and as value
     */
    public function getRegions() {
        return $this->regions;
    }

    /**
     * Gets the available layouts of this theme
     * @return array Array with the layout name as key and a boolean as value
     */
    public function getLayouts() {
        return array(
            '100-no-grid' => true,
            '100' => true,
            '25-25-25-25' => false,
            '25-50-25' => false,
            '25-58-17' => false,
            '25-75' => false,
            '33-33-33' => true,
            '33-66' => true,
            '50-50' => true,
            '66-33' => true,
            '75-25' => false,
        );
    }

    /**
     * Gets the grid breakpoint classes of this theme
     * @return array Array with the breakpoint class as key and a translation
     * key as value
     */
    public function getGridBreakpoints() {
        return array(
            'xs' => 'breakpoint.xs',
            'sm' => 'breakpoint.sm',
            'md' => 'breakpoint.md',
            'lg' => 'breakpoint.lg',
        );
    }

    /**
     * Gets the default grid breakpoint class of this theme
     * @return string
     */
    public function getDefaultGridBreakpoint() {
        return 'md';
    }

    /**
     * Gets the style classes which are available for sections
     * @return array Array with the style class as key and a translation key as
     * value
     */
    public function getSectionClasses() {
        return array();
    }

    /**
     * Gets the style classes which are available for widgets
     * @param string $element Name of the element
     * @return array Array with the style class as key and a translation key as
     * value
     */
    public function getWidgetClasses($element) {
        switch ($element) {
            case 'container':
                return array(
                    'pull-right' => 'style.bootstrap4.pull-right',
                    'm-x-auto' => 'style.bootstrap4.m-x-auto',
                );
            case 'menu':
                return array(
                    'nav-inline' => 'style.bootstrap4.nav-inline',
                    'nav-tabs' => 'style.bootstrap4.nav-tabs',
                    'nav-pills' => 'style.bootstrap4.nav-pills',
                    'nav-pills nav-stacked' => 'style.bootstrap4.nav-stacked-pills',
                );
            default:
                return array();
        }
    }

}
