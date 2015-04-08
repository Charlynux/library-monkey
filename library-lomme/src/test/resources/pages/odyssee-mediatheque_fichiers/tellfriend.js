//common/contentTop/share.jsp
jQuery.fn.fadeToggle = function(speed, easing, callback) {
	return this.animate({
		opacity : 'toggle'
	}, speed, easing, callback);
};

jQuery(document).ready(function() { 	
	
	$('body').click(function() {
		if ($("#ombrePopin").css("display")=="block"){
		fermerForm();
		fermerMailSent();		
		}	
	});
	$('#Envoyer').click(function(event){
	event.stopPropagation();
	});
	$('#zoom').click(function(event){
	event.stopPropagation();
	});
	$('#tellfriend').click(function(event){
		event.stopPropagation();
		});
	$('#tellfriendMailSent').click(function(event){
		event.stopPropagation();
		});
});

function declencherForm(){
		
		$("#tellafriend_form").validationEngine();	
		window.setTimeout(function(){$("#ombrePopin").show();
		$("#tellfriend").show();},100);
		
}

function fermerForm(){
	$("#ombrePopin").hide();
	$("#tellfriend").hide();
	$(".formError").remove();
	$("#tellafriend_form").validationEngine();
	
}


function fermerMailSent(){
	$("#ombrePopin").hide();
	$("#tellfriendMailSent").hide();
		
}

$(document).ready(function() {
	$('#tellfriend').hide();	
});
