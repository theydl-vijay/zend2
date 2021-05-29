<?php
error_reporting(E_ALL & ~E_NOTICE & ~E_DEPRECATED & ~E_STRICT);
ini_set('display_errors',"on");
// ini_set('session.save_path','/tmp');

// Define path to application directory
defined('APPLICATION_PATH')
    || define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/../application'));

// Define application environment
defined('APPLICATION_ENV')
    || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production'));

define('CORE_PATH', realpath(APPLICATION_PATH . '/../../Core/WC'));

define('APPLICATION_HOST', str_replace(array(".",":"), "", $_SERVER["HTTP_HOST"]));

set_include_path(implode(PATH_SEPARATOR, array(
    realpath(APPLICATION_PATH . '/../../Core'),
    realpath(APPLICATION_PATH . '/../../'),
    realpath(APPLICATION_PATH . '/plugins'),
    get_include_path(),
)));
date_default_timezone_set('America/Chicago');
/** Zend_Application */
require_once realpath(dirname(__FILE__) . '/../../Core/Zend/Application.php');

// Create application, bootstrap, and run
$application = new Zend_Application(
    APPLICATION_ENV,
    APPLICATION_PATH . '/configs/application.ini'
);

$autoloader = Zend_Loader_Autoloader::getInstance();
$autoloader->registerNamespace('Core_WC_');
$autoloader->registerNamespace('Plugin_');


// Zend_Controller_Front::getInstance()->registerPlugin(new Plugin_ACL());
//Zend_Controller_Front::getInstance()->registerPlugin(new Plugin_Modal());

$core_config = new Zend_Config_Ini(CORE_PATH ."/configs/application.ini", APPLICATION_HOST);
$app_config = new Zend_Config_Ini(APPLICATION_PATH . "/configs/application.ini", APPLICATION_HOST);
$registry = Zend_Registry::getInstance();
$registry->core_config	= $core_config;
$registry->app_config	= $app_config;

$db = Zend_Db::factory($app_config->database->db);
Zend_Db_Table_Abstract::setDefaultAdapter($db);

$application->bootstrap()
            ->run();
