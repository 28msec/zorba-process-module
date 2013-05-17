import module namespace proc = "http://www.zorba-xquery.com/modules/process"; 

let $result := proc:exec("echo",("hello","world"))
return $result("stdout") eq "hello world
"
