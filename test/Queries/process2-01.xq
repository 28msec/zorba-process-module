import module namespace proc = "http://www.zorba-xquery.com/modules/process"; 

let $result := proc:exec("echo")
return $result("stdout") eq "
"
