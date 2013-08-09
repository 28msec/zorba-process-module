xquery version "3.0";

(:
 : Copyright 2006-2013 The FLWOR Foundation.
 :
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 : http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
:)

(:~
 : This module provides functions to create a native process and return the result
 : (i.e. exit code, result on standard out and error).
 : <p>
 : Example:
 :<pre class="ace-static" ace-mode="xquery">
 :  import module namespace proc = "http://www.zorba-xquery.com/modules/process";
 :  proc:exec("ls")
 :</pre>
 : </p>
 : <p>
 : Potential result:
 : <pre class="ace-static" ace-mode="xquery"><![CDATA[
 : <result xmlns="http://www.zorba-xquery.com/modules/process">
 :   <stdout>myfile.txt</stout>
 :   <stderr/>
 :   <exit-code>0</exit-code>
 : </result>
 : ]]></pre>
 : </p>
 :
 : @author Cezar Andrei
 : @project Zorba/Input Output/Process
 :
 :)
module namespace process = "http://www.zorba-xquery.com/modules/process";

declare namespace an = "http://zorba.io/annotations";

declare namespace ver = "http://zorba.io/options/versioning";
declare option ver:module-version "1.0";

(:~
 : Executes the specified string command in a separate process.
 : This function does not allow arguments to be passed to
 : the command.
 :
 : @param $cmd command to be executed (without arguments)
 :
 : @return the result of the execution as an element as
 :         shown in the documentation of this module. The exit-code
 :         element returns the exit code of the child process.
 : For POSIX compliant platforms: returns the process exit code. If process is 
 : terminated or stopped: 128 + termination signal code. 
 : For Windows platforms: returns the return value of the process or the exit 
 : or terminate process specified value.
 :
 : @error process:PROC01 if an error occurred while communicating 
 :   with the executed process.
 :)
declare %an:sequential function process:exec(
  $cmd as xs:string
) as element(process:result) external;

(:~
 : Executes the specified string command in a separate process.
 : Each of the strings in the sequence passed in as the second
 : argument is passed as an argument to the executed command.
 :
 : @param $cmd command to be executed (without arguments)
 : @param $args the arguments passed to the executed command (e.g. "-la")
 :
 : @return the result of the execution as an element as
 :         shown in the documentation of this module. The exit-code
 :         element returns the exit code of the child process.
 : For POSIX compliant platforms: returns the process exit code. If process is 
 : terminated or stopped: 128 + termination signal code. 
 : For Windows platforms: returns the return value of the process or the exit 
 : or terminate process specified value.
 :
 : @error process:PROC01 if an error occurred while communicating 
 :   with the executed process.
 :)
declare %an:sequential function process:exec(
  $cmd as xs:string,
  $args as xs:string*
) as element(process:result) external;
