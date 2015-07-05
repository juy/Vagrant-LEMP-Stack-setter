<?php

// Settings for SQL
$username = 'root';
$password = 'secret';
$database = 'homestead';


/**
 * MySQL
 */

$mysql_running = false;
$mysql_version = false;

try {
    $dbh = new PDO('mysql:host=localhost;dbname='.$database, $username, $password);
    $mysql_running = true;
    $mysql_version = $dbh->query("SHOW VARIABLES LIKE '%version%'")->fetchObject()->Value; // 5.6.24
}
catch(PDOException $e) {
    //echo $e->getMessage();
}


/**
 * PostgreSQL
 */

$pgsql_running = false;
$pgsql_version = false;

try {
    $dbh = new PDO(
        'pgsql:host=localhost;port=5432;dbname='.$database.';user='.$username.';password='.$password
    );

    $pgsql_running = true;
    $result = $dbh->query("SELECT version()")->fetchObject()->version;
    $pgsql_version_arr = explode(' ', $result);
    $pgsql_version = $pgsql_version_arr[1];  // 9.4.4
}
catch(PDOException $e) {
    //echo $e->getMessage();
}


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


/**
 * Redis
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
        var_dump($redis_info);
		$redis_version = $redis_info['redis_version'];
        var_dump($redis_version);
	}
	$redis->close();
}
catch (RedisException $e) {
    //echo $e->getMessage();
    // Redis server went away
}


/**
 * PHP
 */

$php_version = phpversion();
$php_version = explode('-', $php_version);
$php_version = $php_version[0];

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
					<td><?php echo $php_version; ?></td>
				</tr>
				<tr>
					<td>MySQL running</td>
					<td>
                        <i class="fa fa-<?php echo ($mysql_running ? 'check' : 'times'); ?>"></i>
                        <?php echo ($mysql_running ? $mysql_version : ''); ?>
                    </td>
				</tr>
                <tr>
                    <td>PostgreSQL running</td>
                    <td>
                        <i class="fa fa-<?php echo ($pgsql_running ? 'check' : 'times'); ?>"></i>
                        <?php echo ($pgsql_running ? $pgsql_version : ''); ?>
                    </td>
                </tr>
				<tr>
					<td>Memcached running</td>
					<td>
                        <i class="fa fa-<?php echo ($memcached_running ? 'check' : 'times'); ?>"></i>
                        <?php echo ($memcached_version ? $memcached_version : ''); ?>
                    </td>
				</tr>
				<tr>
					<td>Redis running</td>
					<td>
                        <i class="fa fa-<?php echo ($redis_running ? 'check' : 'times'); ?>"></i>
                        <?php echo ($redis_version ? $redis_version : ''); ?>
                    </td>
				</tr>
			</table>

			<h3>PHP Modules</h3>

            <table class="table table-striped table-condensed">
                <tr>
                    <td><strong>OpenSSL</strong></td>
                    <td><i class="fa fa-<?php echo (extension_loaded('openssl') ? 'check' : 'times'); ?>"></i></td>
                </tr>
                <tr>
                    <td><strong>PDO</strong></td>
                    <td><i class="fa fa-<?php echo (extension_loaded('PDO') ? 'check' : 'times'); ?>"></i></td>
                </tr>
                <tr>
                    <td><strong>mbstring</strong></td>
                    <td><i class="fa fa-<?php echo (extension_loaded('mbstring') ? 'check' : 'times'); ?>"></i></td>
                </tr>
                <tr>
                    <td><strong>tokenizer</strong></td>
                    <td><i class="fa fa-<?php echo (extension_loaded('tokenizer') ? 'check' : 'times'); ?>"></i></td>
                </tr>

				<tr>
					<td>CURL</td>
					<td><i class="fa fa-<?php echo (extension_loaded('curl') ? 'check' : 'times'); ?>"></i></td>
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
						<em>Note: External access is enabled! Just use <strong>127.0.0.1:33060</strong> as host.</em>
					</td>
				</tr>
			</table>

            <h3>PostgreSQL credentials</h3>
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
                        <em>Note: External access is enabled! Just use <strong>127.0.0.1:54320</strong> as host.</em>
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
