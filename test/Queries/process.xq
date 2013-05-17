import module namespace proc = "http://www.zorba-xquery.com/modules/process"; 


{
  variable $stdOutTest := proc:exec-command("echo","hello world") ;
  variable $stdErrTest := proc:exec-command("echo","Ooops. an error. 1>&amp;2");
  variable $stdOutWinTest := proc:exec-command("cmd", ("/c", "echo","hello world")) ;
  variable $stdErrWinTest := proc:exec-command("cmd", ("/c", "echo","Ooops. an error. 1>&amp;2"));
  
  let $result :=
    <result>
      <out>{normalize-space(data($stdOutTest("stdout")))}</out>
      <err>{normalize-space(data($stdErrTest("stderr")))}</err>
    </result>
  return 
    if (contains($result/err/text(),"is not recognized as an internal or external command"))
    then
      <result>
        <out>{normalize-space(data($stdOutWinTest("stdout")))}</out>
        <err>{normalize-space(data($stdErrWinTest("stderr")))}</err>
      </result>
    else
      $result
}
