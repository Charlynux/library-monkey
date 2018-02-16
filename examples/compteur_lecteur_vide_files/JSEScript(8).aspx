// Package BAM_GOOGLESPELL / Copyright 2018 Archimed SA / JSE

//loading package...
packages.acknowledge('BAM_GOOGLESPELL');

// file: GoogleSpell.js

Ext.onReady(function(){
	Ext.select('input.googlespell').each(function(){
		new GoogleSpell(this);
	});
});

function GoogleSpell(obj){
	var objInput=obj;
	var divLogo=null;
	var divSpell=null;

	objInput.on('keypress', keyPressed);
	objInput.on('keyup', textChanged, objInput, {buffer: 400});
	
	function jsonSuccess(response, options){
		var json=Ext.decode(response.responseText);
		if(json.query){
			if(divSpell)
				divSpell.hide();
				
			// Construction du div contenant le lien de correction (label corrig?)
			divSpell=Ext.getBody().createChild({
				tag:'div',
				"class":'divSpell'
			});
			
			// Construction du div contenant le logo indiquant qu'une correction est disponible
			if(divLogo)
				divLogo.hide();

			divLogo=Ext.getBody().createChild({
				tag:'div',
				"class":'DYM_ICON_FAILED'
			});
			
			// Placement des 2 divs
			divSpell.anchorTo(options.sender,'tr', [2,0]);
			divLogo.anchorTo(options.sender,'tr', [-12,2]);
			
			// Ajout event handler sur le div logo (affichage du div avec phrase corrig?e)
			divLogo.on('click', function(){
				this.hide();
				divSpell.show({duration:0.5});
				//divSpell.fadeOut({duration:5});
			});	
			divLogo.show();

			// RAZ du div "phrase corrig?e"
			divSpell.dom.innerHTML='';
			
			// Ajout du div de fermeture 
			var divClose=Ext.get(divSpell).createChild({
				tag:'div',
				href:'#',
				"class":'closeSpell'
			});
			
			// Event handler fermeture div suggestion
			divClose.on('click', closeDiv, this, {sender:divSpell});
			
			// Cr?ation lien href
			var anchor=Ext.get(divSpell).createChild({
				tag:'a',
				href:'#'
			});
			anchor.dom.innerHTML=json.html;
			anchor.on('click', selectSuggest, this, {sender:options.sender, query:json.query});
		}
		else{
			if(divSpell)
				divSpell.fadeOut();
		}
	}
	
	function keyPressed(e,sender){
		if(divLogo)
			divLogo.hide();
		if(divSpell)
			divSpell.hide();
	}

	function textChanged(e,sender){
		var k=e.keyCode;
		switch(k){
			case Ext.EventObject.UP:
				return;
				break;
			case Ext.EventObject.DOWN:
				return;
				break;
			case Ext.EventObject.LEFT:
				return;
				break;
			case Ext.EventObject.RIGHT:
				return;
				break;
			case Ext.EventObject.CONTROL:
				return;
				break;
			case Ext.EventObject.SHIFT:
				return;
				break;
			case Ext.EventObject.ESC:
				if(divSpell)
					divSpell.hide();
				return;
				break;
		}

		var json=Ext.Ajax.request({
			url:'/medias/AjaxProxy/GoogleSuggest.ashx?q='+encodeURI(sender.value),
			failure:jsonFailure,
			success:jsonSuccess,
			sender:sender		// On garde trace du sender pour le callback
		});
	}

	function closeDiv(e, sender, options){
		options.sender.hide();
	}
	function selectSuggest(e, sender, options){
		options.sender.value=unescape(options.query);
		if(divSpell)
			divSpell.hide();
		if(divLogo)
			divLogo.hide();
	}

	function jsonFailure(response, options){
		try{
			//console.info("La requ?te suivante a ?chou? : %s", options.url);
		}
		catch(e){
		}
	}
}				


// [EOF] for file GoogleSpell.js

//package loaded!
packages.complete('BAM_GOOGLESPELL');

// Served in 4 ms