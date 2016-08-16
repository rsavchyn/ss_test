<cfoutput><h1>Exercise 1</h1></cfoutput>
<cfif StructKeyExists(FORM, "userData")>
	<cfset arr		= ArrayNew(1)>
	<cfset pivot	= 0><!--- positive - index of pivot element; zero - no pivot; negative - error --->
	<cfset arrTotal	= 0>
	<!--- parse user data --->
	<cfloop index="i" list="#FORM.userData#">
		<cfif isNumeric(i)>
			<cfset ArrayAppend(arr, i)>
			<cfset arrTotal = arrTotal + i>
		<cfelse>
			<cfset pivot = -1><!--- Invalid input --->
			<cfbreak>
		</cfif>
	</cfloop>
	<!--- find pivot --->
	<cfif pivot EQ 0>
		<cfset arrLen = ArrayLen(arr)>
		<cfif arrLen GT 2><!--- to have pivot, array must be at least 3 elements long --->
			<cfset pivotSum = arr[1]>
			<cfloop index="i" from="2" to="#(arrLen-1)#"><!--- first and last elements cannot be pivot by definition --->
				<cfif (arrTotal - arr[i]) EQ pivotSum * 2>
					<cfset pivot = i>
					<cfbreak>
				<cfelse>
					<cfset pivotSum = pivotSum + arr[i]>
				</cfif>
			</cfloop>
		</cfif>
	</cfif>
	<!--- output results --->
	<cfif pivot LT 0>
		<cfoutput><p style="color:red;">Your input is incorrect. Please enter comma-separated list of numbers. For example, 5,9,7,17,6,5,4,6</p></cfoutput>
	<cfelse>
		<cfoutput>
		<style>
			td{text-align:center; padding:3px 10px;}
		</style>
		<table cellpadding="0" cellspacing="0" border="1">
		<tr><cfloop index="i" from="1" to="#arrLen#">
			<td<cfif i EQ pivot> style="font-weight:bold; color:green;"</cfif>>#arr[i]#</td></cfloop>
		</tr>
		<cfif pivot EQ 0>
			<tr><td colspan="#arrLen#">Array has no pivot</td></tr>
		<cfelse>
			<tr>
				<td colspan="#(pivot - 1)#">Sum = #pivotSum#</td>
				<td>Pivot</td>
				<td colspan="#(arrLen - pivot)#">Sum = #pivotSum#</td>
			</tr>
		</cfif>
		</table>
		</cfoutput>
	</cfif>
</cfif>
<cfoutput>
<h2>Please enter data</h2>
<form action="" method="post">
	<label for="userData">Array of numbers:</label>
	<input type="text" name="userData" id="userData" size="80" value="" placeholder="Please enter comma-separated list of numbers">
	<input type="submit" value="Submit">
</form>
<h2>Notes to excercise:</h2>
<ol>
	<li>
		Code finds only first of multiple pivots. <small style="color:gray;">Fill free to contact developer to implement feature of calculating multiple pivots ;)</small><br>
		Example of array with multiple pivots:	1,0,0,0,0,0,0,1 - all zeros are pivots
	</li>
	<li>
		Elements at first or last positions are ignored.<br>
		For example,<br>
		100,3,-3 considered as having no pivot as it is subject to discuss whether sum of elements placed left to 100 is zero or null/undefined<br>
		Similary for sum of elements placed right to 100 in arrays like -3,3,100<br>
	</li>
</ol>
</cfoutput>
