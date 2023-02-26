<?php
require_once('Uthertube.php');
/**
 * Check if id exists and if we got something
 */
$id = isset($_GET['id']) ? $_GET['id'] : null;
if (is_null($id)) {
	header("Location: .");
	die();
}
$json = Uthertube::getVideo($id);
if ($json === false)
{
	header("Location: .");
	die();
}
$vid = json_decode($json);
$title = isset($vid['title']) ? $vid['title'] : 'error';
?><?php
/* Grab some randomness and display it here */
?><!doctype html>
<html>
<head>
	<title><?php echo $title; ?> - uther.tube on Uther3d!</title>
</head>
<body>
</body>
</html>