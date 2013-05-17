import module namespace proc = "http://www.zorba-xquery.com/modules/process"; 

let $result := proc:exec("printenv",("TEST_ENV_VAR"),"TEST_ENV_VAR=foo")
return $result("stdout") eq "foo
"
