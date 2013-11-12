<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Home</title>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'sql.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.multiselect.css')}" type="text/css">
	</head>
	<body>
		<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
		<script src="${resource(dir: 'js', file: 'sql.js')}"></script>
		<script src="${resource(dir: 'js', file: 'jquery-ui.min.js')}"></script>
		<script src="${resource(dir: 'js', file: 'jquery.multiselect.min.js')}"></script>
		<div id="query-box">
			<div>
				<h1>SQL Query</h1>
				<h3>Type</h3>
				<table>
					<tr>
						<td>Table Name: <input type="text" id="tablename"></td>
						<td><button type="button" onclick="ajax('${g.createLink(controller:'home',action:'queryDB')}')">Describe</button></td>
						<td><button type="button">Show Indexes</button></td>
						<td>Select table: <select id="tables"></select></td>
						<td>Select columns: <select multiple id="selectOptions"></select></td>
						<td>Count: <input type="checkbox" id="count"></td>
						<td>Limit: <input type="text" id="limit"></td>
						<td><button type="button" onclick="showTables()">Show Tables</button></td>
						<td><button type="button">Show Processes</button></td>
					</tr>
				</table>
				<button type="button" onclick="generateSQL()">Generate SQL</button>
				<div id="helper" style="display: none;">
					<h4>Helper Query</h4>
					<div id="helper-query"></div>
					<h4>Results</h4>
					<div id="helper-results"></div>
				</div>
				<h4>SQL</h4>
				<textarea id="query" rows="4" cols="200"></textarea>
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
		<script>
			var parsed;
			$(document).ready(function() {
				$("#selectOptions").multiselect();
				var tables = '${tables}'
				var tables2 = tables.split('&quot;').join('"')
				parsed = $.parseJSON(tables2)
				var options = ""
				for (i in parsed) {
					options += "<option value='" + i + "'>" + i + "</option>";
				}
				$('#tables').find('option').remove().end().append(options);
				refreshColumns();
			});

			$('#tables').change(refreshColumns())
			
			function refreshColumns() {
				var options = "<option value='*'>*</option>";
				for (i in parsed[$('#tables').val()]) {
					options += "<option value='" + parsed[$('#tables').val()][i] + "'>" + parsed[$('#tables').val()][i] + "</option>";
				}
				$('#selectOptions').find('option').remove().end().append(options).multiselect("refresh");
			}
			
		</script>
	</body>
</html>