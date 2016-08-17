$(function(){
	$('.e2-datepicker').datepicker({
		format: 'dd/mm/yyyy',
		todayHighlight: true,
		autoclose: true
	});
	$('#e2-btn-lookup').click(function(){
		$.getJSON(
			'exercise2.cfc',
			{
				method		: 'lookup',
				fullName	: $('#fullName').val(),
				dob			: $('#dob').val(),
				houseNumber	: $('#houseNumber').val(),
				postcode	: $('#postcode').val()
			},
			function (data){
				if(data.errCode > 0){
					$('#e2-dynamic').hide();
					if(!$('#e2-msgbox').length){
						$('<div id="e2-msgbox" class="alert alert-danger" role="alert"></div>').insertAfter('#e2-dynamic');
					}
					$('#e2-msgbox').html(data.errMsg).show();
				}else{
					$('#e2-msgbox').hide();
					$('#street').val(data.street);
					$('#city').val(data.city);
					$('#country').val(data.country);
					$('#e2-dynamic').show();
				}
			}
		);
	});
	$('#e2-btn-fill').click(function(){
		$.getJSON(
			'exercise2.cfc',
			{
				method		: 'fill'
			},
			function (data){
				$('#e2-msgbox').hide();
				$('#e2-dynamic').hide();
				$('#fullName').val(data.fullName)
				$('#dob').val(data.dob)
				$('#houseNumber').val(data.houseNumber)
				$('#postcode').val(data.postcode)
				$('#street').val('');
				$('#city').val('');
				$('#country').val('');
			}
		);
	});
});
