<?php

require 'vendor/autoload.php';

$redis = new Predis\Client([
    'scheme' => 'tcp',
    'host'   => '127.0.0.1',
    'port'   => 6379,
]);

$key = 'key';
$lockTime = 10; // время блокировки

// в случае повторного запуска выводим сообщение и убиваем скрипт
if ($redis->exists($key)) {
    die("скрипт уже выполняется\n");
}

// блокировка
$redis->set($key, 'value', 'EX', $lockTime);

echo "скрипт запущен\n";
sleep(5);

// удаляем ключ, чтобы если что запустить скрипт повторно
$redis->del($key);
echo "скрипт завершен\n";