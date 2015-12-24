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
<cfcomponent output="false" name="ClientRuleScripter_PostalCode" extends="AbstractClientRuleScripter" hint="I am responsible for generating JS code for the US/Canada Postal Code validation.">
	
	<cffunction name="generateInitScript" returntype="any" access="public" output="false" hint="I generate the validation 'method' function for the client during fw initialization.">
		<cfargument name="defaultMessage" type="string" required="false" default="Postal Code must be a valid 5 Digit US or 6 Character Canadian Postal Code.">
		<cfset var theScript="" />
		<cfset var theCondition="" />
		
		<!--- JAVASCRIPT VALIDATION METHOD --->
		<cfsavecontent variable="theCondition">
		function(v,e,p){
			return this.optional(e)||/^((\d{5}(-\d{4})?)|([A-Z]\d[A-Z]\d[A-Z]\d))$/i.test(v.replace(/[\s]+/g, ''));
		}</cfsavecontent>
		 
		 <cfreturn generateAddMethod(theCondition,arguments.defaultMessage)/>
	</cffunction>
	
</cfcomponent>


