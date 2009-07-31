<!---
			
	Copyright 2009, Bob Silverberg
	
	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in 
	compliance with the License.  You may obtain a copy of the License at 
	
		http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software distributed under the License is 
	distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
	implied.  See the License for the specific language governing permissions and limitations under the 
	License.

--->
<cfcomponent extends="UnitTests.BaseTestCase" output="false">
	
	<cffunction name="setUp" access="public" returntype="void">
		<cfscript>
			onMMHelper = createObject("component","ValidateThis.util.onMMHelper").init();
			TransientFactory = CreateObject("component","ValidateThis.util.TransientFactoryNoCS").init(onMMHelper);
			FileSystem = CreateObject("component","ValidateThis.util.FileSystem").init(TransientFactory);
			ValidateThisConfig = {JSRoot="/JS"};
			Translator = createObject('component','MightyMock.MightyMock');
			ClientValidator = CreateObject("component","ValidateThis.client.ClientValidator").init(FileSystem,ValidateThisConfig,Translator);
			variables.CSGenerator = CreateObject("component","ValidateThis.client.CommonScriptGenerator").init(ClientValidator);
			variables.JSLib = "jQuery";
			variables.ExpectedInJSIncludes = '<script src="/JSjquery-1.3.2.min.js" type="text/javascript">';
			variables.ExpectedInLocale = '<script src="/JSmessages_fr.js" type="text/javascript"></script>';
			variables.ExpectedInVTSetup = 'jQuery.validator.addMethod("regex", function(value, element, param)';
		</cfscript>
	</cffunction>

	<cffunction name="getInitializationScriptDefaultReturnsCorrectScript" returntype="void" access="public">
		<cfscript>
			script = variables.CSGenerator.getInitializationScript(JSLib=variables.JSLib);
			debug(script);
			assertTrue(script CONTAINS variables.ExpectedInJSIncludes);
			assertFalse(script CONTAINS variables.ExpectedInLocale);
			assertTrue(script CONTAINS variables.ExpectedInVTSetup);
		</cfscript>
	</cffunction>

	<cffunction name="getInitializationScriptNoIncludesReturnsCorrectScript" returntype="void" access="public">
		<cfscript>
			script = variables.CSGenerator.getInitializationScript(JSLib=variables.JSLib,JSIncludes=false);
			debug(script);
			assertFalse(script CONTAINS variables.ExpectedInJSIncludes);
			assertFalse(script CONTAINS variables.ExpectedInLocale);
			assertTrue(script CONTAINS variables.ExpectedInVTSetup);
		</cfscript>
	</cffunction>

	<cffunction name="getInitializationScriptWithLocaleReturnsCorrectScript" returntype="void" access="public">
		<cfscript>
			script = variables.CSGenerator.getInitializationScript(JSLib=variables.JSLib,locale="fr_FR");
			debug(script);
			assertTrue(script CONTAINS variables.ExpectedInJSIncludes);
			assertTrue(script CONTAINS variables.ExpectedInLocale);
			assertTrue(script CONTAINS variables.ExpectedInVTSetup);
		</cfscript>
	</cffunction>

	<cffunction name="getInitializationScriptWithLocaleNoIncludesReturnsCorrectScript" returntype="void" access="public">
		<cfscript>
			script = variables.CSGenerator.getInitializationScript(JSLib=variables.JSLib,JSIncludes=false,locale="fr_FR");
			debug(script);
			assertFalse(script CONTAINS variables.ExpectedInJSIncludes);
			assertTrue(script CONTAINS variables.ExpectedInLocale);
			assertTrue(script CONTAINS variables.ExpectedInVTSetup);
		</cfscript>
	</cffunction>

</cfcomponent>
