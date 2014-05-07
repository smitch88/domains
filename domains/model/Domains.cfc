<cfcomponent displayName="Domains" extends="com.sebtools.Records" output="no">

<cffunction name="xml" access="public" returntype="void" output="yes" hint="Will create a table "Domain" with DomainID, Text field for DomainName, and text filed DomainURL">
	
	<tables>
	
		<table entity="Domain"></table>
		
	</tables>
	
</cffunction>

<cffunction name="validateDomain" access="public" returntype="struct" output="no" hint="Custom validation function that only saves the domain name">
	
	<cfif StructKeyExists( arguments, "DomainName" )>
		
		<cfset var strippedDomain = getURLDomainStruct( arguments.DomainName ).domain />
		
		<!--- Not already stripped --->
		<cfif Len( strippedDomain ) > 0 >
			
			<cfset arguments.DomainName = strippedDomain />
		
		</cfif>
					
	</cfif>
	
	<cfreturn arguments>
	
</cffunction>

<cffunction name="convertURL" access="public" returntype="string" output="yes">
	<cfargument name="domainName"required="true">
	
	<!--- Returns struct of strings ( domain, relativePath ) that have gone through regex match --->
	<cfset var urlReturnString = arguments.domainName />
	<cfset var sUrlStruct = getURLDomainStruct( arguments.domainName ) />
	<cfset var hasMatchingDomain = hasDomains( DomainName = sUrlStruct.domain ) />
	
	<!--- Check to see if domain already exists in the set --->
	<cfif hasMatchingDomain >
		
		<cfset urlReturnString = sUrlStruct.relativePath />
		
	</cfif>
	
	<cfreturn urlReturnString />
		
</cffunction>

<cffunction name="getURLDomainStruct" access="private" returntype="struct" output="yes">
	<cfargument name="url" required="true">
	
	<cfset var sDomainStruct = { "domain" = arguments.url, "relativePath" = "" } />
	<cfset var domainWithRelativePath = "(\w+.)([a-zA-Z]+)\/(.*)?" />
	
	<cfset var aMatches = REMatch( domainWithRelativePath , arguments.url ) />
	
	<cfif ArrayLen( aMatches ) GT 0 >
		
		<cfset sDomainStruct.domain = ListFirst( aMatches[1], "/" ) />
		<cfset sDomainStruct.relativePath = "/" & ListRest( aMatches[1], "/" ) />
			
	</cfif>
	
	<cfreturn sDomainStruct />
		
</cffunction>
		
</cfcomponent>
