<cfcomponent displayname="TestDomains" extends="mxunit.framework.TestCase">

	<cffunction name="setUp" access="public" returntype="void" output="no">
		
		<cfset this.domainsObject = createObject( "model.Domains" ) />
		
	</cffunction>

	<cffunction name="sampleTest" access="public" returntype="void" output="no">
		
		<cfset assertEquals( 1, 1 ) />
		
	</cffunction>

	<cffunction name="shouldOnlyStoreDomainNameNoWWW" access="public" returntype="void" output="no"
		hint="Any incoming url should send back the relative path if the domain exists in the database"
		mxunit:transaction="rollback">
		
		<cfset var sampleDomainName = "http://example123.com/folder/page.html" />
		<cfset var returnString = this.domainsObject.saveDomain( DomainName=sampleDomainName ) />
		<cfset var q = this.domainsObject.getDomain( DomainName=sampleDomainName ) />
		
		<cfset assertEquals( q.DomainName, "example123.com" ) />
		
	</cffunction>

	<cffunction name="shouldOnlyStoreDomainNameWithWWW" access="public" returntype="void" output="no"
		hint="Any incoming url should send back the relative path if the domain exists in the database"
		mxunit:transaction="rollback">
		
		<cfset var sampleDomainName = "http://www.example123.com/folder/page.html" />
		<cfset var returnString = this.domainsObject.saveDomain( DomainName=sampleDomainName ) />
		<cfset var q = this.domainsObject.getDomain( DomainName=sampleDomainName ) />
		
		<cfset assertEquals( q.DomainName, "example123.com" ) />
		
	</cffunction>

	<cffunction name="shouldReturnFullURLPathIfDomainNotExists" access="public" returntype="void" output="no"
		hint="Any incoming url should send back the fully qualified url if it doesnt exist in the database"
		mxunit:transaction="rollback">
		
		<cfset var sampleDomainName = { DomainName = "http://example1234567890.com/folder/page.html" } />
		<cfset var convertedURLString = this.domainsObject.convertURL( sampleDomainName ) />

		<cfset assertEquals( convertedURLString, "http://example1234567890.com/folder/page.html" ) />
		
	</cffunction>

	<cffunction name="shouldReturnRelativePathIfDomainExists" access="public" returntype="void" output="no"
		hint="Any incoming url should send back the fully qualified url if it doesnt exist in the database"
		mxunit:transaction="rollback">
		
		<cfset var sampleDomainName = "http://example.com/folder/page.html" />
		<cfset var returnString = this.domainsObject.saveDomain( DomainName=sampleDomainName ) />
		<cfset var convertedURLString = this.domainsObject.convertURL( sampleDomainName ) />

		<cfset assertEquals( convertedURLString, "/folder/page.html" ) />
		
	</cffunction>
	
</cfcomponent>