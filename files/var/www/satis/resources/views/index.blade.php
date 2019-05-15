<?php
/**
 * @var string $nodeServer
 * @var string $webpackDevServer
 * @var string $satis
 */
?>

        <!DOCTYPE html>
<html>
<head>
    <title>Satis Control Panel</title>

    <link rel="stylesheet" href="/control-panel/css/app.css" type="text/css" media="screen" />

    <script src="/control-panel/js/jquery.min.js"></script>
    <script src="/control-panel/js/bootstrap.min.js"></script>

    <script src="{!! $nodeServer !!}/socket.io/socket.io.js"></script>

    <script type="text/javascript">
      var Satis = {!! $satis !!};
    </script>
</head>
<body>
<div class="container"></div>

@if (app()->isLocal())
    <script src="/control-panel/js/webpack-dev-server.js"></script>
    <script src="/control-panel/js/bundle.js"></script>
@else
    <script src="/control-panel/js/bundle.js"></script>
@endif
</body>
</html>
