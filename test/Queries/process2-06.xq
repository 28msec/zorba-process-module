import module namespace proc = "http://zorba.io/modules/process";

let $result := proc:exec("this_executable_does_not_exist")
return $result("exit-code") ne 0
