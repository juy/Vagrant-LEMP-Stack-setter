<?php

/**
 * MySQL
 * TODO: Use PDO ?
 */

$mysqli = @new mysqli('localhost', 'root', 'secret');

$mysql_running = false;
$mysql_version = false;

if (!mysqli_connect_errno())
{
	$mysql_running = true;
	$mysql_version = $mysqli->server_info;
}
$mysqli->close();


/**
 * PostgreSQL
 */

// TODO: under construction
//$dbconn = pg_connect('host=localhost port=5432 user=root password=secret');
//$v = pg_version($dbconn);
//echo $v['client'];

//$pgsql = new PDO("pgsql:host=localhost;dbname=mydatabase");
//$pgsql = new PDO('pgsql:host=localhost;dbname=test','root','secret');


/**
 * Redis
 * https://github.com/phpredis/phpredis
 */

$redis = new Redis();

$redis_running = false;
$redis_version = false;

try {
	$redis->connect('127.0.0.1', 6379);

	if ($redis->ping() == '+PONG')
	{
		$redis_running = true;

		$redis_info = $redis->info();
		$redis_version = $redis_info['redis_version'];
	}
	$redis->close();
} catch (RedisException $e) {}


/**
 * Memcached
 */

$m = new Memcached();

$memcached_running = false;
$memcached_version = false;

if ($m->addServer('localhost', 11211))
{
	$memcached_running = true;
	$memcached_version = $m->getVersion();
	$memcached_version = current($memcached_version);
}


?>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Vagrant LAMP stack</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.no-icons.min.css" rel="stylesheet">
	<link href="//netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.css" rel="stylesheet">
	<style type="text/css">
	html, body { height: 100%; }
	#wrap {
		min-height: 100%; height: auto !important; height: 100%;
		margin: 0 auto -60px;
	}
	#push, #footer { height: 60px; }
	#footer { background-color: #f5f5f5; }
	@media (max-width: 767px) {
		#footer { margin-left: -20px; margin-right: -20px; padding-left: 20px; padding-right: 20px; }
	}
	.container { width: auto; max-width: 680px; }
	.container .credit { margin: 20px 0; }
	.page-header i { float: left; margin-top: -5px; margin-right: 12px; }
	table td:first-child { width: 300px; }
    </style>
</head>
<body>
	<div id="wrap">
		<div class="container">
			<div class="page-header">
				<i class="fa fa-lightbulb-o fa-4x"></i>
				<h1>It works!</h1>
			</div>
			<p class="lead">Here's some additional information you might need.</p>

			<h3>Installed software</h3>
			<table class="table table-striped table-condensed">
				<tr>
					<td>PHP Version</td>
					<td><?php echo phpversion(); ?></td>
				</tr>
				<tr>
					<td>MySQL running</td>
					<td><i class="fa fa-<?php echo ($mysql_running ? 'check' : 'times'); ?>"></i></td>
				</tr>
				<tr>
					<td>MySQL version</td>
					<td><?php echo ($mysql_running ? $mysql_version : 'N/A'); ?></td>
				</tr>
				<tr>
					<td>Memcached running</td>
					<td><i class="fa fa-<?php echo ($memcached_running ? 'check' : 'times'); ?>"></i></td>
				</tr>
				<tr>
					<td>Memcached version</td>
					<td><?php echo ($memcached_version ? $memcached_version : 'N/A'); ?></td>
				</tr>
				<tr>
					<td>Redis running</td>
					<td><i class="fa fa-<?php echo ($redis_running ? 'check' : 'times'); ?>"></i></td>
				</tr>
				<tr>
					<td>Redis version</td>
					<td><?php echo ($redis_version ? $redis_version : 'N/A'); ?></td>
				</tr>
			</table>

			<h3>PHP Modules</h3>
			<table class="table table-striped table-condensed">
				<tr>
					<td>MySQL</td>
					<td><i class="fa fa-<?php echo (class_exists('mysqli') ? 'check' : 'times'); ?>"></i></td>
				</tr>
				<tr>
					<td>CURL</td>
					<td><i class="fa fa-<?php echo (function_exists('curl_init') ? 'check' : 'times'); ?>"></i></td>
				</tr>
				<tr>
					<td>mcrypt</td>
					<td><i class="fa fa-<?php echo (function_exists('mcrypt_encrypt') ? 'check' : 'times'); ?>"></i></td>
				</tr>
				<tr>
					<td>gd</td>
					<td><i class="fa fa-<?php echo (function_exists('imagecreate') ? 'check' : 'times'); ?>"></i></td>
				</tr>
			</table>

			<h3>MySQL credentials</h3>
			<table class="table table-striped table-condensed">
				<tr>
					<td>Hostname</td>
					<td>localhost</td>
				</tr>
				<tr>
					<td>Username</td>
					<td>root</td>
				</tr>
				<tr>
					<td>Password</td>
					<td>secret</td>
				</tr>
				<tr>
					<td colspan="2">
						<em>Note: External access is enabled! Just use <strong><?php echo $_SERVER['SERVER_ADDR'] ?></strong> as host.</em>
					</td>
				</tr>
			</table>

		</div>
		<div id="push"></div>
	</div>

	<div id="footer">
		<div class="container">
			<p class="muted credit">
				<a href="https://github.com/juy/Vagrant-LEMP-Stack" target="_blank">Vagrant LAMP Stack</a> by
				<a href="http://juysoft.com" traget="_blank">JuySoft</a>.
			</p>
		</div>
	</div>
</body>
</html>
