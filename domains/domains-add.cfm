<h1>Adding Domain</h1>

<p>Accepts any domain url and adds only the domain name to the table ( Currently accepts duplicate domain values )</p>

<cf_sebForm CFC_Component="#Application.Domains#" CFC_Method="saveDomain">
   <cf_sebField name="DomainName" label="Domain Name" required="true">
   <cf_sebField type="submit" label="Save Domain">
</cf_sebForm>