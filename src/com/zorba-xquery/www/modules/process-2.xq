jsoniq version "3.0";

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
 : <p>
 : Potential result:
 : <pre class="ace-static" ace-mode="xquery"><![CDATA[
 : {
 :   "exit-code": 0,
 :   "stdout": "myfile.txt",
 :   "stderr": ""
 : }
 : ]]></pre>
 : <p>
 : The exec-command() set of functions allows execution of commands through the operating
 : system's command line interpreter, such as "sh" on Unix systems or "cmd.exe" on Windows. 
 :
 : @author Cezar Andrei, Nicolae Brinza
 : @project Zorba/IO/Process
 :
 :)
module namespace process = "http://www.zorba-xquery.com/modules/process";

declare namespace an = "http://www.zorba-xquery.com/annotations";

declare namespace ver = "http://www.zorba-xquery.com/options/versioning";
declare option ver:module-version "2.0";


(:~
 : Executes the specified program in a separate process.
 : This function does not allow arguments to be passed to
 : the command. The $filename parameter can contain the full path to the 
 : executable. On Unix systems,  if the specified filename does not contain 
 : a slash "/", the function duplicates the actions of the shell in searching 
 : for an executable file. The file is sought in the colon-separated list of 
 : directory pathnames specified in the PATH environment variable. If this 
 : variable isn't defined, the path list defaults to the current directory 
 : followed by the list of directories returned by the operating system.
 :
 : @param $filename the name of program to be executed 
 :
 : @return the result of the execution as an object as
 :         shown in the documentation of this module. The exit-code
 :         returns the exit code of the child process.
 : For POSIX compliant platforms: returns the program exit code. If the program is 
 : terminated or stopped: 128 + termination signal code. 
 : For Windows platforms: returns the return value of the program or the exit 
 : or terminate process specified value.
 :
 : @error process:PROC01 if an error occurred while communicating 
 :   with the executed process.
 :)
declare %an:sequential function process:exec(
  $filename as string
) as object() external;

(:~
 : Executes the specified program in a separate process. 
 : The $filename parameter can contain the full path to the 
 : executable. On Unix systems,  if the specified filename does not contain 
 : a slash "/", the function duplicates the actions of the shell in searching 
 : for an executable file. The file is sought in the colon-separated list of 
 : directory pathnames specified in the PATH environment variable. If this 
 : variable isn't defined, the path list defaults to the current directory 
 : followed by the list of directories returned by the operating system.
 : The $args parameters will be passed to the executable file as arguments.
 :
 : @param $filename the name of program to be executed 
 : @param $args arguments to be passed to the executable 
 :
 : @return the result of the execution as an object as
 :         shown in the documentation of this module. The exit-code
 :         returns the exit code of the child process.
 : For POSIX compliant platforms: returns the program exit code. If the program is 
 : terminated or stopped: 128 + termination signal code. 
 : For Windows platforms: returns the return value of the program or the exit 
 : or terminate process specified value.
 :
 : @error process:PROC01 if an error occurred while communicating 
 :   with the executed process.
 :)
declare %an:sequential function process:exec(
  $filename as string,
  $args as string*
) as object() external;

(:~
 : Executes the specified program in a separate process. 
 : The $filename parameter can contain the full path to the 
 : executable. On Unix systems,  if the specified filename does not contain 
 : a slash "/", the function duplicates the actions of the shell in searching 
 : for an executable file. The file is sought in the colon-separated list of 
 : directory pathnames specified in the PATH environment variable. If this 
 : variable isn't defined, the path list defaults to the current directory 
 : followed by the list of directories returned by the operating system.
 : The $args parameters will be passed to the executable file as arguments.
 : The $env allows defining and passing environment variables to the target 
 : process. They should be in the form "ENVVAR=value" where "ENVVAR" is the 
 : name of the environment variable and "value' is the string value to set it to.
 :
 : @param $filename the name of program to be executed 
 : @param $args arguments to be passed to the executable 
 : @param $env environment variables for the executable
 :
 : @return the result of the execution as an object as
 :         shown in the documentation of this module. The exit-code
 :         returns the exit code of the child process.
 : For POSIX compliant platforms: returns the program exit code. If the program is 
 : terminated or stopped: 128 + termination signal code. 
 : For Windows platforms: returns the return value of the program or the exit 
 : or terminate process specified value.
 :
 : @error process:PROC01 if an error occurred while communicating 
 :   with the executed process.
 :)
declare %an:sequential function process:exec(
  $filename as string,
  $args as string*,
  $env as string*
) as object() external;

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
declare %an:sequential function process:exec-command(
  $cmd as string
) as object() external;

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
declare %an:sequential function process:exec-command(
  $cmd as string,
  $args as string*
) as object() external;
