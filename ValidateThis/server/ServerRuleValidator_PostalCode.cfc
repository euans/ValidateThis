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
<cfcomponent output="false" name="ServerRuleValidator_PostalCode" extends="AbstractServerRuleValidator" hint="I am responsible for performing the US/Canada Postal Code validation.">

	<cffunction name="validate" returntype="any" access="public" output="false" hint="I perform the validation returning info in the validation object.">
		<cfargument name="validation" type="any" required="yes" hint="The validation object created by the business object being validated." />
		<cfargument name="locale" type="string" required="yes" hint="The locale to use to generate the default failure message." />

		<cfset var args = [arguments.validation.getPropertyDesc()] />
		
		<cfif shouldTest(arguments.validation) AND NOT IsValid("regex", reReplace(arguments.validation.getObjectValue(), '\s+', '', 'all'), '^((\d{5}(-\d{4})?)|([A-Z]\d[A-Z]\d[A-Z]\d))$')>
			<cfset fail(arguments.validation,variables.messageHelper.getGeneratedFailureMessage("defaultMessage_PostalCode",args,arguments.locale)) />
		</cfif>
	</cffunction>

	<cffunction name="isUSPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid US Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 44128 | 44128-2244--->
		<cfreturn ReFindNoCase("(^\d{5}$)|(^\d{5}-\d{4}$)",arguments.text)/>
	</cffunction>

	<cffunction name="isCanadianPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Canadian Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches T2p 3c7 | T3P3c7 | T2P 3C7--->
		<cfreturn ReFindNoCase("^([a-zA-Z][0-9][a-zA-Z]\s?[0-9][a-zA-Z][0-9])$",arguments.text)/>
	</cffunction>

	<cffunction name="isDutchPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Dutch Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 1234AB | 1234 AB | 1001 AB | NL-1234 AB--->
		<cfreturn ReFindNoCase("^([N][L]-[1-9][0-9]{3}\s?[a-zA-Z]{2})|([1-9][0-9]{3}\s?[a-zA-Z]{2})$",arguments.text)/>
	</cffunction>

	<cffunction name="isBrazilPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Brazilian Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 70235 | 70235-120 | 70235125--->
		<cfreturn ReFindNoCase("((^\d{5}$)|(^\d{8}$))|(^\d{5}-\d{3}$)",arguments.text)/>
	</cffunction>

	<cffunction name="isGermanPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid German Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 03242 | 36260 | 12394--->
		<cfreturn ReFindNoCase("^([0-9]{5})$",arguments.text)/>
	</cffunction>

	<cffunction name="isDanishPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Danish Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches 03242 | 36260 | 12394--->
		<cfreturn ReFindNoCase("^([D-d][K-k]-[1-9]{1}[0-9]{3})$",arguments.text)/>
	</cffunction>

	<cffunction name="isUKPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid UK Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches GIR 0AA | SW1Y 1AA | AB1 4BL--->
		<cfreturn ReFindNoCase("^((([A-PR-UWYZ])([0-9][0-9A-HJKS-UW]?))|(([A-PR-UWYZ][A-HK-Y])([0-9][0-9ABEHMNPRV-Y]?))\s{0,2}(([0-9])([ABD-HJLNP-UW-Z])([ABD-HJLNP-UW-Z])))|(((GI)(R))\s{0,2}((0)(A)(A)))$",arguments.text)/>
	</cffunction>

	<cffunction name="isSwedishPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Swedish Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Matches S-123 45 | s 123 45 | S123-45--->
		<cfreturn ReFindNoCase("^([S-s]( |-)?[1-9]{1}[0-9]{2}( |-)?[0-9]{2})$",arguments.text)/>
	</cffunction>

	<cffunction name="isEasternEuropeanPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Eastern European Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Most Eastern European codes have 4 digits - Matches 1000 | 1700 --->
		<cfreturn ReFindNoCase("^([0-9]{4})$",arguments.text)/>
	</cffunction>

	<cffunction name="isJapanPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Japanese Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Japan's format is 999-9999' --->
		<cfreturn ReFindNoCase("^([0-9]{3}-[0-9]{4})$",arguments.text)/>
	</cffunction>

	<cffunction name="isKoreanPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Korean Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---South Korea's format is 999-999' --->
		<cfreturn ReFindNoCase("^([0-9]{3}-[0-9]{3})$",arguments.text)/>
	</cffunction>

	<cffunction name="isIranPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Iranian Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Iran's format is 99999 99999' --->
		<cfreturn ReFindNoCase("^([0-9]{5}\s?[0-9]{5})$",arguments.text)/>
	</cffunction>

	<cffunction name="isChilePostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Chilean Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Chile's format is 9999999 --->
		<cfreturn ReFindNoCase("^([0-9]{7})$",arguments.text)/>
	</cffunction>

	<cffunction name="isArgentinaPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Argentina Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Argentina's format is A9999AAA --->
		<cfreturn ReFindNoCase("^([A-a][0-9]{3}[a-zA-Z]{3})$",arguments.text)/>
	</cffunction>

	<cffunction name="isBarbadosPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Barbados Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Barbados's format is BB99999 --->
		<cfreturn ReFindNoCase("^([B-b]{2}[0-9]{5})$",arguments.text)/>
	</cffunction>

	<cffunction name="isCaymanPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Cayman Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Cayman's format is KY9-9999 --->
		<cfreturn ReFindNoCase("^([K-k][Y-y][0-9]-[0-9]{4})$",arguments.text)/>
	</cffunction>

	<cffunction name="isMaltaPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Malta Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Malta's format is AAA 9999 --->
		<cfreturn ReFindNoCase("^([a-zA-Z]{3}\s?[0-9]{4})$",arguments.text)/>
	</cffunction>

	<cffunction name="isNicaraguaPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Nicaragua Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Nicaragua's format is 999-9999-9 --->
		<cfreturn ReFindNoCase("^([0-9]{3}-[0-9]{4}-[0-9])$",arguments.text)/>
	</cffunction>

	<cffunction name="isPolandPostalcode" output="false" access="public" returntype="boolean" errorCode="Is not a valid Polish Postal code" enabled="true">
		<cfargument name="text" required="true" type="string" default=""/>
		<!---Poland's format is (PL-)99-999 --->
		<cfreturn ReFindNoCase("^(([P][L]-[0-9]{2}-[0-9]{3})|([0-9]{2}-[0-9]{3}))$",arguments.text)/>
	</cffunction>	
</cfcomponent>
	

