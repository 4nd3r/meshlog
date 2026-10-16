<?php
$start = microtime(true);
require_once "../../../lib/meshlog.class.php";
require_once "../../../config.php";
include "../utils.php";

$meshlog = new MeshLog($config['db']);
$err = $meshlog->getError();

if ($err) {
    $results = array('error' => $err);  
} else {
    $results = $meshlog->getContactsQuick(array(
        'offset' => getParam('offset', 0),
        'count' => getParam('count', DEFAULT_CONTACTS_COUNT),
        'after_ms' => getParam('after_ms', 0),
        'before_ms' => getParam('before_ms', 0),
        'telemetry' => getParam('telemetry', getParam('include_telemetry', 0)),
        // viewport loading: only contacts whose latest advert position falls
        // inside the map bounds, plus optional server-side search
        'min_lat' => getParam('min_lat', null),
        'max_lat' => getParam('max_lat', null),
        'min_lon' => getParam('min_lon', null),
        'max_lon' => getParam('max_lon', null),
        'search'  => getParam('search', ''),
    ));
}

$results['time'] = microtime(true) - $start;

header('Content-Type: application/json; charset=utf-8');
echo json_encode($results);

?>
