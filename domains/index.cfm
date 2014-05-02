<cf_Template use="Domains">
	
	<div id="mainTabs" style="display:none;">
	
		<ul>
			<li><a href="#listing">Domain Listing</a></li>
			<li><a href="#add">Add Domain</a></li>
			<li><a href="#relativePath">Show Relative Path</a></li>
			<li><a href="#testPage">Testing Domains</a></li>
		</ul>
		
		<div id="listing">
			
			<cf_sebTable CFC_Component="#Application.Domains#" CFC_GetMethod="getDomains" isAddable="false">
				<cf_sebColumn dbfield="DomainName" label="Domain Name">
			</cf_sebTable>
			
		</div>
		
		<div id="add">
			
			<h1>Adding Domain</h1>
			
			<p>Accepts any domain url and adds only the domain name to the table ( Currently accepts duplicate domain values )</p>
			
			<cf_sebForm CFC_Component="#Application.Domains#" CFC_Method="saveDomain">
			   <cf_sebField name="DomainName" label="Domain Name" required="true">
			   <cf_sebField type="submit" label="Save Domain">
			</cf_sebForm>
				
		</div>

		<div id="relativePath">
			
			<h1>Relative Path</h1>
			
			<p>Accepts any domain url and if the domain exists in the database it will return the relative path, otherwise it will return the whole domain url</p>
			
			<cf_sebForm CFC_Component="#Application.Domains#" CFC_Method="convertURL" forward="index.cfm?relPath={return}">
			   <cf_sebField name="DomainName" label="Domain Name" required="true">
			   <cf_sebField type="submit" label="Get Relative Path">
			</cf_sebForm>
			
			<cfif StructKeyExists( url, "relPath" )>
				
				<h2>The relative path is:</h2>
				
				<p><cfoutput>#url.relPath#</cfoutput></p>
				
			</cfif>
			
		</div>

		<div id="testPage">
			
			<cfinclude template="testDomains.cfm">
			
		</div>
						
	</div>
	
	<div id="domain-edit-form" title="Edit Domain Name">
		
		<div id="loader"></div>	
		
	</div>
			
</cf_Template>
	