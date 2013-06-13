import module namespace proc = "http://zorba.io/modules/process";

let $result := proc:exec("printenv",("TEST_ENV_VAR"),"TEST_ENV_VAR=foo")
return $result("stdout") eq "foo
"
