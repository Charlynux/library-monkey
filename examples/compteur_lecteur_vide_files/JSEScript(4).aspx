// Package BAM_EXTJSMENU / Copyright 2018 Archimed SA / JSE

//loading package...
packages.acknowledge('BAM_EXTJSMENU');

// file: BAM_EXTJSMENU.js

//*****************************
// Construction ExtJS du menu
// Guillaume Jactat - 09/09/2008

//R?visions
//GJ-20090602 : On injecte ?galement une classe refl?tant la position ("colonne" du menu).
//GJ-20090604 : Correction bug incr?ment du num?ro de colonne css. On avait un num?ro diff?rent dans les sous-menus
//GJ-20090730 : Ajout fermeture automatique sur mouseout (pour corriger le probl?me de click non propag? sur des iFrames)
//*****************************
packages.requires('BAM_EXTJS');

// M?thode Asynchrone invoqu?e pour refermer les menus ExtJS quelques millisecondes apr?s la sortie de la souris
function closeMenu(m){
	// Si on a un fils ouvert, on ne ferme pas
	if(m.activeChild && m.activeChild.hidden==false){
		//console.log("Fils ouvert : " + m.activeChild.id);
		return;
	}
	
	// Si la souris est sur le menu, on ne ferme pas (elle a pu repasser dessus durant le timeout)
	if (m.mouseInside){
		return;
	}
	
	// Sinon, on ferme le menu
	m.hide();
	
	// C'est pas fini : on ferme les menus parents
	var currentMenu=m;
	//console.log(typeof(currentMenu.parentMenu));
	
	while(typeof(currentMenu.parentMenu)!="undefined"){
		var parent=currentMenu.parentMenu;
		// Si la souris est sur le parent, on arr?te la fermeture en chaine
		//console.log("Parent.mouseInside=" + parent.mouseInside);
		if(parent.mouseInside){
			return;
		}
		
		// On masque le parent
		parent.hide();
		
		// R?cursivit? : on continue avec le parent (pour arriver ? la racine de proche en proche)
		currentMenu=parent;
	}
}

function constructMenu(e, bRoot, columnCount) { 
  var items = []; 

  // d?claration des variables utilis?es pour le remplacement des espaces encod?s (&nbps;) par des espaces conventionnels
  var espace=String.fromCharCode(160);
  var reg=new RegExp(espace, "g");
  
	// Premier tag "ul"
	if(bRoot){
		Ext.get("Conteneur_LEVEL1").createChild({
			tag:'ul',
			"class":'LEVEL1'
		});
	}
  
  // on retrouve tous les tags li situ?s directement sous le tag courant
  Ext.get(e).select('>li').each( function(loopItem, loopItems, loopIndex) { 
  
	// set current item properties
    var link = this.child('a:first', true); 

    // On retrouve tous les sous-menus (tags ul)
    var s = this.select('>ul'); 
	var currentItem=null;
	
	if(bRoot){
		// A la racine, on souhaite des DIVs plut?t que des objets construits automatiquement par ExtJS
		// (en l'occurence, des boutons ExtJS trop typ?s pour nos besoins)
		
		// Cr?ation du tag "li"
		// GJ-20090303 : Remplacement du &nbsp; par un espace conventionnel sinon, les classes multiples ne sont pas utilisables...
		var espace=String.fromCharCode(160);
	    currentItem = Ext.get("Conteneur_LEVEL1").child('ul').createChild({
			tag:'li',
			"class":"L1 " + link.className.replace(reg, " ") + " column_" + columnCount
		});

		// Cr?ation lien href (dans le center div)
		var anchor=currentItem.createChild({
			tag:"a",
			title:link.title,	// GJ-20090319-INJECTION-INFOBULLE-MENU : ajout info-bulle contenant la description de l'entr?e (pour le niveau racine)
			href:link.href,
			hrefTarget:link.target,
			target:link.target,
			accessKey:loopIndex+1,
			"class":"root_menu"
		});
		
		var currentSpan=anchor.createChild({
			tag:'span'
		});
		currentSpan.dom.innerHTML=link.innerHTML;
		
		// On catche les touches de navigation sur les items
		var nav = new Ext.KeyNav(anchor, {
			"down":function(e){
				onNavigate(e, currentItem, anchor);
			},
			"up":function(e){
				onNavigate(e, currentItem, anchor);
			},
			"left":function(e){
				onNavigate(e, currentItem, anchor);
			},
			"right":function(e){
				onNavigate(e, currentItem, anchor);
			}
		});
		

		// On affiche explicitement le menu lors du mouseover (ce n'est pas le comportement par d?faut, il faut donc le coder explicitement)
		currentItem.on('mouseover', function(){
			if(this.menu){
				if(this.menu.hidden){
					this.menu.show(this);
				}
			}
		});

		currentItem.on('mousemove', function(){
			if(this.menu){
				if(this.menu.hidden){
					this.menu.show(this);
				}
			}
		});

		// On ajoute le DIV s?parateur (si on est pas encore au dernier item)
		if(loopIndex<(loopItems.elements.length-1)){
			$('#Conteneur_LEVEL1 > ul').append('<li class="MenuSpacer"><span>&#160;</span></li>');
		}

	}
	else{
		if(link.innerHTML.toLowerCase()=="<span>-</span>")
		{
			items.push("-");
			return;
		}
	
	    currentItem = {
			title:link.title,	// GJ-20090319-INJECTION-INFOBULLE-MENU : ajout info-bulle contenant la description de l'entr?e (pour les sous-niveaux)
			text: link.innerHTML, 
			cls: link.className.replace(reg, " ") + ' ermes_main_menu_panel_item', 
			id: link.id,
			href:link.href,
			//GJ-20090325-DEBUT : Ajout du target dans le lien HREF construit (utile pour les ev?nements avec target _blank notamment)
			hrefTarget:link.target,
			target:link.target
			// On supprime l'ancien code qui effectuait une navigation en javascript sans tenir compte de l'attribut "target"
			//GJ-20090325-FIN : Ajout du target dans le lien HREF construit (utile pour les ev?nements avec target _blank notamment)
	    };
	}

	// S'il y a des fils, on traite dans l'arbo (g?n?ration du sous-menu)
    if (s.elements.length) { 
		var m=new Ext.menu.Menu({
			cls:"ermes_main_menu_panel column_" + columnCount,	// GJ-20090602 : On injecte ?galement une classe refl?tant la position ("colonne" du menu).
			items: constructMenu(s.item(0), false, columnCount),
			myAnchor:anchor
		}); 
		
		// Gestion de la fermeture automatique quand la souris sort
		var autohidemenu_el = m.getEl();
		autohidemenu_el.hover(
			function(e) { 
				//console.log("mouseenter : id=%s",m.id);
				m.mouseInside=true;
				return true;
			},
			function(e) { 
				//console.log("mouseleave : id=%s",m.id);
				m.mouseInside=false;
				window.setTimeout(function(){closeMenu(m);}, 800);
			},
			this
		); 	
		
		var dummy=new Ext.KeyNav(autohidemenu_el, {
			"esc":function(e){
				m.myAnchor.focus();
			}
		});
		
		// On associe le currentItem (le div) avec son menu (pour pouvoir le retrouver par la suite)
		currentItem.menu=m;
    }
	items.push(currentItem);
	
	// On augmente le num?ro de colonne car on passe sur l'entr?e de menu suivante
	if(bRoot){
		columnCount++;	
	}
  }); 

  return items; 
}


// Callback appel? lors de l'activation d'une touche de navigation sur une entr?e de menu de niveau 1
function onNavigate(e, sender, anchor){

	if(!sender) return;
	if(!sender.menu) return;

	var k=e.keyCode;
	switch(k){
		// Fleche du haut : on masque le menu
		case Ext.EventObject.ESC:
			sender.menu.hide();
			sender.menu.myAnchor.focus();	// On redonne le focus au menu de niveau 0 associ? pour pouvoir reprendre la navigation clavier facilement
			break;
		// Fleche du bas : on affiche le menu
		case Ext.EventObject.DOWN:
			sender.menu.show(sender);
			break;
	}
}

// Point d'entr?e (DOM Ready)
$(document).ready(function(){
	// Si la structure ul/li contenant le menu n'existe ps, on s'arr?te l?.
	// Cette structure est construite par le GUI.xsl et est affich? telle qu'elle si on est mode ROBOT
    if(!Ext.get("ermes_main_menu")){
        return;
    }
	
   // Construction du menu
   // On passe en param?tre "ermes_main_menu" qui est l'identifiant unique du DIV destin? ? recevoir le r?sultat.
   // Ce div est d?clar? dans la banni?re (dans le GUI.xsl)
   constructMenu("ermes_main_menu", true, 0);
   Ext.get("Conteneur_LEVEL1").show(); 
   //Ext.get("ermes_main_menu").remove(); 
   
}); 

$(document).ready(function(){
	$('#wai_open_link').click(function(){
		Ext.get('extDialogWaiSelector').fadeIn();
		Ext.get('extDialogWaiSelector').anchorTo(Ext.get('wai_eye'),"tr-bl", [0,0]);
	});
	
	$('#wai_close_link').click(function(){
		$('#extDialogWaiSelector').fadeOut("fast");

		// GJ-20081119 : Rechargement des iFrames pour voir le r?sultat
		Ext.select('iframe').each(function(){
			this.dom.contentWindow.location.reload(true);
		});		
	});
});
		



// [EOF] for file BAM_EXTJSMENU.js

//package loaded!
packages.complete('BAM_EXTJSMENU');

// Served in 223 ms