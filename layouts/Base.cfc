<cfcomponent displayname="Base Layout" extends="layout">
<cffunction name="head" access="public" output="yes">
<cfargument name="title" type="string" required="yes"><cfset variables.me.title = arguments.title>
<cfcontent reset="Yes"><!doctype html>
<html class="no-js" lang="en">
<head>
	
	<title>#arguments.title#</title>
	
	<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/cupertino/jquery-ui.css" />
	<link rel="stylesheet" href="../lib/css/table.css" />
	
</cffunction>
<cffunction name="body" access="public" output="yes">
</head>
<body>
</cffunction>
<cffunction name="end" access="public" output="yes">
	
	<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
	
</body>
</html>
</cffunction>
</cfcomponent>