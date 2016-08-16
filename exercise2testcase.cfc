<cfcomponent extends="mxunit.framework.TestCase">

	<!--- this will run before every single test in this test case --->
	<cffunction name="setUp" returntype="void" access="public" hint="put things here that you want to run before each test">
		<cfset obj = createObject("component", "exercise2")>
	</cffunction>

	<!--- this will run after every single test in this test case --->
	<cffunction name="tearDown" returntype="void" access="public" hint="put things here that you want to run after each test">
	</cffunction>

	<!--- this will run once after initialization and before setUp() --->
	<cffunction name="beforeTests" returntype="void" access="public" hint="put things here that you want to run before all tests">
		<cfset obj = createObject("component", "exercise2")>
	</cffunction>

	<!--- this will run once after all tests have been run --->
	<cffunction name="afterTests" returntype="void" access="public" hint="put things here that you want to run after all tests">
	</cffunction>

	<!---
		TESTS
	--->
	<cffunction name="lookup_should_care_on_fullName" returntype="void" access="public">
		<cfset var result = obj.lookup(
			fullName	= "Joe Doe",
			dob			= CreateDate(1985, 5, 5),
			houseNumber	= 5,
			postcode	= "57105"
		)>
		<cfset assertEquals(1, result.errCode, "result.errCode should've been '1' but was #result.errCode#")>
	</cffunction>

	<cffunction name="lookup_should_care_on_DOB" returntype="void" access="public">
		<cfset var result = obj.lookup(
			fullName	= "Sage Wieser",
			dob			= CreateDate(1985, 5, 1),
			houseNumber	= 5,
			postcode	= "57105"
		)>
		<cfset assertEquals(1, result.errCode, "result.errCode should've been '1' but was #result.errCode#")>
	</cffunction>

	<cffunction name="lookup_should_care_on_houseNumber" returntype="void" access="public">
		<cfset var result = obj.lookup(
			fullName	= "Sage Wieser",
			dob			= CreateDate(1985, 5, 5),
			houseNumber	= 999,
			postcode	= "57105"
		)>
		<cfset assertEquals(1, result.errCode, "result.errCode should've been '1' but was #result.errCode#")>
	</cffunction>

	<cffunction name="lookup_should_care_on_postalcode" returntype="void" access="public">
		<cfset var result = obj.lookup(
			fullName	= "Sage Wieser",
			dob			= CreateDate(1985, 5, 5),
			houseNumber	= 5,
			postcode	= "99999"
		)>
		<cfset assertEquals(1, result.errCode, "result.errCode should've been '1' but was #result.errCode#")>
	</cffunction>

	<cffunction name="lookup_should_find_Boston_Ave_Sioux_Falls_USA" returntype="void" access="public">
		<cfset var result = obj.lookup(
			fullName	= "Sage Wieser",
			dob			= CreateDate(1985, 5, 5),
			houseNumber	= 5,
			postcode	= "57105"
		)>
		<cfif result.errCode GT 0>
			<cfset fail("lookup service returned error")>
		</cfif>
		<cfset assertEquals("Boston Ave, Sioux Falls, USA", "#result.street#, #result.city#, #result.country#", "result should've been 'Boston Ave, Sioux Falls, USA' but was #result.street#, #result.city#, #result.country#")>
	</cffunction>

</cfcomponent>
