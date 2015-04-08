// Bloc médiathèque
jQuery(function($) {
	$(".widget-media ul li .link_media, .widget-media ul li .hover_controls a").each(function() {
		var link = $(this);
		var suffix = "#open";
		if(link.parents("li").attr("data-open") === "true") {
			var href = link.attr("href");
			if(href.indexOf(suffix, href.length - suffix.length) === -1) {
				// si l'url ne contient pas déja #open
				link.attr("href", href + suffix);
			}
		}
	});
});

// Ajout et suppression du texte default dans le champ recherche du menu principal
(function($) {
	$.fn.inputdynvalue = function (options) {
		var opts = $.extend({}, $.fn.inputdynvalue.defaults, options);

		return this.each(function(){
			// Initialisation de l'INPUT (attributs value, class)
			var hvalue = opts.htext;
			switch (opts.htext) {
				case 'title': hvalue = $(this).attr('title'); break;
				case 'value': hvalue = $(this).attr('value'); break;
			}
			$(this).attr('value', hvalue).addClass(opts.hclass)

			// Remise � z�ro des gestionnaires d'�v�nement
			.unbind('focus.dynvalue blur.dynvalue')

			// Ajout et suppression du texte au focus ou � la perte de focus
			.bind('focus.dynvalue', function() {
				if (this.value === hvalue) {
					this.value = '';
					$(this).removeClass(opts.hclass);
				}
			})
			.bind('blur.dynvalue', function() {
				if (this.value === '') {
					this.value = hvalue;
					$(this).addClass(opts.hclass);
				}
			});
		});
	};
	// Arguments par d�faut
	$.fn.inputdynvalue.defaults = {
		htext: 'title',
		hclass: 'input_bg'
	};
})(jQuery);

//<!--show hide -->

function show_hide_pan(param1,param2)
{
	elt=document.getElementById(param1);
	if (elt.style.display == 'none') {
	document.getElementById(param1).style.display='block';
	document.getElementById(param2).className='open';
	}
	else {
	document.getElementById(param1).style.display='none';
	document.getElementById(param2).className='';
	}
}


function hide_menus_a(param1){
	(function(){
	var obj=$('#accordion');
	obj.children('div:not(#'+param1+')').each(function(count){
		$(this).css('display','none');
	});
	obj.children('span.title:not(#'+param1+')').each(function(count){
		$(this).removeClass("open").addClass("close");
	});
	})(jQuery);
}

function show_menu_a(param1,param2){
	hide_menus_a(param1);
	(function(){
	$('#'+param1).css('display','block');
	$('#'+param2).removeClass("close").addClass('open');
	})(jQuery);
}


function show_hide_menu_a(param1,param2)
{	
	hide_menus_a(param1);
	(function(){
	var elt=$('#'+param1);
	if (elt.css('display') == 'none') {
		$('#'+param1).css('display','block');
		$('#'+param2).removeClass("close").addClass('open');
	} else {
		$('#'+param1).css('display','none');
		$('#'+param2).removeClass("open").addClass("close");
	}
	})(jQuery);
}

function show_hide_menu_demarches(param1,param2)
{
	var elt=document.getElementById(param1);
	if (elt.style.display == 'none') {
		document.getElementById(param1).style.display='block';
		$('#'+param2).addClass('open');
		$('#'+param2).removeClass('close');
	} else {
		document.getElementById(param1).style.display='none';
		$('#'+param2).addClass('close');
		$('#'+param2).removeClass('open');
	}
}
/*
function show_hide_menu_a(param1,param2)
{
	elt=document.getElementById(param1);
	obj=document.getElementById('accordion');
	for ( var count = 0; count < obj.childNodes.length; count++ )
        {
            if(obj.childNodes[count].tagName == 'DIV'){
				obj.childNodes[count].style.display='none';
			}
			if(obj.childNodes[count].tagName == 'H5'){
				obj.childNodes[count].className='close';
			}
		}
	
	if (elt.style.display == 'none') {
	document.getElementById(param1).style.display='block';
	document.getElementById(param2).className='open';
	}
	else {
	document.getElementById(param1).style.display='none';
	document.getElementById(param2).className='close';
	}
}*/
function show_hide_list_a(param1,param2)
{
	elt=document.getElementById(param1);
	obj=document.getElementById('accordion');
	for ( var count = 0; count < obj.childNodes.length; count++ )
        {
            if(obj.childNodes[count].tagName == 'DIV'){
				obj.childNodes[count].style.display='none';
			}
			if(obj.childNodes[count].tagName == 'H2'){
				obj.childNodes[count].className='close';
			}
		}
	
	if (elt.style.display == 'none') {
	document.getElementById(param1).style.display='block';
	document.getElementById(param2).className='open';
	}
	else {
	document.getElementById(param1).style.display='none';
	document.getElementById(param2).className='close';
	}
}

function show_hide_deplier_a(param1,param2)
{
	elt=document.getElementById(param1);
	if (elt.style.display == 'none') {
	document.getElementById(param1).style.display='block';
	
	}
	else {
	document.getElementById(param1).style.display='none';
	
	}
}
function show_hide_replier_a(param1,param2)
{
	elt=document.getElementById(param1);
	if (elt.style.display == 'none') {
	document.getElementById(param1).style.display='block';
	document.getElementById(param2).className='close';
	}
	else {
	document.getElementById(param1).style.display='none';
	document.getElementById(param2).className='close';
	}
}
function show_hide_menu_left_a(param1,param2)
{
	elt=document.getElementById(param1);
	if (elt.style.display == 'none') {
	document.getElementById(param1).style.display='block';
	document.getElementById(param2).className='open';
	
	}
	else {
	document.getElementById(param1).style.display='none';
	document.getElementById(param2).className='close';
	
	}
}
/***********************************************************************************************/
function fixColumns(){
				
				var c1 = document.getElementById("colonneA");
				var c2 = document.getElementById("colonneB");
				
				if(c1.offsetHeight && c2.offsetHeight ){
					maxheight=Math.max(c1.offsetHeight,c2.offsetHeight)+'px';
				}
				var max2 = Math.max(c1.offsetHeight,c2.offsetHeight)+'px';				
				c1.style.height = max2;
				c2.style.height = maxheight;	
				
		}
	
function checkAll(field){
	//$(".jqTransformCheckbox").removeClass("jqTransformCheckbox jqTransformChecked").addClass("jqTransformCheckbox");
	for (i = 0; i < field.length; i++){
		if(field[i].checked == true){
			field[i].checked = false ;
			
			$(".jqTransformCheckbox").removeClass("jqTransformCheckbox jqTransformChecked").addClass("jqTransformCheckbox");
		}else{
			field[i].checked = true ;
			$(".jqTransformCheckbox").addClass("jqTransformCheckbox jqTransformChecked");
		}
	}
}

/*******/
function checkForm()
    {
	var regmail = /^[a-z0-9._-]+@[a-z0-9.-]{2,}[.][a-z]{2,3}$/; 
	message="Formulaire invalide : \n";
	pass=true;
        if(document.getElementById("name").value == "")
        {
            message  = message + " - Merci de saisir votre prenom et nom \n";
            pass= false;
        }
		 if(document.getElementById("email").value == "")
        {
		
            message  = message + " - Merci de saisir votre e-mail \n";
            pass= false;
        }else if ((regmail.exec(document.getElementById("email").value) == null)){
		message = message + ' - L\'adresse mail que vous avez indique n\'est pas valide !\n';
		pass= false;
		} 
		 if(document.getElementById("objet").value == "")
        {
            message  = message + " - Merci de selectionner l'objet de votre demande \n";
            pass= false;
        }
		 if(document.getElementById("message").value == "")
        {
            message  = message + " - Merci de saisir votre message \n";
            pass= false;
        }
        if(pass == false){
			alert(message);
		}
		return pass;
    }

 function occurrence(chaine, sousch) {
	 
    var exp=new RegExp(sousch,"g");
    if (exp.test(chaine))
      return true;
    else
      return false;
  }

/**
 *
 * Zoomimage
 * Author: Stefan Petre www.eyecon.ro
 * 
 */
(function($){
	var EYE = window.EYE = function() {
		var _registered = {
			init: []
		};
		return {
			init: function() {
				$.each(_registered.init, function(nr, fn){
					fn.call();
				});
			},
			extend: function(prop) {
				for (var i in prop) {
					if (prop[i] != undefined) {
						this[i] = prop[i];
					}
				}
			},
			register: function(fn, type) {
				if (!_registered[type]) {
					_registered[type] = [];
				}
				_registered[type].push(fn);
			}
		};
	}();
	$(EYE.init);
})(jQuery);
/*
(function($){
	var initLayout = function() {

			$('a#inputDateImg').DatePicker({
			format:'Y/m/d',
			date: $('#inputDate').val(),
			current: $('#inputDate').val(),
			starts: 1,
			position: 'right',
			onBeforeShow: function(){
				$('#inputDate').DatePickerSetDate($('#inputDate').val(), true);
			},
			onChange: function(formated, dates){
				$('#inputDate').val(formated);
				if ($('#closeOnSelect input').attr('checked')) {
					$('#inputDate').DatePickerHide();
				}
			}
		});

	};
	EYE.register(initLayout, 'init');
})(jQuery)*/

