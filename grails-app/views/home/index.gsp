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
		<script src="${resource(dir: 'js', file: 'jquery-ui.min.js')}"></script>
		<script src="${resource(dir: 'js', file: 'jquery.multiselect.min.js')}"></script>
		<div id="query-box">
			<div>
				<h1>SQL Query</h1>
				<table>
					<tr>
						<td>Select table: <select id="tables"></select></td>
						<td>Select columns: <select multiple id="selectOptions"></select></td>
						<td>Count: <input type="checkbox" id="count"></td>
						<td>Limit: <input type="text" id="limit"></td>
					</tr>
				</table>
				<div id="full-helper">
					<h3 style="padding: 10px;">Helper Queries</h3>
					<table style="display: inline;">
						<tr>
							<td>Current column: <select id="selectCol"></select></td>
							<td><button type="button" onclick="checkType()">Column Type</button></td>
							<td><button type="button" onclick="checkVals()">Column Vals</button></td>
							<td><button type="button" onclick="hide()">Hide</button></td>
						</tr>
					</table>
					<div id="helper">
						<h4>Helper Query</h4>
						<div id="helper-query"></div>
						<h4>Results</h4>
						<div id="helper-results"></div>
					</div>
				</div>
				<div style="padding: 10px;">
					<button type="button" onclick="generateSQL()">Generate SQL</button>
				</div>
				<h4>SQL</h4>
				<textarea id="query" rows="4" cols="200" style="width: 95%;"></textarea>
			</div>
			<button type="button" onclick="execute()">Run</button>
			<button type="button" onclick="buildStack()">Build Separate Stack</button>
			<g:form name="stack" controller="home" action="buildStack"></g:form>
			<div id="sql-results-box">
				
			</div>
		</div>
		<script>
			var parsed;
			$(document).ready(function() {
				$("#selectOptions").multiselect();
				$('#helper').hide();
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

			$('#tables').change(function() {
				refreshColumns();
			})
			
			function refreshColumns() {
				var options = "";
				for (i in parsed[$('#tables').val()]) {
					options += "<option value='" + parsed[$('#tables').val()][i] + "'>" + parsed[$('#tables').val()][i] + "</option>";
				}
				$('#selectOptions').find('option').remove().end().append("<option value='*'>*</option>" + options).multiselect("refresh");
				$('#selectCol').find('option').remove().end().append(options);
			}

			function checkType() {
				var query = 'SELECT column_name, data_type FROM information_schema.columns WHERE column_name == "' + $('#selectCol').val() + '";';
				$('#helper-query').html(query);
				$('#helper').show();
				ajax($('#helper-query').text(), true)
			}

			function checkVals() {
				var query = 'SELECT DISTINCT ON (' + $('#selectCol').val() + ') ' + $('#selectCol').val() + ' FROM ' + $('#tables').val() + ' ORDER BY ' + $('#selectCol').val() + ' ASC;';
				$('#helper-query').html(query);
				$('#helper').show();
				ajax($('#helper-query').text(), true)
			}

			function hide() {
				$('#helper').hide();
			}

			function showTables() {
				var query = 'select * from blah;';
				$('#helper-query').html(query);
				$('#helper').show();
				$('#helper-results').html('Test Results');
			}

			function generateSQL() {
				if ($('#selectOptions').val() || $('#count').prop('checked')) {
					var limit = '';
					if (parseInt($('#limit').val()) > 0) {
						limit = ' limit ' + $('#limit').val();
					}
					var cols = "";
					if ($('#count').prop('checked')) {
						cols = 'count(*)';
					} else {
						if ($('#selectOptions').val().indexOf('*') > -1) {
							cols = '*'
						} else {
							cols = $('#selectOptions').val().join(', ');
						}
					}
					var query = 'select ' + cols + ' from ' + $('#tables').val() + limit + ';';
					$('#query').text(query);
				}
			}

			function buildStack() {
				$('#stack').submit()
			}

			function writeHelper(data) {
				var html = "<table><tr>";
				for (i in data[0]) {
					html += "<td>" + i + "</td>"
				}
				html += "</tr>"
				for (i in data) {
					html += "<tr>"
					for (j in data[i]) {
						html += "<td>" + data[i][j] + "</td>"
					}
					html += "</tr>"
				}
				html += "</table>"
				$('#helper-results').html(html)
			}

			function writeTable(data) {
				var html = "<table><tr>";
				for (i in data[0]) {
					html += "<td>" + i + "</td>"
				}
				html += "</tr>"
				for (i in data) {
					html += "<tr>"
					for (j in data[i]) {
						html += "<td>" + data[i][j] + "</td>"
					}
					html += "</tr>"
				}
				html += "</table>"
				$('#sql-results-box').html(html)
			}

			function execute() {
				ajax($('#query').text(), false)
			}

			function ajax(sql, helper) {
				var resp = $.ajax({
					url : '${g.createLink(controller:'home' ,action:'runSQL')}',
					dataType : 'json',
					data : {
						sql: sql
					},
					success : function(data) {
						if (helper) {
							writeHelper(data)
						} else {
							writeTable(data)
						}
					},
					error : function(request, status, error) {
						console.log(request)
						alert(error)
					},
					complete : function() {
					}
				});
			}
		</script>
	</body>
</html>