<?php

if (!empty($_GET['what'])) {
  $repo = htmlspecialchars($_GET['what']);
  $cmd = 'curl --request POST --header "Content-Length: 0" --header "X-Requested-With: XMLHttpRequest" http://satis.bostondrupal.com/control-panel/build-private?what=' . $repo;
}
else {
  $cmd = 'curl --request POST --header "Content-Length: 0" --header "X-Requested-With: XMLHttpRequest" http://satis.bostondrupal.com/control-panel/build-private';
}

shell_exec($cmd);
