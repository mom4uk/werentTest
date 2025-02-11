<?php

// autoload_real.php @generated by Composer

class ComposerAutoloaderInitf15e8ec9651fac93f6cc8ba421682c91
{
    private static $loader;

    public static function loadClassLoader($class)
    {
        if ('Composer\Autoload\ClassLoader' === $class) {
            require __DIR__ . '/ClassLoader.php';
        }
    }

    /**
     * @return \Composer\Autoload\ClassLoader
     */
    public static function getLoader()
    {
        if (null !== self::$loader) {
            return self::$loader;
        }

        require __DIR__ . '/platform_check.php';

        spl_autoload_register(array('ComposerAutoloaderInitf15e8ec9651fac93f6cc8ba421682c91', 'loadClassLoader'), true, true);
        self::$loader = $loader = new \Composer\Autoload\ClassLoader(\dirname(__DIR__));
        spl_autoload_unregister(array('ComposerAutoloaderInitf15e8ec9651fac93f6cc8ba421682c91', 'loadClassLoader'));

        require __DIR__ . '/autoload_static.php';
        call_user_func(\Composer\Autoload\ComposerStaticInitf15e8ec9651fac93f6cc8ba421682c91::getInitializer($loader));

        $loader->register(true);

        return $loader;
    }
}
