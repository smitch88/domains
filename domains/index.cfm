<cf_Template use="Domains">

	<div id="mainTabs" style="display:none;">
	
		<ul>
			<li><a href="#listing">Domain Listing</a></li>
			<li><a href="#relativePath">Show Relative Path</a></li>
			<li><a href="#testPage">Testing Domains</a></li>
		</ul>
		
		<div id="listing">
			
			<cf_layout include="domain-list.cfm">
			
		</div>

		<div id="relativePath">
			
			<cf_layout include="domains-check.cfm">
			
		</div>

		<div id="testPage">
			
			<cf_layout include="testDomains.cfm">
			
		</div>
						
	</div>
			
</cf_Template>
	