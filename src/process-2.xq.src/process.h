/*
 * Copyright 2006-2013 The FLWOR Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#ifndef ZORBA_PROCESSMODULE_PROCESS_H
#define ZORBA_PROCESSMODULE_PROCESS_H

#include <map>

#include <zorba/zorba.h>
#include <zorba/error.h>
#include <zorba/external_module.h>
#include <zorba/function.h>

namespace zorba {
namespace processmodule {

/******************************************************************************
 *****************************************************************************/
class ProcessModule : public ExternalModule
{
private:
  static ItemFactory* theFactory;

protected:
  class ltstr
  {
  public:
    bool operator()(const String& s1, const String& s2) const
    {
      return s1.compare(s2) < 0;
    }
  };

  typedef std::map<String, ExternalFunction*, ltstr> FuncMap_t;

  FuncMap_t theFunctions;

public:
  virtual ~ProcessModule();

  virtual zorba::String getURI() const
  { return "http://zorba.io/modules/process"; }

  virtual zorba::ExternalFunction*
  getExternalFunction(const zorba::String& aLocalname);

  virtual void destroy();

  static ItemFactory* getItemFactory()
  {
    if(!theFactory)
    {
      theFactory = Zorba::getInstance(0)->getItemFactory();
    }

    return theFactory;
  }
};

/******************************************************************************
 *****************************************************************************/
class ExecFunction : public ContextualExternalFunction
{
public:
  ExecFunction(const ProcessModule* aModule, bool aExecProgram = false) 
    : theModule(aModule), theIsExecProgram(aExecProgram) {}

  virtual ~ExecFunction() {}

  virtual zorba::String
  getLocalName() const { if (theIsExecProgram) return "exec"; else return "exec-command"; }

  virtual zorba::ItemSequence_t
  evaluate(const Arguments_t&,
           const zorba::StaticContext*,
           const zorba::DynamicContext*) const;

  virtual String getURI() const
  {
    return theModule->getURI();
  }

protected:
  const ProcessModule* theModule;
  
  bool theIsExecProgram; // if set to true, will use the execvpe() version of the system function
                         // if set to false, will build a command string and pass it to 
                         // either "bash" or "cmd.exe" (through execl() on Linux)

  String getOneStringArgument (const Arguments_t& aArgs, int index) const;
};

} /* namespace processmodule */
} /* namespace zorba */

#endif // ZORBA_PROCESSMODULE_PROCESS_H
