<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flight Search</title>
</head>
<body>
	<h2>Search For Flights</h2>
	<form action="searchFlight.jsp" method="post">
		<div id="oneWay/RoundTripDiv">
			<select name="oneWay/RoundTrip" id="oneWay/RoundTrip">
				<option value="one way">One Way</option>
				<option value="round trip">Round Trip</option>
			</select>
		</div>
		<div id="departFromDiv" style="display: inline-block;">
			Depart From: <input type="text" name="depart" list="airports"
				placeholder="Depart From"></input>
		</div>
		<div id="arriveAtDiv" style="display: inline-block;">
			Arrive At: <input type="text" name="arrive" list="airports"
				placeholder="Arrive At"></input>
		</div>
		<div id="departDateDiv">
			Depart <input type="date" name="departDate"> <span
				id="returnDateSpan"> Return <input type="date"
				name="returnDate" id="returnDate">
			</span>
		</div>
		<div id="flexibility">
			Flexibility (+/- 3 Days)? <input type="checkbox" name="flexibility"
				value="yes">
		</div>
		<div id="search">
			<input type="submit" value="search">

		</div>


	</form>


	<script>
		const dropdownSelect = document.getElementById("oneWay/RoundTrip");
		const returnDate = document.getElementById("returnDateSpan");
		const returnDateInput = document.getElementById("returnDate");

		function updateDropdown() {
			if (dropdownSelect.value == "one way") {
				returnDate.style.display = "none";
				returnDateInput.value = "";
			} else if (dropdownSelect.value == "round trip") {
				returnDate.style.display = "inline-block";
			}
		}

		dropdownSelect.addEventListener('change', updateDropdown);

		updateDropdown();
	</script>





	<datalist id="airports">
		<option value="ATL" label="Atlanta, GA"></option>
		<option value="LAX" label="Los Angeles, CA"></option>
		<option value="DFW" label="Dallas, TX"></option>
		<option value="DEN" label="Denver, CO"></option>
		<option value="ORD" label="Chicago, IL"></option>
		<option value="JFK" label="New York City, NY"></option>
		<option value="MCO" label="Orlando, FL"></option>
		<option value="LAS" label="Las Vegas, NV"></option>
		<option value="CLT" label="Charlotte, NC"></option>
		<option value="MIA" label="Miami, FL"></option>
		<option value="SEA" label="Seattle and Tacoma, WA"></option>
		<option value="EWR" label="Newark, NJ"></option>
		<option value="SFO" label="San Francisco, CA"></option>
		<option value="PHX" label="Phoenix, AZ"></option>
		<option value="IAH" label="Houston, TX"></option>
		<option value="BOS" label="Boston, MA"></option>
		<option value="FLL" label="Fort Lauderdale, FL"></option>
		<option value="MSP" label="Minneapolis and Saint Paul, MN"></option>
		<option value="LGA" label="New York City, NY"></option>
		<option value="DTW" label="Detroit, MI"></option>
		<option value="PHL" label="Philadelphia, PA"></option>
		<option value="SLC" label="Salt Lake City, UT"></option>
		<option value="BWI" label="Baltimore and Washington, D.C., MD"></option>
		<option value="DCA" label="Washington, D.C., VA"></option>
		<option value="SAN" label="San Diego, CA"></option>
		<option value="IAD" label="Washington, D.C., VA"></option>
		<option value="TPA" label="Tampa, FL"></option>
		<option value="BNA" label="Nashville, TN"></option>
		<option value="AUS" label="Austin, TX"></option>
		<option value="MDW" label="Chicago, IL"></option>
	</datalist>

</body>
</html>