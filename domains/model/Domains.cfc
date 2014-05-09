<cfcomponent displayName="Domains" extends="com.sebtools.Records" output="no">

<cffunction name="convertURL" access="public" returntype="string" output="no" hint="I convert the URL to a proper link URL for this system.">
	<cfargument name="DomainName" required="true">
	
	<cfset var result = Arguments.DomainName>
	<cfset var sUrlStruct = getURLDomainStruct( Arguments.DomainName )><!--- Returns struct of strings ( domain, relativePath ) --->
	<cfset var hasMatchingDomain = hasDomains( DomainName = sUrlStruct.domain )>
	
	<!--- Check to see if domain already exists in the set --->
	<cfif hasMatchingDomain >
		<cfset result = sUrlStruct.relativePath>
	</cfif>
	
	<cfreturn result>
</cffunction>

<cffunction name="validateDomain" access="public" returntype="struct" output="no">
	
	<cfset Arguments = validateDomainOnly(ArgumentCollection=Arguments)>
	
	<cfreturn arguments>
	
</cffunction>

<cffunction name="getURLDomainStruct" access="private" returntype="struct" output="no" hint="I return a struct of strings ( domain, relativePath ) holding just the domain name and holding the relative file path fo the domain, respectively.">
	<cfargument name="url" required="true">
	
	<cfset var sResult = { "domain" = Arguments.url, "relativePath" = "" } />
	<cfset var DomainWithRelativePath = "(\w+.)([a-zA-Z]+)\/(.*)?" />
	
	<cfset var aMatches = REMatch( DomainWithRelativePath , Arguments.url ) />
	
	<cfif ArrayLen( aMatches ) GT 0 >
		
		<cfset sResult.domain = ListFirst( aMatches[1], "/" ) />
		<cfset sResult.relativePath = "/" & ListRest( aMatches[1], "/" ) />
			
	</cfif>
	
	<cfreturn sResult>
</cffunction>

<cffunction name="validateDomainOnly" access="public" returntype="struct" output="no" hint="I ensure only the domain name is saved.">
	
	<cfset var StrippedDomain = "">
	
	<cfif StructKeyExists(Arguments, "DomainName")>
		
		<cfset StrippedDomain = getURLDomainStruct(Arguments.DomainName).domain>
		
		<!--- Not already stripped --->
		<cfif Len( strippedDomain )>
			<cfset Arguments.DomainName = StrippedDomain>
		</cfif>
					
	</cfif>
	
	<cfreturn Arguments>
</cffunction>

<cffunction name="xml" access="public" returntype="void" output="yes">
<tables>
	<table entity="Domain"></table>
</tables>
</cffunction>
		
</cfcomponent>