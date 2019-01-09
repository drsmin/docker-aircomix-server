<?php
require_once('func.php');

$request_uri = $_SERVER['REQUEST_URI'];
$request_path = parse_url($request_uri, PHP_URL_PATH);
$request_path = urldecode($request_path);
debug("request_path: ".$request_path);

$path = $parent_path.$request_path;
debug("path: ".$path);

if (is_dir($path)) {
    list_dir($path);
} else {
    $path_parts = pathinfo($path);
    $ext = strtolower($path_parts['extension']);
    $type = get_content_type($ext);

    if (is_in_zip($path, $ext)) {
        process_file_in_zip($path, $type);
    } else if (is_in_rar($path,$ext)) {
        process_file_in_rar($path, $type);
    } else {
        if (in_array($ext, $image_ext)) {
            process_image($path, $type);
        } else if ($ext == "zip" || $ext == "cbz") {
            process_zip($path);
        } else if ($ext == "rar" || $ext == "cbr") {
            process_rar($path);
        } else {
            return;
        }
    }
}

