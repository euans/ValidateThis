<!---
	
	Copyright 2008, Bob Silverberg
	
	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in 
	compliance with the License.  You may obtain a copy of the License at 
	
		http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software distributed under the License is 
	distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
	implied.  See the License for the specific language governing permissions and limitations under the 
	License.
	
--->
<cfcomponent output="false" name="ClientRuleScripter_Phone" extends="AbstractClientRuleScripter" hint="I am responsible for generating JS code for the US/Canada Phone Number validation.">
	
	<cffunction name="generateInitScript" returntype="any" access="public" output="false" hint="I generate the validation 'method' function for the client during fw initialization.">
		<cfargument name="defaultMessage" type="string" required="false" default="Phone must be a valid US or Canadian Phone Number.">
		<cfset var theScript="" />
		<cfset var theCondition="" />
		
		<!--- JAVASCRIPT VALIDATION METHOD --->
		<cfsavecontent variable="theCondition">
		function(v,e,p){
			return this.optional(e)||/^$|^((1|\+1)?[- .]?)?(\(?[2-9]{1}[0-9]{2}\)?)[- .]?([a-zA-Z0-9]{3}[- .]?[a-zA-Z0-9]{4})[ ]*(( |x|ext|ext.|extension|Ext|Ext.|Extension|#){1}[ ]?([0-9]){1,7}){0,1}$/i.test(v);
		}</cfsavecontent>
		 
		 <cfreturn generateAddMethod(theCondition,arguments.defaultMessage)/>
	</cffunction>
	
</cfcomponent>


