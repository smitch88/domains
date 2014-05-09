<cf_Template use="Domains">
	
	<div id="mainTabs" style="display:none;">
	
		<ul>
			<li><a href="#listing">Domain Listing</a></li>
			<li><a href="#add">Add Domain</a></li>
			<li><a href="#relativePath">Show Relative Path</a></li>
			<li><a href="#testPage">Testing Domains</a></li>
		</ul>
		
		<div id="listing">
			
			<cfinclude template="domain-list.cfm">
			
		</div>
		
		<div id="add">
			
			<cfinclude template="domains-add.cfm">
				
		</div>

		<div id="relativePath">
			
			<cfinclude template="domains-check.cfm">
			
		</div>

		<div id="testPage">
			
			<cfinclude template="testDomains.cfm">
			
		</div>
						
	</div>
			
</cf_Template>
	