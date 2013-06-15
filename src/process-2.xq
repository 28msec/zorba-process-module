jsoniq version "1.0";

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
 : <p>
 : This module provides functions to create a native process and return the result
 : (i.e. exit code, result on standard out and error) of executing the given
 : file or command.
 : </p>
 :
 : <p>
 : Example:
 : <pre>
 :   import module namespace proc = "http://zorba.io/modules/process";
 :   proc:exec("ls")
 : </pre>
 : </p>
 :
 : <p>
 : Potential result:
 : <pre>
 : {
 :   "exit-code": 0,
 :   "stdout": "myfile.txt",
 :   "stderr": ""
 : }
 : </pre>
 : </p>
 :
 : <p>
 : The <tt>exec-command</tt> set of functions allows execution of commands
 : through the command line interpreter of the operating system, such as "sh"
 : on Unix systems or "cmd.exe" on Windows. 
 : </p>
 :
 : <p>
 : For POSIX compliant platforms the functions return 128 + termination signal
 : code of the process as their exit-code.
 : On Windows platforms, the exit-code is the return value of the process or the exit 
 : or terminate process specified value.
 : </p>
 :
 : @author Cezar Andrei, Nicolae Brinza
 : @project Zorba/Input Output/Process
 :)
module namespace p = "http://zorba.io/modules/process";

declare namespace an = "http://www.zorba-xquery.com/annotations";

declare namespace ver = "http://www.zorba-xquery.com/options/versioning";
declare option ver:module-version "1.0";


(:~
 : <p>
 : Executes the specified program in a separate process.
 : </p>
 :
 : <p>
 : This function does not allow arguments to be passed to
 : the command. The $filename parameter can contain the full path to the 
 : executable. On Unix systems,  if the specified filename does not contain 
 : a slash "/", the function duplicates the actions of the shell in searching 
 : for an executable file. The file is sought in the colon-separated list of 
 : directory pathnames specified in the PATH environment variable. If this 
 : variable isn't defined, the path list defaults to the current directory 
 : followed by the list of directories returned by the operating system.
 : </p>
 :
 : @param $filename the name of program to be executed 
 :
 : @return the result of the execution as an object
 :
 : @error p:PROC01 if an error occurred while communicating with the process.
 :)
declare %an:sequential function p:exec(
  $filename as string
) as object external;

(:~
 : <p>
 : Executes the specified program in a separate process.
 : </p>
 :
 : <p>
 : The $filename parameter can contain the full path to the 
 : executable. On Unix systems,  if the specified filename does not contain 
 : a slash "/", the function duplicates the actions of the shell in searching 
 : for an executable file. The file is sought in the colon-separated list of 
 : directory pathnames specified in the PATH environment variable. If this 
 : variable isn't defined, the path list defaults to the current directory 
 : followed by the list of directories returned by the operating system.
 : The $args parameters will be passed to the executable file as arguments.
 : </p>
 :
 : @param $filename the name of program to be executed 
 : @param $args arguments to be passed to the executable 
 :
 : @return the result of the execution as an object
 :
 : @error p:PROC01 if an error occurred while communicating with the process.
 :)
declare %an:sequential function p:exec(
  $filename as string,
  $args as string*
) as object external;

(:~
 : <p>
 : Executes the specified program in a separate process.
 : </p>
 :
 : <p>
 : The $filename parameter can contain the full path to the 
 : executable. On Unix systems,  if the specified filename does not contain 
 : a slash "/", the function duplicates the actions of the shell in searching 
 : for an executable file. The file is sought in the colon-separated list of 
 : directory pathnames specified in the PATH environment variable. If this 
 : variable isn't defined, the path list defaults to the current directory 
 : followed by the list of directories returned by the operating system.
 : </p>
 :
 : <p>
 : The $env allows defining and passing environment variables to the target 
 : process. They should be in the form "ENVVAR=value" where "ENVVAR" is the 
 : name of the environment variable and "value' is the string value to set it to.
 : </p>
 :
 : @param $filename the name of program to be executed 
 : @param $args arguments to be passed to the executable 
 : @param $env list of environment variables for the executable
 :
 : @return the result of the execution as an object
 :
 : @error p:PROC01 if an error occurred while communicating with the process.
 :)
declare %an:sequential function p:exec(
  $filename as string,
  $args as string*,
  $env as string*
) as object external;

(:~
 : <p>
 : Executes the specified string command in a separate process.
 : </p>
 :
 : <p>
 : This function does not allow arguments to be passed to the command.
 : </p>
 :
 : @param $cmd command to be executed (without arguments)
 :
 : @return the result of the execution as an object
 :
 : @error p:PROC01 if an error occurred while communicating with the process.
 :)
declare %an:sequential function p:exec-command(
  $cmd as string
) as object external;

(:~
 : <p>
 : Executes the specified string command in a separate process.
 : </p>
 :
 : <p>
 : Each of the strings in the sequence passed in as the second
 : argument is passed as an argument to the executed command.
 : </p>
 :
 : @param $cmd command to be executed (without arguments)
 : @param $args the arguments passed to the executed command (e.g. "-la")
 :
 : @return the result of the execution as an object
 :
 : @error p:PROC01 if an error occurred while communicating with the process.
 :)
declare %an:sequential function p:exec-command(
  $cmd as string,
  $args as string*
) as object external;
