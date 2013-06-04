import module namespace proc = "http://zorba.io/modules/process";

let $result := proc:exec("echo","{}[]()()''~!@#$%^&amp;*_-+|<>/?,.")
return $result("stdout") eq "{}[]()()''~!@#$%^&amp;*_-+|<>/?,.
"
