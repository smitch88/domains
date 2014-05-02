<!--- Could use a page controller but will just do a query call in page for now --->
<cfoutput>
	
	<cfset qDomain = Application.Domains.getDomain( url.id )>
	
	<p>All form fields are required.</p>
	
	<form id="edit-form">
		<input type="hidden" name="domainId" id="domainId" value="#url.id#">
		
		<fieldset>
			
			<label for="domainName">Domain Name <span class="sebReq">*</span></label>
			<input type="text" name="domainName" id="domainName" class="text ui-widget-content ui-corner-all" value="#qDomain.DomainName#">
			
		</fieldset>
		
	</form>	

</cfoutput>	