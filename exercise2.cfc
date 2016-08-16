<cfcomponent name="exercise2">

	<cffunction name="getData" access="private" output="no" returntype="query">
		<cfset var qryData	= QueryNew("fullName,dob,houseNumber,postcode,street,city,country")>
		<cfscript>
			addRow(qryData,	"Aleshia Tomkiewicz",	CreateDate(1980, 4, 22),	89,		"IP25 6JQ",	"Noon St",			"Carbrooke",		"UK");
			addRow(qryData,	"Evan Zigomalas",		CreateDate(1976, 3, 12),	99,		"BH25 5DF",	"Guthrie St",		"New Milton",		"UK");
			addRow(qryData,	"France Andrade",		CreateDate(1992, 10, 1),	7,		"EX39 5DJ",	"Richmond St",		"Parkham",			"UK");
			addRow(qryData,	"Ulysses Mcwalters",	CreateDate(1964, 4, 14),	9165,	"S4 7WN",	"Primrose St",		"Darnall Ward",		"UK");
			addRow(qryData,	"Tyisha Veness",		CreateDate(1949, 1, 28),	9,		"TQ3 1SA",	"Pengwern St",		"Marldon",			"UK");
			addRow(qryData,	"Simona Morasca",		CreateDate(1999, 7, 17),	3,		"44805",	"Mcauley Dr",		"Ashland",			"USA");
			addRow(qryData,	"Mitsue Tollner",		CreateDate(1977, 2, 19),	7,		"60632",	"Eads St",			"Chicago",			"USA");
			addRow(qryData,	"Leota Dilliard",		CreateDate(1992, 10, 30),	7,		"95111",	"W Jackson Blvd",	"San Jose",			"USA");
			addRow(qryData,	"Sage Wieser",			CreateDate(1985, 5, 5),		5,		"57105",	"Boston Ave",		"Sioux Falls",		"USA");
			addRow(qryData,	"Kris Marrier",			CreateDate(1968, 11, 19),	228,	"21224",	"Runamuck Pl",		"Baltimore",		"USA");
			addRow(qryData,	"Apolonia Warne",		CreateDate(1954, 3, 17),	3,		"E3G 0A3",	"E 31st St ##77",	"Fredericton",		"Canada");
			addRow(qryData,	"Chandra Lagos",		CreateDate(1963, 4, 3),		7,		"M8Z 3P6",	"N Dean St",		"Etobicoke",		"Canada");
			addRow(qryData,	"Crissy Pacholec",		CreateDate(1970, 9, 19),	85,		"L4N 6T7",	"S State St",		"Barrie",			"Canada");
			addRow(qryData,	"Gianna Branin",		CreateDate(1990, 12, 28),	100,	"T2K 4X5",	"Main St",			"Calgary",			"Canada");
			addRow(qryData,	"Valentin Billa",		CreateDate(1998, 2, 24),	6185,	"S0C 2C0",	"Bohn St ##72",		"Pangman",			"Canada");
		</cfscript>
		<cfreturn qryData>
	</cffunction>

	<cffunction name="addRow" access="private" output="no" returntype="void">
		<cfargument name="qryData" type="query">
		<cfargument name="fullName" type="string">
		<cfargument name="dob" type="date">
		<cfargument name="houseNumber" type="numeric">
		<cfargument name="postcode" type="string">
		<cfargument name="street" type="string">
		<cfargument name="city" type="string">
		<cfargument name="country" type="string">
		<cfset var i	= "">
		<cfset QueryAddRow(arguments.qryData)>
		<cfloop index="i" list="fullName,dob,houseNumber,postcode,street,city,country">
			<cfset QuerySetCell(arguments.qryData, i, arguments[i])>
		</cfloop>
	</cffunction>

	<cffunction name="lookup" access="remote" output="no" returntype="struct" returnformat="json">
		<cfargument name="fullName" type="string">
		<cfargument name="dob" type="string">
		<cfargument name="houseNumber" type="string">
		<cfargument name="postcode" type="string">
		<cfset var stcResult	= StructNew()>
		<cfset var qryAll		= getData()>
		<cfset var qryFind		= "">
		<cfset stcResult["errCode"]	= 0>
		<cfif NOT isDate(arguments.dob)>
			<cfset stcResult["errCode"]	= 2>
			<cfset stcResult["errMsg"]	= "Date is not valid">
		<cfelseif NOT isNumeric(arguments.houseNumber)>
			<cfset stcResult["errCode"]	= 3>
			<cfset stcResult["errMsg"]	= "House number must be numeric">
		<cfelse>
			<cfquery dbtype="query" name="qryFind">
				SELECT street, city, country
				FROM qryAll
				WHERE fullName		= <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.fullName#">
					AND dob			= <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.dob#">
					AND houseNumber	= <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.houseNumber#">
					AND postcode	= <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.postcode#">
			</cfquery>
			<cfif qryFind.RecordCount NEQ 1>
				<cfset stcResult["errCode"]	= 1>
				<cfset stcResult["errMsg"]	= "Address not found">
			<cfelse>
				<cfset stcResult["street"]	= qryFind.street>
				<cfset stcResult["city"]	= qryFind.city>
				<cfset stcResult["country"]	= qryFind.country>
			</cfif>
		</cfif>
		<cfreturn stcResult>
	</cffunction>

</cfcomponent>
