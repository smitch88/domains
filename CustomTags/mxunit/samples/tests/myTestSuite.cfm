<cfparam name="URL.output" default="html">

<cfscript>
	DTS = createObject("component","mxunit.runner.DirectoryTestSuite");
	excludes = "";
	results = DTS.run(
				directory     = "/",
				componentPath = "mxunit.samples.tests",
				recurse       = "true",
				excludes      = "#excludes#"
				);
</cfscript>
 
<cfoutput>#results.getResultsOutput(URL.output)#</cfoutput>  			
	
