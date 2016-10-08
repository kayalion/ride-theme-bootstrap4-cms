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

}
