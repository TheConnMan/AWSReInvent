<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Home</title>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'sql.css')}" type="text/css">
	</head>
	<body>
		<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
		<div id="query-box">
			<div>
				<h1>SQL Query</h1>
				<h3>Type</h3>
				<table>
					<tr>
						<td><input type="text" name="tablename"></td>
						<td><button type="button">Describe</button></td>
						<td><button type="button">Show Indexes</button></td>
						<td><button type="button">Select 10</button></td>
						<td><button type="button">Count</button></td>
						<td><button type="button">Show Tables</button></td>
						<td><button type="button">Show Processes</button></td>
					</tr>
				</table>
				<h4>SQL</h4>
				<textarea rows="4" cols="200"></textarea>
			</div>
			<button type="button">Run</button>
			<div id="sql-results-box">
				<table id="sql-results">
					<tr>
						<td>Test</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>