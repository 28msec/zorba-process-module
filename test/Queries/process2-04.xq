import module namespace proc = "http://www.zorba-xquery.com/modules/process"; 

let $result := proc:exec("printenv",("TEST_ENV_VAR","VAR2"),("TEST_ENV_VAR=foo","VAR2=bar"))
return $result("stdout") eq "foo
bar
"
