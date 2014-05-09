<cfcomponent displayname="TestDomains" extends="mxunit.framework.TestCase">

	<cffunction name="setUp" access="public" returntype="void" output="no">
		
		<cfset this.domainsService = Application.Domains />
		
	</cffunction>

	<cffunction name="shouldOnlyStoreDomainNameTestOne" access="public" returntype="void" output="no"
		hint="Domains saved should only store the domain information. Test url does not include www." mxunit:transaction="rollback">
		
		<cfset var sampleDomainName = "http://example123.com/folder/page.html" />
		<cfset var createdDomainId = this.domainsService.saveDomain( DomainName=sampleDomainName ) />
		<cfset var qDomain = this.domainsService.getDomain( DomainId=createdDomainId ) />
		
		<cfset assertEquals( "example123.com", qDomain.DomainName, "Incoming URL http://example123.com/folder/page.html returned example123.com" ) />
		
	</cffunction>

	<cffunction name="shouldOnlyStoreDomainNameTestTwo" access="public" returntype="void" output="no"
		hint="Domains saved should only store the domain information. Test url includes www." mxunit:transaction="rollback">
		
		<cfset var sampleDomainName = "http://www.example123.com/folder/page.html" />
		<cfset var createdDomainId = this.domainsService.saveDomain( DomainName=sampleDomainName ) />
		<cfset var qDomain = this.domainsService.getDomain( DomainId=createdDomainId ) />
		
		<cfset assertEquals( "example123.com", qDomain.DomainName, "Incoming URL http://www.example123.com/folder/page.html returned example123.com" ) />
		
	</cffunction>
	
	<cffunction name="shouldReturnFullPathIfDomainDoesNotExist" access="public" returntype="void" output="no"
		hint="Any incoming incoming url should send back the fully qualified url if it doesnt exist in the database"
		mxunit:transaction="rollback">
		
		<cfset var randomNumber = RandRange( -1000000, 1000000, "SHA1PRNG") />
		<cfset var sampleDomainName = "http://example" & randomNumber & ".com/folder" & randomNumber & "/page.html" />
		<cfset var convertedURLString = this.domainsService.convertURL( sampleDomainName ) />
		
		<cfset var qDomain = this.domainsService.getDomain( DomainName="example" & randomNumber & ".com" )>
		
		<cfif qDomain.recordCount > 0 >
			
			<cfset fail( "Record exists in database could not continue test" ) />
			
		</cfif>
		
		<cfset assertEquals( sampleDomainName,  convertedURLString ) />
		
	</cffunction>

	<cffunction name="shouldReturnRelativePathIfDomainExists" access="public" returntype="void" output="no"
		hint="Any incoming url should send back the relative path if the domain exists in the database"
		mxunit:transaction="rollback">
		
		<cfset var sampleDomainName = "http://example.com/folder/page.html" />
		<cfset var createdDomainId = this.domainsService.saveDomain( DomainName=sampleDomainName ) />
		<cfset var convertedURLString = "" />
		
		<cfif createdDomainId > 0 >
			
			<cfset convertedURLString = this.domainsService.convertURL( sampleDomainName ) />
			
		<cfelse>
			
			<cfset fail( "Record was not saved to database to continue test" ) />
			
		</cfif>
		
		<cfset assertEquals( "/folder/page.html", convertedURLString ) />
		
	</cffunction>
	
</cfcomponent>