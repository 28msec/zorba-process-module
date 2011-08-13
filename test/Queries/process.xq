import module namespace proc = "http://www.zorba-xquery.com/modules/process"; 


{
  variable $stdOutTest := proc:exec("echo","hello world") ;
  variable $stdErrTest := proc:exec("echo","Ooops. an error. 1>&amp;2");
  variable $stdOutWinTest := proc:exec("cmd", ("/c", "echo","hello world")) ;
  variable $stdErrWinTest := proc:exec("cmd", ("/c", "echo","Ooops. an error. 1>&amp;2"));
  
  let $result :=
    <result>
      <out>{normalize-space(data($stdOutTest/proc:stdout))}</out>
      <err>{normalize-space(data($stdErrTest/proc:stderr))}</err>
    </result>
  return 
    if (contains($result/err/text(),"is not recognized as an internal or external command"))
    then
      <result>
        <out>{normalize-space(data($stdOutWinTest/proc:stdout))}</out>
        <err>{normalize-space(data($stdErrWinTest/proc:stderr))}</err>
      </result>
    else
      $result
}
