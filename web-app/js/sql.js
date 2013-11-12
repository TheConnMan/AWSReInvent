function addLimit(query, num) {
	
}

function showTables() {
	var query = 'select * from blah;';
	$('#helper-query').html(query);
	$('#helper').css('display', 'block');
	$('#helper-results').html('Test Results');
}

function generateSQL() {
	if ($('#selectOptions').val()) {
		var limit = '';
		if (parseInt($('#limit').val()) > 0) {
			limit = ' limit ' + $('#limit').val();
		}
		var query = 'select ' + $('#selectOptions').val().join(', ') + ' from ' + $('#tables').val() + limit + ';';
		$('#query').val(query);
	}
}

function ajax(url) {
	var resp = $.ajax({
		url : url,
		dataType : 'json',
		data : {
			
		},
		success : function(data) {
			//ajaxObject = data[0].root
			console.log(data)
		},
		error : function(request, status, error) {
			console.log(request)
			alert(error)
		},
		complete : function() {
			ajaxComplete(ajaxObject)
			$.unblockUI()
		}
	});
}