import module namespace proc = "http://www.zorba-xquery.com/modules/process"; 

let $result := proc:exec("echo","{}[]()()''~!@#$%^&amp;*_-+|<>/?,.")
return $result("stdout") eq "{}[]()()''~!@#$%^&amp;*_-+|<>/?,.
"
