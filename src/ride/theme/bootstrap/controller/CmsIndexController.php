<?php

namespace ride\theme\bootstrap\controller;

use ride\web\base\controller\AbstractController;

class CmsController extends AbstractController {

    public function themesAction() {
        $this->setTemplateView('base/dashboard/themes');
    }

}
