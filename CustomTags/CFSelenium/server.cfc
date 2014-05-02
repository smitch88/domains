<!---
PROPS: this is adapted from Joe Rinehart and Brian Kotek's work. Thanks, gents.
 --->
<cfcomponent>

	<cffunction name="init" output="false" access="public" returntype="any" hint="">
		<cfargument name="selenium" type="any" required="true" />
		<cfargument name="executionDelay" type="numeric" required="false" default="200"/>
		<cfargument name="seleniumJarPath" type="string" required="false" default="/CFSelenium/Selenium-RC/selenium-server-standalone-2.2.0.jar"/>
		<cfargument name="verbose" type="boolean" required="false" default="false"/>
		<cfargument name="seleniumServerArguments" type="string" required="false" default=""/>
	
		<cfset structAppend(variables, arguments)>
		<cfset variables.iStartedThisServer = false> 
			
		<cfreturn this>
	</cffunction>

	<cffunction name="startServer" output="false">
		<cfset var jarPath = "">
		<cfset var loopStart = getTickCount()>
		<cfif not serverIsRunning()>
			<cfset jarPath = "#expandPath(variables.seleniumJarPath)#">
			<cfif NOT FileExists(jarPath)>
				<cfset jarPath = variables.seleniumJarPath>
				<cfif ListFirst(jarPath,"/") EQ "CFSelenium">
						<cfset jarPath = ListDeleteAt(jarPath,1,"/")>
				</cfif>
				<cfif Left(jarPath,1) EQ "/">
					<cfset jarPath = Right(jarPath,Len(jarPath)-1)>
				</cfif>
				<cfset jarPath = "#getDirectoryFromPath(getCurrentTemplatePath())##jarPath#">
			</cfif>
			<cfif NOT FileExists(jarPath)>
				<cfthrow message="Unable to find jar file #variables.seleniumJarPath#.">
			</cfif>
			
			<cfset isRunning = false>
			<cfset args = "-jar ""#jarPath#"" #variables.seleniumServerArguments#">
			<cfset logStatus( text="!!!!    STARTING Selenium RC with jar path: #jarPath#!  args were: #args#." )/>
			
			<!---<cfexecute name="C:\ColdFusion9\runtime\jre\bin\java.exe #args#"/>--->
			<cfexecute name="#getDirectoryFromPath(getCurrentTemplatePath())#selenium-jar.bat"/>
			
			<!--- we need to give the server time to fully start --->
			<cfloop condition="NOT serverIsRunning()">
				<cfset sleep(variables.executionDelay)/>
				<cfif getTickCount() - loopStart GT 30000>
					<cfthrow message="After 30 seconds selenium server still not started">
				</cfif>
			</cfloop>
			<cfset variables.iStartedThisServer = true>
			<cfset logStatus( text="  Startup took #getTickCount()-loopStart# ms" )/>
		</cfif>
	</cffunction>

	<cffunction name="stopServer" output="false">
		<cfset var loopStart = getTickCount()>
		<!--- we only stop the server if we started it --->
		<cfif variables.iStartedThisServer>
			<cfset variables.selenium.shutDownSeleniumServer() />
			<!--- we need to give the server time to fully shutdown --->
			<cfloop condition="serverIsRunning()">
				<cfset sleep(variables.executionDelay)/>
				<cfif getTickCount() - loopStart GT 30000>
					<cfthrow message="After 30 seconds selenium server still not stopped">
				</cfif>
			</cfloop>
			
			<cfset logStatus( text="!!!!    STOPPED Selenium RC! Took #getTickCount()-loopStart# ms" )/>
		</cfif>
	</cffunction>

	<cffunction name="serverIsRunning" output="false">
		<cfset logStatus( text="!!!!    CHECKING Selenium RC. Are you running?" )>
		<cfreturn variables.selenium.serverIsRunning() />
	</cffunction>
	
	<cffunction name="logStatus" output="false" access="private" returntype="any" hint="">    
    	<cfargument name="text" type="string" required="true"/>
		<cfif variables.verbose>
			<cflog text="#text#">
		</cfif>
    </cffunction>

</cfcomponent>