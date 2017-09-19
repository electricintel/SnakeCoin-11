package data;


class HTMLCode {

	public static var transaction = '
<html>

<head>
	<title>Transaction</title>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script>
		$(document).ready(function() {
			var from, to, amount;
			$("#submit").click(function() {
				from = $("#from").val();
				to = $("#to").val();
				amount = $("#amount").val();

				console.log(from + " " + to + " " + amount);

				$.post("http://localhost:5000/txion", {
					from: from,
					to: to,
					amount: amount
				}, function(data) {
					if (data === "done") {
						alert("Transaction success");
					}
				});
			});
		});

	</script>
</head>

<body>
	<h1>Send Transaction</h1>
	<table>
		<tr>
			<td>From</td>
			<td><input type="TEXT" id="from" size="40"></td>
		</tr>
		<tr>
			<td>To</td>
			<td><input type="TEXT" id="to" size="40"></td>
		</tr>
		<tr>
			<td>Amount</td>
			<td><input type="TEXT" id="amount" size="40"></td>
		</tr>
		<tr>
			<td><input type="button" id="submit" value="Submit"></td>
			<td></td>
		</tr>
	</table>
</body>

</html>
	';
	
}