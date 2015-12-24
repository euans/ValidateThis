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
<cfcomponent output="false" name="ServerRuleValidator_Phone" extends="AbstractServerRuleValidator" hint="I am responsible for performing the Phone validation.">

	<cffunction name="validate" returntype="any" access="public" output="false" hint="I perform the validation returning info in the validation object.">
		<cfargument name="validation" type="any" required="yes" hint="The validation object created by the business object being validated." />
		<cfargument name="locale" type="string" required="yes" hint="The locale to use to generate the default failure message." />

		<cfset var args = [arguments.validation.getPropertyDesc()] />
		
		<cfif shouldTest(arguments.validation) AND NOT IsValid("regex", reReplace(arguments.validation.getObjectValue(), '\s+', '', 'all'), '$|^((1|\+1)?[- .]?)?(\(?[2-9]{1}[0-9]{2}\)?)[- .]?([a-zA-Z0-9]{3}[- .]?[a-zA-Z0-9]{4})[ ]*(( |x|ext|ext.|extension|Ext|Ext.|Extension|##){1}[ ]?([0-9]){1,7}){0,1}$')>
			<cfset fail(arguments.validation,variables.messageHelper.getGeneratedFailureMessage("defaultMessage_Phonee",args,arguments.locale)) />
		</cfif>
	</cffunction>

<!--- Some common Country Formats--->

	<cffunction name="isPhoneFormat1" output="false" access="public" returntype="boolean" errorCode="Is not a valid Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches AAA-BBBB-BBBB or AAA BBBB BBBB --->
		<cfreturn ReFindNoCase("^(([0-9]{3}-[0-9]{4}-[0-9]{4})|([0-9]{3}\s?[0-9]{4}\s?[0-9]{4}))$",arguments.text)/>
	</cffunction>

	<!---Phone Format 2 is the NANP format aka the US phone format--->
	
	<cffunction name="isPhoneFormat3" output="false" access="public" returntype="boolean" errorCode="Is not a valid Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches AA AA AA AA or AAA AA AAA --->
		<cfreturn ReFindNoCase("^(([0-9]{2}\s?[0-9]{2}\s?[0-9]{2}\s?[0-9]{2})|([0-9]{3}\s?[0-9]{2}\s?[0-9]{3}))$",arguments.text)/>
	</cffunction>

<!--- Below are Individual Country Formats--->

	<cffunction name="isUSPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid US Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---For United States, Canada, and other NANP countries--->
		<!---Matches 333-333-3333 or (333) 333-3333--->
		<cfreturn ReFindNoCase("(^[2-9]\d{2}-\d{3}-\d{4}$)|(^\([2-9]\d{2}\) \d{3}-\d{4}$)",arguments.text)/>
	</cffunction>

	<cffunction name="isUKPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid UK Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 07222 555555 | (07222) 555555 | +44 7222 555 555 | +44(0)AAAA BBBBBB--->
		<cfreturn ReFindNoCase("^(([0-9]{5}\s?[0-9]{6})|(\([0-9]{5}\)\s?[0-9]{6})|((\+){0,1}[0-9]{2}\s?[0-9]{4}\s?[0-9]{3}\s?[0-9]{3})|((\+){0,1}[0-9]{2}\s?\([0-9]\)\s?[0-9]{4}\s?[0-9]{6}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isFrenchPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid French Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 01 46 70 89 12 | 01-46-70-89-12 | 0146708912--->
		<!---<cfreturn ReFindNoCase("^0[1-6]{1}(([0-9]{2}){4})|((\s[0-9]{2}){4})|((-[0-9]{2}){4})$",arguments.text)/>--->
		<cfreturn ReFindNoCase("^(([0-9]{2}\s?[0-9]{2}\s?[0-9]{2}\s?[0-9]{2}\s?[0-9]{2})|([0-9]{2}\-?[0-9]{2}\-?[0-9]{2}\-?[0-9]{2}\-?[0-9]{2}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isIndiaPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid India Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches +919847444225 | +91-98-44111112 | 98 44111116--->
		<cfreturn ReFindNoCase("^((\+){0,1}91(\s){0,1}(\-){0,1}(\s){0,1}){0,1}98(\s){0,1}(\-){0,1}(\s){0,1}[1-9]{1}[0-9]{7}$",arguments.text)/>
	</cffunction>

	<cffunction name="isBrazilPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Brazil Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 011 5555-1234 | (011) 5555 1234 | (11) 5555.1234 | 1155551234--->
		<cfreturn ReFindNoCase("^((\(0?[1-9][0-9]\))|(0?[1-9][0-9]))[ -.]?([1-9][0-9]{3})[ -.]?([0-9]{4})$",arguments.text)/>
	</cffunction>
	
	<cffunction name="isIsraelPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Israel Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 050-1234567, 0501234567, 501234567 --->
		<cfreturn ReFindNoCase("^0?(5[024])(\-)?\d{7}$",arguments.text)/>
	</cffunction>

	<cffunction name="isSpainPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Spanish Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 333 33 33 33 --->
		<cfreturn ReFindNoCase("^([0-9]{3}\s?[0-9]{2}\s?[0-9]{2}\s?[0-9]{2})$",arguments.text)/>
	</cffunction>

	<cffunction name="isSwitzerlandPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Swiss Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 0AA BBB BB BB --->
		<cfreturn ReFindNoCase("^([0-9]{3}\s?[0-9]{2}\s?[0-9]{2}\s?[0-9]{2})$",arguments.text)/>
	</cffunction>

	<cffunction name="isKoreanPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Korean Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches AA-BBB-BB-BBBB --->
		<cfreturn ReFindNoCase("^([0-9]{2}-[0-9]{3}-[0-9]{2}-[0-9]{4})$",arguments.text)/>
	</cffunction>
	
	<cffunction name="isRussianPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Russian Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches (AAAA) BB-BB-BB or (AAAAA) BB-BBB --->
		<cfreturn ReFindNoCase("^((\([0-9]{4}\)\s?[0-9]{2}-[0-9]{2}-[0-9]{2})|(\([0-9]{5}\)\s?[0-9]{2}-[0-9]{3}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isDutchPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Dutch Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 0AAA BBBBBB or 06-BBBBBBBB --->
		<cfreturn ReFindNoCase("^(([0-9]{4}\s?[0-9]{6})|([0-9]{2}-[0-9]{8}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isAustraliaPhone" output="false" access="public" returntype="boolean" errorCode="Is not a valid Australian Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches (0A) BBBB BBBB or 04MM MBB BBB --->
		<cfreturn ReFindNoCase("^((\([0-9]{2}\)\s?[0-9]{4}\s?[0-9]{4})|([0-9]{4}\s?[0-9]{3}\s?[0-9]{3}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat1" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
		 	0AAA BBBBBB
			0AAA-BBBBBB
			0AAA BBBBBB-XX
		--->
		<cfreturn ReFindNoCase("^(([0-9]{4}[ -.]?[0-9]{6}\-[0-9]{2})|([0-9]{4}[ -.]?[0-9]{6}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat2" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
			+49 AAA BBBBBB
			+49 (AAA) BBBBBB
			(0AAA) BBBBBB
			+49 (0AAA) BBBBBB
		--->
		<cfreturn ReFindNoCase("^(((\+){0,1}[0-9]{2}\s?0?[0-9]{3}\s?[0-9]{6})|((\+){0,1}[0-9]{2}\s?\(0?[0-9]{3}\)\s?[0-9]{6}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat3" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
			+49 (0AAA) / BBBBBBB or +49 (0AAA) BBBBBBB
		--->
		<cfreturn ReFindNoCase("^(((\+){0,1}[0-9]{2}\s?\(0?[0-9]{3}\)\s?[0-9]{7})|((\+){0,1}[0-9]{2}\s?\(0?[0-9]{3}\)\s?\/\s?[0-9]{7}))$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat4" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
			0AAA / BBB BBB BB
		--->
		<cfreturn ReFindNoCase("^(0?[0-9]{3}\s?\/\s?[0-9]{3}\s?[0-9]{3}\s?[0-9]{2})$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat5" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
			+49 0AAA / BBBB
		--->
		<cfreturn ReFindNoCase("^((\+){0,1}[0-9]{2}\s?[0-9]{4}\s?(\/)\s?[0-9]{5})$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat6" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
			+49 (0AAAA) BBBBB
		--->
		<cfreturn ReFindNoCase("^((\+){0,1}[0-9]{2}\s?\(0?[0-9]{4}\)\s?[0-9]{5})$",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPhoneFormat7" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Phone Number">
		<cfargument name="text" required="true" type="string" default=""/>
		<!--- Matches 
			+49 (0AA) BB BB BBB-B
		--->
		<cfreturn ReFindNoCase("^((\+){0,1}[0-9]{2}\s?\(0?[0-9]{2}\)\s?[0-9]{2}\s?[0-9]{2}\s?[0-9]{3}\-?[0-9])$",arguments.text)/>
	</cffunction>

</cfcomponent>
	

