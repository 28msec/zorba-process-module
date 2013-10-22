# Copyright 2006-2010 The FLWOR Foundation.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

CMAKE_MINIMUM_REQUIRED(VERSION 2.6)

PROJECT (zorba_process_module)
ENABLE_TESTING ()
INCLUDE (CTest)

LIST (APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake_modules")

FIND_PACKAGE (Zorba REQUIRED HINTS "${ZORBA_BUILD_DIR}")
INCLUDE ("${Zorba_USE_FILE}")

ADD_SUBDIRECTORY("src")

ADD_TEST_DIRECTORY ("${PROJECT_SOURCE_DIR}/test")

IF (WIN32)
  EXPECTED_FAILURE (zorba_process_module/process1-01.xq 866979)
  EXPECTED_FAILURE (zorba_process_module/process2-01.xq 866979)
  EXPECTED_FAILURE (zorba_process_module/process2-02.xq 866979)
  EXPECTED_FAILURE (zorba_process_module/process2-03.xq 866979)
  EXPECTED_FAILURE (zorba_process_module/process2-04.xq 866979)
  EXPECTED_FAILURE (zorba_process_module/process2-05.xq 866979)
  EXPECTED_FAILURE (zorba_process_module/process2-06.xq 866979)
  EXPECTED_FAILURE (zorba_process_module/process2-07.xq 866979)
ENDIF (WIN32)

DONE_DECLARING_ZORBA_URIS()
