import module namespace proc = "http://www.zorba-xquery.com/modules/process"; 

let $result := proc:exec("this_executable_does_not_exist")
return $result("exit-code") ne 0
