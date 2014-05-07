<cfparam name="URL.id" default="0">

<cf_template>
	
	<h1> Editing domain record </h1>
	
	<cf_sebForm forward="index.cfm" pkfield="DomainID" recordid="#URL.id#"
				CFC_Component="#Application.Domains#" CFC_GetMethod="getDomain" CFC_Method="saveDomain">
	      
		<cf_sebField name="DomainName" label="Domain Name" required="true" regex="^((?!www).)*$">
	    <cf_sebField type="submit" label="Save">
		  
	</cf_sebForm>

</cf_template>