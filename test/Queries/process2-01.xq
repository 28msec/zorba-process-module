import module namespace proc = "http://zorba.io/modules/process";

let $result := proc:exec("echo")
return $result("stdout") eq "
"
