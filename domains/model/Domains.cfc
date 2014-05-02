<cfcomponent displayName="Domains" extends="com.sebtools.Records" output="no">

	<!--- Will create a table "Domain" with DomainID, Text field for DomainName, and text filed DomainURL --->
	<cffunction name="xml" access="public" returntype="void" output="yes">
		
		<!--- Needs to have tables as root of xml --->
		<tables>
		
			<table entity="Domain"></table>
			
		</tables>
		
	</cffunction>
	
	<!--- Custom validation function that only saves the domain name --->
	<cffunction name="validateDomain" access="public" returntype="struct" output="no">
		
		<cfif StructKeyExists( arguments, "DomainName" )>
			<cfset arguments.DomainName = getURLDomainStruct( arguments.DomainName ).domain />
		</cfif>
		
		<cfreturn arguments>
		
	</cffunction>

	<!--- Remote update function that only saves the domain name --->
	<cffunction name="remoteUpdateDomain" access="remote" returntype="string" output="no" returnformat="json">
		
		<cfset var returnStruct = {
			"success" = false,
			"message" = "Failed to update the domain name"
		} />
		
		<cfset var urlStruct = getURLDomainStruct( form.domainName ) />
		
		<cfset var recordUpdate = saveRecord( DomainId = form.id, DomainName = urlStruct.domain ) />
		
		<cfreturn serializeJSON( returnStruct ) />
		
	</cffunction>
			
	<cffunction name="convertURL" access="public" returntype="string" output="yes">
		<cfargument name="domainName"required="true">
		
		<!--- Returns struct of strings ( domain, relativePath ) that have gone through regex match --->
		<cfset var urlReturnString = arguments.domainName />
		<cfset var urlStruct = getURLDomainStruct( arguments.domainName ) />
		<cfset var hasMatchingDomain = hasDomains( DomainName = urlStruct.domain ) />
		
		<!--- Check to see if domain already exists in the set --->
		<cfif hasMatchingDomain >
			
			<cfset urlReturnString = urlStruct.relativePath />
			
		</cfif>
		
		<cfreturn urlReturnString />
			
	</cffunction>

	<cffunction name="getURLDomainStruct" access="private" returntype="struct" output="yes">
		<cfargument name="url" required="true">
		
		<cfset var domainStruct = { "domain" = "", "relativePath" = "" } />
		<cfset var domainWithRelativePath = "(\w+.)(com|net|org|gov)(.*)?" />
		
		<cfset var matches = REMatch( domainWithRelativePath , arguments.url ) />
		
		<cfif ArrayLen( matches ) GT 0 >
			
			<cfset domainStruct.domain = ListFirst( matches[1], "/" ) />
			<cfset domainStruct.relativePath = ListRest( matches[1], "/" ) />
				
		</cfif>
		
		<cfreturn domainStruct />
			
	</cffunction>
		
</cfcomponent>
