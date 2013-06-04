import module namespace proc = "http://zorba.io/modules/process";

let $result := proc:exec("echo",("hello","world"))
return $result("stdout") eq "hello world
"
