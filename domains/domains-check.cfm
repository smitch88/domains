<h1>Relative Path</h1>

<p>Accepts any domain url and if the domain exists in the database it will return the relative path, otherwise it will return the whole domain url</p>

<cf_sebForm CFC_Component="#Application.Domains#" CFC_Method="convertURL" forward="index.cfm?relPath={result}">
   <cf_sebField name="DomainName" label="Domain Name" required="true">
   <cf_sebField type="submit" label="Get Relative Path">
</cf_sebForm>

<cfif StructKeyExists( url, "relPath" )>
	
	<h2>The relative path is:</h2>
	
	<p><cfoutput>#url.relPath#</cfoutput></p>
	
</cfif>