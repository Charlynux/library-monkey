// Package POPUPS / Copyright 2018 Archimed SA / JSE

//loading package...
packages.acknowledge('POPUPS');

// file: POPUPS.js

/* history
 *
 * TODO:
 *	- v?rifier que la popup properties a un r?el int?ret, ce n'est qu'une iframe!
 *	- commenter et corriger le reste du code: calendar
 *	- corriger le bug de la popup prompt sous Mozilla: y mettre le focus ne place pas correctement la popup dans le document
 *      - Pour les popups calendar, on a besoin du package UILIB !! Modifier le fichier package ??
 *
 * version 1.5.0 - 23 mars 2007
 * - New Feature, gestion des images dans les options de la selectbox avec correction sur la selection avec les touches, + prise en charge 
 *   des options sans image avec utilisation d'une image vide a la place, on peut fixer la taille des images vides grace a l'attribut imgWidth.
 *
 * version 1.4.9 - 20 novembre 2006
 * - New Feature, gestion du focus lorsque le controle select ou dateSelector se trouve dans un xform.
 *
 * version 1.4.8 - 16 juin 2006
 * - New Feature, ajout du focus sur les select box et gestion de la manipulation par le clavier.
 *
 *
 * version 1.4.7 - 28 avril 2006
 * - New Feature, ajout de la propri?t? textMode sur les JSDateSelector 
 *				  permettant la saisie direct d'une date.
 *
 * version 1.4.6 - 11 avril 2006
 * - New Feature, ajout de la propri?t? dropUp sur les JSSelect, JSDateSelector 
 *				  et JSPopupButton permettant l'affichage de la popup (boite de s?lection pour un select)
 *				  au dessus du controle.
 *
 * version 1.4.5 - 22 f?vrier 2006
 * - Correction lors d'un back sur le navigateur, le select ne se replacer pas sur la valeur precedente. 
 *
 * version 1.4.4 - 2 f?vrier 2006
 * - New Feature, gestion d'un etat si le controle a ?t? modifier par l'utilisateur (Propri?t? state et ?v?nement associ? onStateChange)
 *				  Correction sur des bugs de redimensionnement des select sous Mozzilla et IE lorsqu'on modifie dynamiquement les options en script. 
 *
 * version 1.4.3 - 24 janvier 2006
 * - New Feature, gestion du mode required sur les select et dateSelector
 *				  ajout methode reset pour reinitialiser un select ou un dateSelector
 *
 * version 1.4.2 - 21 Octobre 2005
 * - correction sur l'affichage des select quand celui-ci est vide, et quand on ajout ou supprime des options.
 *
 * version 1.4.1 - 12 Avril 2005
 * - gestion du scroll lors de l'affichage du select apres avoir scroller la page
 *
 * version 1.4 11/2003
 *  - gestion des language RTL et LTR
 *
 * version 1.3 01/2003
 *	- les fenetres bougent
 * 	- support des attributs left et top
 *
 * version 1.2 12/2002 Tof
 *	- ajout de commentaires
 *	- cr?ation plus souple des fenetres: prise en charge des attributs titlebar, titlebarIcon, closeButton
 *	- quand titre ind?fini, undefined n'est plus affich? dans la barre de titre
 *	- support des classes pour g?rer le style: JSPOPUP, JSPOPUP_TITLE, JSPOPUP_FOOT
 *	- cr?ation de la popup confirm
 *	- cr?ation de boutons par d?faut pour les popup du type warning, confirm, prompt. Support de l'attribut defaultButtons
 *	- correction du bug des iframes pour Netscape
 *	- correction du centrage des popups pour Mozilla et Netscape
 *	- correction du scroll horizontal sous IE et prise en charge du scroll sous Mozilla et Netscape
 *	- am?lioration du support de l'animation (la routine ne tourne plus constamment)
 *	- mise en commentaire des m?thodes show, hide et getValue qui ne font pas de traitement particulier car h?rit?es de JSEUIObject
 *
 * version 1.1 07/2002 Krzys
 * 	
 */


/******** test si la version de ce fichier est compatible avec le package DOMCORE *******/

var popups=new JSEPopups();
var popupsModalDiv=document.createElement('div');
popupsModalDiv.id='JSEPopupsModalDiv';
popupsModalDiv.style.backgroundColor='#000000';
popupsModalDiv.style.position = 'absolute';
popupsModalDiv.style.left='0px';
popupsModalDiv.style.top='0px';

if (JSisMZ)
    popupsModalDiv.style.opacity=0.0;
else
	popupsModalDiv.style.filter='alpha(opacity=0)';
popupsModalDiv.style.display = 'none';	
	
try
{
	if (!JSGetPropertyInfo('move')) 
		alert('POPUPS version 1.3: la version du package DOMCORE doit etre au minimum 1.3 !!!');
}
catch(e)
{
	alert('POPUPS version 1.3: la version du package DOMCORE doit etre au minimum 1.3 !!!');
}



/************************* les fonctions associ?es ? la mobilit? des popups *********************/

/* L'id?e initiale ?tait d'utiliser un "ghost" (une fenetre vide) pour ?viter de devoir bouger
   des popups trop charg?es (en particulier les iframe). Ca ne marche que sous IE, pour mozilla
   on bouge la popup dans sa totalit?.
   Finalement on abandonne pour l'instant l'id?e d'un ghost car quand le popup est plus grand que la taille sp?cifi?e
   ? cause de son contenu, on r?cup?re des dimensions erronn?es ce qui engendre des bugs lors du dimensionnement
   du ghost */

/*
 * ?l?ment m?morisant des informations relatives ? la popup qui bouge
 */
function POPUPS_MOVING()
{
	this.popup=null;
	
	// on m?morise le d?calage du clic ? l'int?rieur de la fenetre
	this.offsetX=0; 
	this.offsetY=0;
	this.interceptedObject=new Array();
	this.bodyScrollWidth=0;
	this.bodyScrollHeight=0;
	this.firstOnMove=true;
}


var popupMoving = new POPUPS_MOVING(); 


/*
 * pour d?marrer le processus de mobilit?
 *
 * @param id(string) identifiant du popup
 *
 */
function POPUPSStartMove(id, e)
{
	// on m?morise les infos de la fenetre qui va bouger
	// il ne faut pas oublier de prendre en compte le scroll de la page
	popupMoving.popup = popups.get(id);
	var container = popupMoving.popup.container;	
				
	if (JSisMZ)
	{	
		container.style.opacity=0.5;
		popupMoving.offsetX = window.scrollX + e.clientX - parseInt(container.style.left); // c'est une chaine de caract?res (ex: 129px)
		popupMoving.offsetY = window.scrollY + e.clientY - parseInt(container.style.top);
	}
	else
	{
		container.style.filter='alpha(opacity=50)';		
		popupMoving.offsetX = document.body.scrollLeft + event.clientX - parseInt(container.style.left);
		popupMoving.offsetY = document.body.scrollTop + event.clientY - parseInt(container.style.top);
	}
		
    popupMoving.bodyScrollWidth=document.body.scrollWidth;
    popupMoving.bodyScrollHeight=document.body.scrollHeight;
    popupMoving.firstOnMove=true;
	// on intercepte l'?v?nement onmousemove	
	document.onmousemove = POPUPSOnMove;
	document.onmousewheel = POPUPSOnMove;
	
	// on empeche la surbrillance bleue de s?lection de texte
	if (JSisIE) document.onselectstart=new Function ("return false");
	if(popups.interceptedObject.length>0)
	{
	    for(var i=0;i<popups.interceptedObject.length;i++)
	    {
	        var x=0,y=0;
	        var obj=popups.interceptedObject[i];
	        if(JSisMZ)
	        {										
		        x+=obj.offsetLeft;
		        y+=obj.offsetTop;			       		 
	        }
	        else
	        {			
		        x+=obj.offsetLeft+(obj.tagName=='TABLE'?0:obj.clientLeft);
		        y+=obj.offsetTop+(obj.tagName=='TABLE'?0:obj.clientTop);			       
	        }
	        obj=obj.offsetParent;
	        while ((obj!=null)&&(obj!=document.body))
	        {		
		        if(JSisMZ)
		        {										
			        x+=obj.offsetLeft;
			        y+=obj.offsetTop;
			        //Gestion du scroll
			        if(obj.scrollTop!=0) y-=obj.scrollTop;
			        if(obj.scrollLeft!=0) x-=obj.scrollLeft;
			        var objParent=obj.parentNode; 
			        while(objParent.offsetParent==obj.offsetParent && objParent!=null)
			        {
				        if(objParent.scrollTop!=0) y-=objParent.scrollTop;
				        if(objParent.scrollLeft!=0) x-=objParent.scrollLeft;
				        objParent=objParent.parentNode; 
			        }			 
		        }
		        else
		        {			
			        x+=obj.offsetLeft+(obj.tagName=='TABLE'?0:obj.clientLeft);
			        y+=obj.offsetTop+(obj.tagName=='TABLE'?0:obj.clientTop);
			        //Gestion du scroll
			        if(obj.scrollTop!=0)y-=obj.scrollTop;
			        if(obj.scrollLeft!=0) x-=obj.scrollLeft; 
		        }				
		        if (obj.offsetParent==obj) break;
		        obj=obj.offsetParent;
	        }
	        popupMoving.interceptedObject[i]=[popups.interceptedObject[i],x,y];
	    }
	}
}



/*
 * pour stopper le processus de mobilit?
 *
 */
function POPUPSEndMove()
{
	if(!popupMoving.popup) return;
	
	// on n'intercepte plus les mouvements de la souris
	document.onmousemove = null;
	document.onmousewheel = null;
	
	// on autorise ? nouveau la s?lection du texte
	if (JSisIE) document.onselectstart=null;

    //On passe le curseur de la souris ? default
	var container = popupMoving.popup.container;	
	container.style.cursor='default';	
	if (JSisIE)
	{
		if(popupMoving.popup.theme!='dragAndDropImage') container.style.filter='alpha(opacity=100)';
		container._left = parseInt(container.style.left) - document.body.scrollLeft;
		container._top = parseInt(container.style.top) - document.body.scrollTop;
	}
	else
	{
		if(popupMoving.popup.theme!='dragAndDropImage') container.style.opacity=1;
		container._left = parseInt(container.style.left) - window.scrollX;
		container._top = parseInt(container.style.top) - window.scrollY;
	}
    //onpopupout and onpopupdragend
    if(popupMoving.popup.theme=='dragAndDropImage')
	{	   
	    var popup = popupMoving.popup;
	    for(var i=0;i<popupMoving.interceptedObject.length;i++)
	    {       
	        var obj=popupMoving.interceptedObject[i][0];	       	        	        
	        if(obj.isPopupOver)
	        {
	            eval(obj.getAttribute('onpopupout'));obj.isPopupOver=false;
	            eval(obj.getAttribute('onpopupdragend'));
	        } 					
	    }	    
	}
    
	// on oublie le popup...
	popupMoving.popup = null;	
}

/*
 * pour bouger le ghost de la popup
 *
 */
function POPUPSOnMove(e)
{
    if(!popupMoving.popup) return;
	var container = popupMoving.popup.container;	
	var x, y, mouseX, mouseY;
	if(popupMoving.firstOnMove){popupMoving.firstOnMove=false;container.style.cursor='move';}
	if (JSisMZ)
	{
		x = window.scrollX + parseInt(e.clientX) - popupMoving.offsetX;
		y = window.scrollY + parseInt(e.clientY) - popupMoving.offsetY;
		mouseX=e.clientX;
		mouseY=e.clientY;
	}
	else
	{
		x = document.body.scrollLeft +parseInt(event.clientX) - popupMoving.offsetX;
		y = document.body.scrollTop +parseInt(event.clientY) - popupMoving.offsetY;
		mouseX=event.clientX;
		mouseY=event.clientY;
	}
           
    var xMax=x+popupMoving.popup.container.offsetWidth;
	var yMax=y+popupMoving.popup.container.offsetHeight;
	// il ne faut que la popup sorte de la page 
	if (mouseX>0 && mouseY>0)
	{
		container.style.left=x+'px';
		container.style.top=y+'px';
		if(yMax<=popupMoving.bodyScrollHeight+(popupMoving.popup.container.offsetHeight/2) && xMax<=popupMoving.bodyScrollWidth+(popupMoving.popup.container.offsetWidth/2))
		{
		    if(popupMoving.popup.theme=='dragAndDropImage')
		    {
		        if(yMax>document.body.clientHeight+document.body.scrollTop && yMax<document.body.scrollHeight) 
		            document.body.scrollTop=yMax-document.body.clientHeight;		   
	            if(xMax>document.body.clientWidth+document.body.scrollLeft && xMax<document.body.scrollWidth)
	            { 
	                if(xMax<=document.body.width) document.body.scrollLeft=xMax-document.body.clientWidth;
	            }
	        }
	        if(y<document.body.scrollTop) document.body.scrollTop=(y<=0?0:y);
		    
		    if(x<document.body.scrollLeft) document.body.scrollLeft=(x<=0?0:x);
		    popupsModalDiv.style.width=(document.body.clientWidth>document.body.scrollWidth?document.body.clientWidth:document.body.scrollWidth);
			popupsModalDiv.style.height=(document.body.clientHeight>document.body.scrollHeight?document.body.clientHeight:document.body.scrollHeight);			    
		    
		}
	}
	//Gestion du onpopupover et onpopupout
	if(popupMoving.popup.theme=='dragAndDropImage')
	{	   
	    var popup = popupMoving.popup;
	    popup.container.onclick=null;
	    	    
	    for(var i=0;i<popupMoving.interceptedObject.length;i++)
	    {       
	        var obj=popupMoving.interceptedObject[i][0];
	        var xObj=popupMoving.interceptedObject[i][1];
	        var yObj=popupMoving.interceptedObject[i][2];
	        var xMaxObj = xObj+obj.offsetWidth;
	        var yMaxObj = yObj+obj.offsetHeight;
	        
	        //JSEPopup_Trace(2,'Popup intersection: ' + obj.id + '['+obj.tagName+':'+xObj+','+yObj+';Mouse:'+x+','+y+']');
	        //Calcul l'intersection
	        if(xMax>=xObj && x<=xMaxObj && yMax>=yObj && y<=yMaxObj)
	        {
	            if(!obj.isPopupOver){eval(obj.getAttribute('onpopupover'));obj.isPopupOver=true;} 
	            break;
	        }
	        if(obj.isPopupOver){popup.container.style.cursor='move';eval(obj.getAttribute('onpopupout'));obj.isPopupOver=false;} 					
	    }	    
	}	
}

/*********************************** gestionnaire de popup  ***************************************/

/* 
 * le gestionnaire de popups 
 *
 * @extends JSETopLevelElement
 *
 */
function JSEPopups()
{ 
}
Implements(JSEPopups,JSETopLevelElement);
with (JSEPopups)
{
	prototype.counter=0;
	prototype.nodeElementConstructor='JSEPopup';
	prototype.defaultType='popup';
	prototype.activePopup=null;

    prototype.interceptedObject = new Array();	
	prototype.registerInterceptedObject= function(obj)
	{
	    this.interceptedObject[this.interceptedObject.length]=obj;
	    obj.isPopupOver=false;
	}

	/* 
	 * pour obtenir le nom du constructeur associ? aux popup 
	 * 
	 * @param tagName(string) le libell? du tag
	 * @return le libell? du constructeur
	 * @return_type string
	 * @comment cette m?thode est-elle encore utilis?e ?
	 */ 
	prototype._getConstructorFromTag = function(tagName) 
	{ 
		if (tagName=='POPUP') 
		{
			return 'JSEPopup';
		}
		return 'DOMElement';
	}


	/* 
	 * pour r?cup?rer une popup 
	 * 
	 * @param id(string) l'identifiant de la popup recherch?e
	 * @return l'objet associ? ? la popup
	 * @return_type JSEPopup
	 */ 
	prototype.get = function(id)
	{
		return this.documentElement.findChildWithAttribute('POPUP','ID',id); 
	}


	/* 
	 * pour afficher une popup 
	 * 
	 * @param id(string) l'identifiant de la popup ? afficher
	 * @param callback(string) la fonction ? appeler quand la popup est ferm?e
	 * @param defaultValue(string) la valeur retourn?e par d?faut lors de la fermeture de la fenetre
	 * @return l'objet associ? ? la popup
	 * @return_type JSEPopup
	 */ 	
	prototype.show = function(id,callback,defaultValue)
	{
		var popup=this.get(id);		
		if (popup)
		{
			popup.defaultValue=defaultValue;
			popup.callback=callback;
			popup.show();
		}
		return popup;
	}


	/* 
	 * pour masquer une popup 
	 * 
	 * @param id(string) l'identifiant de la popup ? cacher
	 * @return l'objet associ? ? la popup
	 * @return_type JSEPopup
	 */ 		
	prototype.hide = function(id)
	{
		var popup=this.get(id); // this.documentElement.findChildWithAttribute('POPUP','ID',id);
		if (popup) 
		{ 
			popup.hide(); 
		}
		return popup;
	}
	

	/* 
	 * pour cr?er l'ensemble des popup 
	 */ 
	prototype.write = function()
	{
		for(var i=0;i<this.documentElement.childNodes.length;i++)
		{
			this.documentElement.childNodes[i].write();
		}

		// on cr?e le ghost pour les popups qui bougent seulement pour IE
		//if (JSisIE)
		//	document.write('<div id="popup_ghost" style="position:absolute;z-index:666;display:none;cursor:move" class="JSPOPUP" onmouseup="POPUPSEndMove(event)"></div>');
	}


	/* 
	 * pour d?truire l'ensemble des popup 
	 */ 
	prototype.destroy = function()
	{
		var cn;
		if (this.documentElement)
		{
			if (cn=this.documentElement.childNodes)
			{
				for(var i=0;i<cn.length;i++)
				{
					if (cn[i].destroy) 
					{
						cn[i].destroy();
					}
				}
			}
		}
	}
}



/*********************************** popup  ***************************************/


/* 
 * une popup
 *
 * @extends JSEElement
 *
 */
function JSEPopup() 
{
}
Implements(JSEPopup,JSEElement);
with(JSEPopup)
{
	/* caract?ristiques de la fenetre */
	prototype.id=null;
	prototype.theme;
	prototype.visible=false;
	prototype.callback;        // la fonction a appeler lors de la fermeture de la fenetre
	prototype.defaultValue=''; // la valeur retourn?e par d?faut lors de la fermeture de la popup

	/* dimensions de la fenetre */
	prototype.width;
	prototype.height;

	/* gestion de la barre de titre */
	prototype.titlebar;
	prototype.closeButton;
	prototype.titlebarIcon;

	/* animation de la fenetre */
	prototype.alpha=0;
	prototype.animateState='HALTED';
	prototype.animateId=-1;
	prototype.animated=false;
	prototype.modal=true;

	/* mobilit? de la fenetre, par d?faut elle bouge */
	prototype.move;

	/* les boutons de la fenetre */
	prototype.defButtons;
	// prototype.buttons=; // A priori non utilis?

	prototype.first=true; //To Do before first show popup

	/* pour g?rer le scroll */
	if (JSisMZ)
	{
		prototype.refFunction;
	}
      
	/* 
	 * attributs h?rit?s utilis?s dans cet objet:
	 *	- dirty      (JSEElement -> DOMElement -> DOMNode) initialis? ? true
	 *	- type       (JSEElement)                          initialis? ? null
	 *	- container  (JSEElement)                          initialis? ? null
	 */


	/* 
	 * pour initialiser les attributs de l'objet avec les attributs du tag POPUP ou du type associ? 
	 */ 		
	prototype.bind = function()
	{
		if (this.dirty)
		{
			this.type = this.ownerDocument.getType(this.getAttribute('type'));			

			/* les attributs dimensionnels */
			this.width = this.getPropertyValue('width');
			this.height = this.getPropertyValue('height');
			this.left = this.getPropertyValue('left');
			this.top = this.getPropertyValue('top');
			
			/* on fixe les dimensions par d?faut sauf pour left et top qui seront calcul?s 
  			   pour centrer le popup */
			if (!this.width) this.width=300;
			if (!this.height) this.height=200;

			this.animated = this.getPropertyValue('animated');
			this.modal = this.getPropertyValue('modal');

			/* la barre de titre de la popup */
			this.titlebar = this.getPropertyValue('titlebar');
			this.closeButton = this.getPropertyValue('closeButton');
			this.titlebarIcon = this.getPropertyValue('titlebarIcon');

			/* mobilit? de la fenetre */
			this.move = this.getPropertyValue('move');

			/* doit on cr?er les boutons par d?faut */
			this.defButtons = this.getPropertyValue('defaultButtons');

			/* l'appel de la m?thode setUIHandler est tr?s important.
			   Ca permet de lier les m?thodes "graphiques" de cet objet avec les m?thodes de l'objet activ?.
		
			   Exemple: la fenetre active est de type warning, donc this.theme='warning'.
			   setUIHandler red?finit certaines m?thodes:
				ui_show() appelle ui_warning_show qui appelle la m?thode show() de l'objet actif qui est du type JSEPopupUI_warning.
				idem pour ui_refresh(), ui_mouseOver(), ui_mouseOut(), ui_select(), ui_deselect(), ui_show(), ui_hide(), ui_toggle(), ui_getValue()
			*/
			this.theme = this.getPropertyValue('theme');
			if(this.theme=='dragAndDropImage') this.animated=false;
			this.setUIHandler(this.theme);

			this.dirty=false;
		}
		
	}


	/* 
	 * pour afficher la fenetre
	 */ 		
	prototype.show = function(e)
	{
		if (!this.visible)
		{
			this.ownerDocument.activePopup=this;

			/* on intercepte le scroll sur le document pour que la fenetre bouge en meme temps que le document */
			if (JSisIE)
			{
				//if(this.theme!='dragAndDropImage') 
				document.body.onscroll=JSEPopup_scrollHandler;
			}
			else
			{
				// Netscape ne supporte apparemment pas la m?thode addEventListener
				// Ca marche sous mozilla, mais ca rame ? mort
				// pour que ca fonctionne sous Mozilla et Netscape, on utilise la m?thode setInterval
				// window.addEventListener('scroll', JSEPopup_scrollHandler, false);
				this.refFunction = window.setInterval('JSEPopup_scrollHandler()', 100);
			}
			this.refresh();
			
			//On positionne le container ? la fin du DOM pour eviter les probl?mes de super-position
			if(this.first) document.body.insertBefore(this.container,document.body.lastChild);
			this.first=false;		
			
			if(this.theme!='dragAndDropImage' && this.modal) 
			{			
			    document.body.insertBefore(popupsModalDiv,this.container);
			    popupsModalDiv.style.width=(document.body.clientWidth>document.body.scrollWidth?document.body.clientWidth:document.body.scrollWidth);
			    popupsModalDiv.style.height=(document.body.clientHeight>document.body.scrollHeight?document.body.clientHeight:document.body.scrollHeight);
			    popupsModalDiv.style.display='';
			}
			if (this.animated && this.theme!='dragAndDropImage')
			{				
				this.visible=true;
				if(JSisIE)
				{				    
				    this.container.style.visibility='hidden';
				    this.container.style.display='';
			        this.container.style.filter='blendTrans(duration=0.5)';
			        this.container.filters[0].Apply();
			        this.container.style.visibility='visible';			        
			        this.container.filters[0].Play();			        
				}
				else
				{
				    window.clearInterval(this.animateId);
				    this.animateId=window.setInterval("popups.get('"+this.id+"').animate();",(JSisMZ?30:10));
				    this.alpha=0;				
				    this.animateState='SHOWING';
				    this.animate();
				}
			}
			else
			{
				this.container.style.display='';
				this.visible=true;
				this.ui_show(e);
				this.fireEvent('onShow');
			}
		}
	}
	

	/* 
	 * pour masquer la fenetre
	 *
	 * @comment cette m?thode ne fait que masquer la fenetre, elle ne renvoie pas le r?sultat par l'interm?diaire de la callback
	 */ 	
	prototype.hide = function()
	{
		if (this.visible)
		{
			if (this.ownerDocument.activePopup==this)
			{
				this.ownerDocument.activePopup=null;
				/* on n'intercepte plus l'?v?nement onscroll */
				if (JSisIE)
				{
					document.body.onscroll=null;
				}
				else
				{
					//window.removeEventListener('scroll', JSEPopup_scrollHandler, false);
					window.clearInterval(this.refFunction);
				}
			}			
			if(this.theme!='dragAndDropImage' && this.modal) popupsModalDiv.style.display='none';
			if(this.animated && this.theme!='dragAndDropImage')
			{
				this.visible=false;	
				if(JSisIE)
				{				    
			        this.container.style.filter='blendTrans(Duration=0.5)';
			        this.container.filters[0].Apply();
			        this.container.style.visibility='hidden';			        			        
			        this.container.filters[0].Play();
			        
				}
				else
				{
				    /* le bloc suivant a ?t? ajout? pour que la routine animate 
				       ne tourne pas constamment lorque la popup est affich?e */												    									    
				    window.clearInterval(this.animateId);
				    this.animateId=window.setInterval("popups.get('"+this.id+"').animate();",(JSisMZ?30:10));
				    this.alpha=10;				
				    this.animateState='HIDING';
				    this.animate();
				}
			}
			else
			{
				this.container.style.display='none';
				this.visible=false;
				this.fireEvent('onHide');
			}			
		}
		if (this.ui_hide) this.ui_hide();
	}
	

	/* 
	 * pour d?finir le titre de la fenetre
	 */ 	
	prototype.setTitle = function(title)
	{
		this.putPropertyValue('title',title);
	}


	/* 
	 * pour pr?ciser le message ? afficher dans la fenetre
	 */ 	
	prototype.setMessage = function(msg)
	{
		this.putPropertyValue('message',msg);
	}


	/* 
	 * pour g?rer l'animation de la fenetre
	 *
	 * @comment la fenetre s'affiche ou disparait de mani?re progressive sous IE, sous Mozilla et Netscape, elle clignote
	 */ 		
	prototype.animate = function()
	{
	    if(this.animateState=='WAITING') return;
	    
		switch(this.animateState)
		{
			case 'SHOWING':			    
			    this.animateState=='WAITING';
				if (this.alpha<10) this.alpha=this.alpha+(JSisIE?2:1);
				if (this.alpha>0) this.container.style.display='';
				if (this.alpha==10) 
				{
					this.visible=true;
					this.animateState = 'STOP';
					this.ui_show();
					this.fireEvent('onShow');
				}
				if(JSisMZ)
					this.container.style.opacity=(this.alpha/10);
				else
					this.container.style.filter='alpha(opacity='+(this.alpha*10)+')';
				this.animateState=='SHOWING';
				break;
				
			case 'HIDING':			    
				this.animateState=='WAITING';
				if (this.alpha>0) this.alpha=this.alpha-(JSisIE?2:1);
				if (this.alpha==0)
				{
					this.container.style.display='none';
					this.animateState = 'STOP';
					this.visible=false;
					this.fireEvent('onHide');
				}
				if(JSisMZ)
					this.container.style.opacity=(this.alpha/10);
				else
					this.container.style.filter='alpha(opacity='+(this.alpha*10)+')';
				this.animateState=='HIDING';
				break;
			case 'STOP':
				window.clearInterval(this.animateId);
				this.animateState='HALTED';
				break;
				
		}
				
	}


	/* 
	 * pour fermer une popup
	 *
	 * @comment la callback associ?e ? la popup est d?clench?e pour qu'elle puisse r?cup?rer la valeur retourn?e par la popup
	 */ 		
	prototype.dismiss = function(value)
	{
		if (this.visible) 
		{ 
			this.hide(); 
			this.ownerDocument.activePopup=null;
		}

		if (this.callback)
		{
			this.callback(this.id,value);
		}
	}

	/*
	 * pour obtenir le r?sultat renvoy?e par la popup
	 *
	 * @return le r?sultat de la popup
	 * @return_type ???
	 *
	 */
	prototype.getValue = function()
	{
		return this.ui_getValue();
	}


	/* 
	 * pour g?rer le clic sur un bouton d'une popup
	 *
	 * @comment cette m?thode ?value la fonction associ?e au clic sur le bouton
	 */ 
	prototype.button = function(id)
	{
		var butt = this.findChildWithAttribute('BUTTON','ID',id);
		if (butt)
		{
			var evt = butt.getAttribute('onClick');
			if (evt) eval(evt);
		}
	}


	/* 
	 * pour retailler une popup
	 *
	 * @param width(int) la nouvelle largeur
	 * @param height(int) la nouvelle hauteur
	 * @comment cette m?thode est-elle utilis?e quelque part ?
	 * 
	 */ 
	prototype.resize = function(width,height)
	{
		if (this.theme=='fullscreen')
		{
			this.container.style.width='100%';
			this.container.style.height='100%';
			return;
		}

		if (width!=null) this.width=width;
		if (height!=null) this.height=height;
		var left, top;

		if (JSisMZ)
		{
			if (this.left) 
				left = parseInt(this.left);
			else
				left = (window.innerWidth - this.width)/2;	
			
			if (this.top)
				top = parseInt(this.top);
			else
				top = (window.innerHeight - this.height)/2;	
			
			this.container.style.left = left+'px';
			this.container.style.top = top+'px';
		}
		else
		{
			if (this.left) 
				left = parseInt(this.left);
			else	
				left = (document.body.clientWidth - this.width)/2;
		
			if (this.top)
				top = parseInt(this.top);
			else	
				top= (document.body.clientHeight - this.height)/2;
			
			this.container.style.left = (left + document.body.scrollLeft)+'px';
			this.container.style.top = (top + document.body.scrollTop)+'px';
		}

		this.container.style.width = this.width+'px';
		this.container.style.height= this.height+'px';
		this.container._left=left; // le d?calage par rapport au bord gauche, c'est ? dire sans le scroll 
		this.container._top=top;   // idem mais par rapport au bord du haut
	}


	/* 
	 * pour rafraichir la popup
	 *
	 */ 
	prototype.refresh = function()
	{
		this.bind();

		if (this.theme!='fullscreen')
		{
			var left, top;
			if (JSisMZ)
			{
				if (this.left) 
					left = parseInt(this.left);
				else
					left = (window.innerWidth - this.width)/2;	
				
				if (this.top)
					top = parseInt(this.top);
				else
					top = (window.innerHeight - this.height)/2;	
			
				this.container.style.left = left+'px';
				this.container.style.top = top+'px';
			}
			else
			{				
				if (this.left) 
					left = parseInt(this.left);
				else	
					left = (document.body.clientWidth - this.width)/2;
			
				if (this.top)
					top = parseInt(this.top);
				else	
					top= (document.body.clientHeight - this.height)/2;

				this.container.style.left = (left + document.body.scrollLeft)+'px';
				this.container.style.top = (top + document.body.scrollTop)+'px';
			}
			this.container.style.width = this.width+'px';
			this.container.style.height = this.height+'px';			
			this.container._left=left;
			this.container._top=top;
		}
		else
		{
			this.container.style.position='absolute';
			this.container.style.top='0px';
			this.container.style.left='0px';			
			this.container.style.width=(JSisIE?document.body.clientWidth:window.innerWidth)+'px';
			this.container.style.height=(JSisIE?document.body.clientHeight:window.innerHeight)+'px';			
		}
		this.ui_refresh();
	}


	/* 
	 * pour cr?er le code HTML associ? ? une fenetre 
	 */ 
	prototype.write = function()
	{		
		this.id = this.getAttribute('ID');
		if (this.id==null)
		{ 
			this.id='POPUP_'+this.ownerDocument.counter++; 
			this.setAttribute('ID',this.id); 
		}		
		document.write('<div id="'+this.id+'" style="position:absolute;z-index:30000;display:none;"></div>');
		this.container = getElementById(this.id);
	}
		

	/* 
	 * pour cr?er le code HTML associ? ? la barre de titre d'une fenetre 
	 *
	 * @return le code HTML correspondant ? la barre de titre
	 * @return_type string
	 */ 
	prototype.writeTitlebar = function()
	{
		var title = this.getPropertyValue('title');
		
		/* pour ?viter de voir afficher undefined dans la barre de titre */
		if (!title) title='';

		html='<tr>';

		/* affichage optionnel d'une icone */
		if (this.titlebarIcon)
		{
			html+='<td class="JSPOPUP_TITLE" style="border-right:0px"><img alt="" src="'+this.getPropertyValue('icon')+'" align="absmiddle"/></td>';
		}
		else
		{
			html+='<td class="JSPOPUP_TITLE" style="border-right:0px">&#160;</td>';
		}

		/* le titre */
		html+='<td class="JSPOPUP_TITLE" width="100%" style="border-left:0px;border-right:0px;padding-left:0px" ';

		/* si popup mobile on ajoute les attributs en cons?quence */
		if (this.move)
		{
			html+=' onmousedown="this.style.cursor=\'move\';POPUPSStartMove(\''+this.id+'\', event)" onmouseup="POPUPSEndMove();this.style.cursor=\'default\';" '
		}
	

		/* on complete... */
		html+='>'+title+'</td>';

		/* affichage optionnel du bouton close */
		if (this.closeButton)
		{
			html+='<td width="36" class="JSPOPUP_TITLE" style="border-left:0px"><a href="#" onclick="popups.get(\''+this.id+'\').dismiss(null); return false;"><img alt="" src="'+skinCache.getImage('general/icons/popups/close.gif')+'" width="22" height="22" border="0"/></a></td>';
		}
		else
		{
			html+='<td class="JSPOPUP_TITLE" style="border-left:0px">&#160;</td>';
		}

		html+='</tr>';
		return html;
	}


	/* 
	 * pour d?truire une fenetre 
	 */ 
	prototype.destroy = function()
	{
		if (this.ui_destroy) 
		{
			this.ui_destroy();
		}
		this.container=null;
	}


	/* 
	 * pour g?n?rer le code HTML des boutons associ?s ? une popup
	 *
	 * @return le code HTML correspondant aux boutons
	 * @return_type string 
	 * @comment cette m?thode prend un nombre de param?tres ind?finis pour g?rer la cr?ation des boutons par d?faut
	 */ 	
	prototype.buttonCode = function()
	{
		/* on cr?? les boutons par d?faut en manipulant le noeud */ 
		if (this.defButtons)
			this.defaultButtons(arguments);

		/* si aucun bouton d?finis dans la popup */
		if (!this.childNodes)
		{
			return '';
		}
	
		var html='';
		var node, id, label, onclick, relsrc,relsrcover,imgSrc,imgSrcOver; 
		for(var i = 0;i<this.childNodes.length;i++)
		{
			node = this.childNodes[i];
			if (node.nodeName=='BUTTON')
			{
				id=node.getAttribute('ID');
				label=node.getAttribute('label');
				relsrc=node.getAttribute('RELSRC');
                relsrcover=node.getAttribute('RELSRCOVER');

				/* attribution d'un libell? au bouton si aucun d?fini */
				if (!label)
				{
					switch(id)
					{
						case 'OK':
							label='Valider';
							break;
						case 'CANCEL':
							label='Annuler';
							break;
						default:
							label=id;
							break;
					}
				}
				/* la m?thode button() de la popup est associ?e au clic du bouton */
				onclick='popups.get(\''+this.id+'\').button(\''+id+'\')';
				
				/* la fonction JSGetButtonCode est d?finie dans la package CORE */
				imgSrc='';imgSrcOver='';
				if(id=='OK' || id=='CANCEL')
				{
					var imgSrc,imgSrcOver;
					if(id=='OK')
					{
						if(!relsrc) imgSrc=skinCache.getImage('general/icons/popups/validate.gif');
						if(!relsrcover) imgSrcOver=skinCache.getImage('general/icons/popups/validate-o.gif');
					}
					else
					{
						if(!relsrc) imgSrc=skinCache.getImage('general/icons/popups/cancel.gif');
						if(!relsrcover) imgSrcOver=skinCache.getImage('general/icons/popups/cancel-o.gif');
					}					
                }
                if(relsrc) imgSrc=skinCache.getImage(relsrc);
				if(relsrcover) imgSrcOver=skinCache.getImage(relsrcover);   
                if(imgSrc!='')
                {
					if(imgSrcOver=='') imgSrcOver=imgSrc;
					html+= '<td onMouseOver="switchSrc(getElementById(\''+this.id+id+'_bt\'))" onMouseOut="switchSrc(getElementById(\''+this.id+id+'_bt\'))"><table cellpadding="0" cellspacing="0" border="0"><tr><td><a class="JSPOPUP_BUTTON" onclick="'+onclick+';return false;" href="#" id="'+id+'"><img alt="'+label+'" id="'+this.id+id+'_bt" src="'+imgSrc+'" lowsrc="'+imgSrcOver+'" border="0"/></a></td><td style="padding-right:10px"><a class="JSPOPUP_BUTTON" onclick="'+onclick+';return false;" href="#">'+label+'</a></td></tr></table></td>';
				}
				else
				{
					html+= '<td>'+JSGetButtonCode(this.id+'_bt_'+id,onclick,label)+'</td>';
				}					
			}
		}
		return html;
	}


	/* 
	 * pour g?n?rer le code HTML des boutons associ?s par d?faut ? une popup
	 *
	 * @param buttons(Array) un tableau contenant le type de la popup et les id des boutons ? cr?er par d?faut
	 * @comment c'est le noeud XML qui est directement manipul? 
	 */
	prototype.defaultButtons = function(buttons)
	{
		// pour l'instant, on ne g?re que le cas ou aucun bouton n'a ?t? d?fini
		if (!this.childNodes)
		{
			var newButton, i, id, prefix;

			/* on r?cup?re le type de la popup */
			if (!buttons.length)
			{
				return;
			}
			else
			{
				prefix=buttons[0];
			}

			/* on traite les boutons un par un, on ne d?finit aucun label */
			for (i=1; i<buttons.length; i++)
			{
				id = buttons[i];
				switch(id)
				{
					case 'OK':
						newButton = this.ownerDocument.createElement('BUTTON');
						newButton.setAttribute('ID', id);
						if (prefix=='prompt')
						{
							// il faut retourner la valeur du champ de saisie
							newButton.setAttribute('onClick', 'popups.get(\''+this.id+'\').dismiss(getElementById(\''+this.id+'_value\').value)');
						}
						else
						{
							newButton.setAttribute('onClick', 'popups.get(\''+this.id+'\').dismiss(true)');
						}
						this.appendChild(newButton);
						break;
					case 'CANCEL':
						newButton = this.ownerDocument.createElement('BUTTON');
						newButton.setAttribute('ID', id);
						newButton.setAttribute('onClick', 'popups.get(\''+this.id+'\').dismiss(false)');
						this.appendChild(newButton);
						break;
					default:
						// aucun autre type de bouton support? pour l'instant
						break;
				}
			}
		}

		/* on ne pas g?rer pour l'instant le cas ou certains boutons sont d?finis dans la popup, car les boutons 
		par d?faut seraient ajout?s apr?s. Il faut impl?menter la m?thode insertBefore */ 
	}
}



/*********************************** popup warning ***************************************/

/* 
 * popup de type warning
 *
 * @comment les attributs de l'objet JSEPopup sont disponibles malgr? que JSEPopupUI_warning n'h?rite pas de l'objet JSEPopup.
 * Ceci grace ? l'appel de la fonction Includes qui recopie les m?thodes de l'objet JSEPopupUI_warning dans l'objet JSEPopup.
 *
 * @comment la m?thode bind() de JSEPopup n'est appel?e qu'une fois, lors de l'affichage de la popup.
 * Tous les attributs susceptibles de changer par l'appel de m?thodes sur l'objet JSEPopup doivent donc etre r?cup?r?s par la m?thode getPropertyValue(). 
 *
 * @extends JSEUIObject
 * @includes JSEPopup
 */

function JSEPopupUI_warning() 
{
}
Implements(JSEPopupUI_warning,JSEUIObject);
with(JSEPopupUI_warning)
{
	/* 
	 * attributs h?rit?s utilis?s dans cet objet:
	 *	- prefix      (JSEUIObject)   initialis? ? 'generic'
	 *	- container   (JSEPopup)      initialis? avec l'objet HTML destin? ? recevoir le code HTML
	 *	- titlebar    (JSEPopup)      initialis? ? true
	 */


	/* utilis? par la fonction Includes */ 
	prototype.prefix = 'warning';


	/*
	 * pour rafraichir le code HTML ? l'int?rieur de la popup
	 */
	prototype.refresh = function()
	{
		
		var html;
		var msg = this.getAttribute('message');
		var content = this.getAttribute('content');
		if(content==null) content='';		
		if(this.container.innerHTML!='' && content!='') return;
        
		html='<table style="width:100%;height:'+this.height+'px" cellpadding="0" cellspacing="0" class="JSPOPUP">';

		/* la barre de titre */
		if (this.titlebar)
		{
			html+=this.writeTitlebar();
		}
		else
		{
		    /* si popup mobile on ajoute les attributs en cons?quence */
		    if (this.move)
		    {
			    html='<table style="width:100%;height:'+this.height+'px" cellpadding="0" cellspacing="0" class="JSPOPUP" onmousedown="this.style.cursor=\'move\';POPUPSStartMove(\''+this.id+'\', event)" onmouseup="POPUPSEndMove();this.style.cursor=\'default\';" />';
		    }
		}

		
		/* le contenu de la popup */
		var frmheight=(this.height-(this.titlebar?34:10)-((this.defButtons || this.childNodes)?26:0));
		html+='<tr><td style="width:100%;height:'+frmheight+'px;text-align:center" colspan="3" class="JSPOPUP_TEXT" id="td_popup_message_'+this.id+'">'+(content!=''?'':msg)+'</td></tr>';

		/* le bas de la popup avec les ?ventuels boutons */
		if(this.defButtons || this.childNodes)
		{
			html+='<tr><td style="width:100%;height:24px;text-align:right" colspan="3" class="JSPOPUP_FOOT"><table align="right"><tr>';
			html+=this.buttonCode('warning', 'OK')+'</tr>'; //attention, mettre en dur le prefix est volontaire !!
		}
		html+='</table></td></tr></table>';

		this.container.innerHTML=html;
		if(content!='')
		{
		    var td=getElementById('td_popup_message_'+this.id);
		    var div = getElementById('popup_content_'+content);
		    if(td && div) 
		    {
		        td.appendChild(div);		        
		        div.style.display='';
		    }
		} 
	}


	/*
	 * pour d?finir les actions ? effectuer quand la popup est affich?e
	 * 
	 * @comment l'affichage est assur?e par ma m?thode show() de JSEPopup
	 *
	 */
	/*prototype.show = function()
	{

		// l'id du bouton OK n'est pas forcement le bon(casse)
		//getElementById(this.id+'_ok').focus();
	}*/


	/*
	 * pour obtenir la valeur retourn?e par la popup
	 */
	/*prototype.getValue = function() 
	{ 
		return null; 
	}*/
}
Includes(JSEPopup,JSEPopupUI_warning);



/*********************************** popup prompt ***************************************/

/* 
 * popup de type prompt
 *
 * @comment les attributs de l'objet JSEPopup sont disponibles malgr? que JSEPopupUI_prompt n'h?rite pas de l'objet JSEPopup.
 * Ceci grace ? l'appel de la fonction Includes qui recopie les m?thodes de l'objet JSEPopupUI_prompt dans l'objet JSEPopup.
 *
 * @comment la m?thode bind() de JSEPopup n'est appel?e qu'une fois, lors de l'affichage de la popup.
 * Tous les attributs susceptibles de changer par l'appel de m?thodes sur l'objet JSEPopup doivent donc etre r?cup?r?s par la m?thode getPropertyValue(). 
 *
 * @extends JSEUIObject
 * @includes JSEPopup
 */


function JSEPopupUI_prompt()
{
}
Implements(JSEPopupUI_prompt,JSEUIObject);
with(JSEPopupUI_prompt)
{
	/* 
	 * attributs h?rit?s utilis?s dans cet objet:
	 *	- prefix      (JSEUIObject)   initialis? ? 'generic'
	 *	- container   (JSEPopup)      initialis? avec l'objet HTML destin? ? recevoir le code HTML
	 *	- titlebar    (JSEPopup)      initialis? ? true
	 */


	/* utilis? par la fonction Includes */ 
	prototype.prefix = 'prompt';


	/*
	 * pour rafraichir le code HTML ? l'int?rieur de la popup
	 */
	prototype.refresh = function()
	{	
		var html;
		var msg = this.getAttribute('message');
		var content = this.getAttribute('content');	
		if(content==null) content='';	 
		if(this.container.innerHTML!='' && content!='') return;       
		html='<table style="width:100%;height:'+this.height+'px" cellpadding="0" cellspacing="0" class="JSPOPUP">';

		/* la barre de titre */
		if (this.titlebar)
		{
			html+=this.writeTitlebar();
		}
		else
		{
		    /* si popup mobile on ajoute les attributs en cons?quence */
		    if (this.move)
		    {
			    html='<table style="width:100%;height:'+this.height+'px" cellpadding="0" cellspacing="0" class="JSPOPUP" onmousedown="this.style.cursor=\'move\';POPUPSStartMove(\''+this.id+'\', event)" onmouseup="POPUPSEndMove();this.style.cursor=\'default\';" />';
		    }
		}

		/* le message et le champ de saisie sont d?sormais affich?s dans une table HTML 
		   l'icone associ?e au message n'est plus affich?e
		*/
		var frmheight=(this.height-(this.titlebar?34:10)-((this.defButtons || this.childNodes)?26:0));
		var table;
		table='<table style="width:100%;height:'+frmheight+'px" cellspacing="1" cellpadding="1" border="0">';
		table+='<tr valign="bottom"><td id="td_popup_message_'+this.id+'" align="center" class="JSPOPUP_TEXT">'+(content!=''?'':msg)+'</td></tr>';
		table+='<tr valign="top"><td align="center"><input class="JSPOPUP_PROMPT_INPUT" type="text" size="30" value="'+(this.defaultValue?this.defaultValue:'')+'" id="'+this.id+'_value" onkeydown="if (event.keyCode==13) {popups.get(\''+this.id+'\').dismiss(this.value);return;}; if (event.keyCode==27) { popups.get(\''+this.id+'\').dismiss(null);return;}"/></td></tr>';
		table+='</table>';
				
		html+='<tr><td style="width:100%;height:'+frmheight+'px" colspan="3" class="JSPOPUP_TEXT">'+table+'</td></tr>';

		/* ancien affichage: l'icone associ?e au message n'est plus affich?e */
		//html+='<tr height="50%"><td align="center" colspan="3"><img src="'+this.getPropertyValue('icon')+'" align="absmiddle">&#160;'+msg+'</td></tr>';
		//html+='<tr height="100%"><td align="center" colspan="3">'+msg+'</td></tr>';
		//html+='<tr height="50%"><td align="center" colspan="3"><input type="text" size="30" value="'+this.defaultValue+'" id="'+this.id+'_value" onKeyDown="if (event.keyCode==13) {popups.get(\''+this.id+'\').dismiss(this.value);return;}; if (event.keyCode==27) { popups.get(\''+this.id+'\').dismiss(null);return;}"/></td></tr>';

		/* le bas de la fenetre avec les ?ventuels boutons */
		html+='<tr><td style="width:100%;height:24px;text-align:right" colspan="3" class="JSPOPUP_FOOT"><table align="right"><tr>';
		html+=this.buttonCode('prompt', 'OK', 'CANCEL'); // attention, mettre le prefix en dur est volontaire !!
		html+='</tr></table></td></tr></table>';

		this.container.innerHTML=html;
		if(content!='')
		{
		    var td=getElementById('td_popup_message_'+this.id);
		    var div = getElementById('popup_content_'+content);
		    if(td && div) 
		    {
		        td.appendChild(div);		        
		        div.style.display='';
		    }
		} 
		 		
	}


	/*
	 * pour d?finir les actions ? effectuer quand la popup est affich?e
	 * 
	 * @comment l'affichage est assur?e par ma m?thode show() de JSEPopup
	 *
	 */
	prototype.show = function()
	{
		// Sous Mozilla, mettre le focus sur le champ de saisie empeche la fenetre de se centrer en fonction du scroll du document
		// l'affichage de la fenetre prompt remet le document dans sa position initiale, en haut ? gauche !!!
		// Cette fois ci c'est Netscape qui en paye les frais !
		if (JSisIE)
		{ 			
			getElementById(this.id+'_value').focus();				
		}
	}


	/*
	 * pour obtenir la valeur retourn?e par la popup
	 *
	 * @comment il s'agit de la valeur pr?sente dans le champ de saisie, donc ? priori accessible meme quand la fentre est ferm?e
	 */
	prototype.getValue = function() { 
		return getElementById(this.id+'_value').value; 
	}
}
Includes(JSEPopup,JSEPopupUI_prompt);



/*********************************** popup confirm ***************************************/

/* 
 * popup de type confirm
 *
 * @extends JSEPopupUI_warning
 * @includes JSEPopup
 */

function JSEPopupUI_confirm() 
{
}
Implements(JSEPopupUI_confirm, JSEPopupUI_warning);
with(JSEPopupUI_confirm)
{
	/* utilis? par la fonction Includes */ 
	prototype.prefix = 'confirm';


	/*
	 * pour rafraichir le code HTML ? l'int?rieur de la popup
	 * oblig? de red?finir la m?thode refresh pour d?finir les boutons par d?faut
	 */
	prototype.refresh = function()
	{		
		var html;
		var msg = this.getAttribute('message');

		html='<table style="width:100%;height:'+this.height+'px" cellpadding="0" cellspacing="0" class="JSPOPUP">';

		/* la barre de titre */
		if (this.titlebar)
		{
			html+=this.writeTitlebar();
		}
		else
		{
		    /* si popup mobile on ajoute les attributs en cons?quence */
		    if (this.move)
		    {
			    html='<table style="width:100%;height:'+this.height+'px" cellpadding="0" cellspacing="0" class="JSPOPUP" onmousedown="this.style.cursor=\'move\';POPUPSStartMove(\''+this.id+'\', event)" onmouseup="POPUPSEndMove();this.style.cursor=\'default\';" />';
		    }
		}
		
		/* le contenu de la popup */
		var frmheight=(this.height-(this.titlebar?34:10)-((this.defButtons || this.childNodes)?26:0));
		html+='<tr><td style="width:100%;height:'+frmheight+'px;text-align:center" colspan="3" class="JSPOPUP_TEXT">'+msg+'</td></tr>';

		/* le contenu de la popup */
		//html+='<tr><td style="text-align:center" colspan="3" class="JSPOPUP_TEXT">'+msg+'</td></tr>';

		/* le bas de la popup avec les ?ventuels boutons */
		html+='<tr><td style="width:100%;height:24px;text-align:right" colspan="3" class="JSPOPUP_FOOT"><table align="right"><tr>';
		html+=this.buttonCode('confirm', 'OK', 'CANCEL'); //attention, mettre en dur le prefix est volontaire !!
		html+='</tr></table></td></tr></table>';

		this.container.innerHTML=html;
	}
	
}
Includes(JSEPopup,JSEPopupUI_confirm);



/*********************************** popup iframe ***************************************/

/* 
 * popup de type iframe
 *
 * @comment les attributs de l'objet JSEPopup sont disponibles malgr? que JSEPopupUI_iframe n'h?rite pas de l'objet JSEPopup.
 * Ceci grace ? l'appel de la fonction Includes qui recopie les m?thodes de l'objet JSEPopupUI_iframe dans l'objet JSEPopup.
 *
 * @comment la m?thode bind() de JSEPopup n'est appel?e qu'une fois, lors de l'affichage de la popup.
 * Tous les attributs susceptibles de changer par l'appel de m?thodes sur l'objet JSEPopup doivent donc etre r?cup?r?s par la m?thode getPropertyValue(). 
 *
 * @extends JSEUIObject
 * @includes JSEPopup
 */


function JSEPopupUI_iframe()
{
}
Implements(JSEPopupUI_iframe,JSEUIObject);
with(JSEPopupUI_iframe)
{
	/* 
	 * attributs h?rit?s utilis?s dans cet objet:
	 *	- prefix      (JSEUIObject)   initialis? ? 'generic'
	 *	- container   (JSEPopup)      initialis? avec l'objet HTML destin? ? recevoir le code HTML
	 *	- titlebar    (JSEPopup)      initialis? ? true
	 */

	/* pour obtenir un pointeur sur la iframe */
	prototype.iframe;

	/* utilis? par la fonction Includes */ 
	prototype.prefix = 'iframe';


	/*
	 * pour rafraichir le code HTML ? l'int?rieur de la popup
	 */
	prototype.refresh = function()
	{
		var html;

		/* l'url ? charger dans la fenetre */
		var src = this.getAttribute('src');

		/* le message ? afficher dans le bas de la fenetre */
		var msg = this.getAttribute('message');

		/* attribut apparemment non utilis? */
		// var bHiddenFrame = (this.getAttribute('hiddenFrame')!=null);
            
		html='<table style="width:100%;height:'+this.height+'px" cellpadding="0" cellspacing="0" class="JSPOPUP">';

		/* la barre de titre */
		if (this.titlebar)
		{
			html+=this.writeTitlebar();
		}
		else
		{
		    /* si popup mobile on ajoute les attributs en cons?quence */
		    if (this.move)
		    {
			    html='<table style="width:100%;height:'+this.height+'px" cellpadding="0" cellspacing="0" class="JSPOPUP" onmouseover="this.style.cursor=\'move\'" onmousedown="POPUPSStartMove(\''+this.id+'\', event)" onmouseup="POPUPSEndMove();this.style.cursor=\'default\';" />';
		    }
		}

		/* le contenu de la popup */		
		html+='<tr id="'+this.id+'_container"><td align="center" colspan="3">';
		// netscape 6.2 n'arrive pas ? prendre en compte le 100% pour l'attribut height de la iframe, ce bug n'est pas seulement constat? pour la iframe
		// Apr?s tests, on se rend compte qu'un ?l?ment avec height=100% dans une cellule d'un tableau est affich? avec une hauteur r?duite
		// tant pis pour mozilla qui paye en meme temps
		//var frmheight=JSisMZ?(this.height-(this.titlebar?32:0))+'px':'100%';
		var frmheight=(this.height-(this.titlebar?34:0))+'px';
		
		html+='<iframe class="JSPOPUP_TEXT" id="'+this.id+'_iframe" frameborder="no" src="'+src+'" style="height:'+frmheight+';width:100%;border:none;"></iframe>';
		html+='</td></tr>';
		
		/* l'?ventuel message: du genre pour montrer que la fenetre est en cours de chargement */
		if (msg)
		{
			html+= '<tr id="'+this.id+'_waiting" class="JSPOPUP_TEXT"><td align="center" colspan="3">'+msg+'</td></tr>';
		}

		/* le bas de la popup avec les ?ventuels boutons */
		//html+='<tr><td align="center" colspan="3" class="JSPOPUP_FOOT"><table><tr>';
		//html+=this.buttonCode('iframe', 'CANCEL'); //attention, mettre en dur le prefix est volontaire !!
		//html+='</tr></table></td></tr></table>';
		

		html+= '</table>';

		this.container.innerHTML=html;	
		this.iframe = getElementById(this.id+'_iframe');
	}


	/*
	 * pour d?finir les actions ? effectuer quand la popup est affich?e
	 * 
	 * @comment l'affichage est assur?e par ma m?thode show() de JSEPopup
	 *
	 */
	/*prototype.show = function()
	{
		//getElementById(this.id+'_ok').focus();
	}*/


	/*
	 * pour d?finir les actions ? effectuer quand la popup est masqu?e
	 * 
	 * @comment le masquage est assur?e par ma m?thode hide() de JSEPopup
	 *
	 */
	prototype.hide = function()
	{
		if (this.iframe)
		{
			if (this.iframe.location) 
			{
				this.iframe.location.href='about:blank'; // trigger the onUnload!
			}
		}
	}


	/*
	 * pour obtenir la valeur retourn?e par la popup
	 *
	 */
	/*prototype.getValue = function()
	{ 
		return null;
	}*/
	

	/*
	 * pour afficher le message de bas de popup
	 *
	 */
	prototype.showBottomMessage = function()
	{
		getElementById(this.id+'_waiting').style.display='';	
	}
	

	/*
	 * pour masquer le message de bas de popup
	 *
	 */
	prototype.hideBottomMessage = function()
	{
		getElementById(this.id+'_waiting').style.display='none';	
	}

	
	/* compatibilit? */
	prototype.startWaiting = this.showBottomMessage;
	prototype.stopWaiting = this.hideBottomMessage;
}
Includes(JSEPopup,JSEPopupUI_iframe);



/*********************************** popup fullscreen ***************************************/

/* 
 * popup de type fullscreen, il s'agit ?galement d'une iframe
 *
 * @comment les attributs de l'objet JSEPopup sont disponibles malgr? que JSEPopupUI_fullscreen n'h?rite pas de l'objet JSEPopup.
 * Ceci grace ? l'appel de la fonction Includes qui recopie les m?thodes de l'objet JSEPopupUI_fullscreen dans l'objet JSEPopup.
 *
 * @comment la m?thode bind() de JSEPopup n'est appel?e qu'une fois, lors de l'affichage de la popup.
 * Tous les attributs susceptibles de changer par l'appel de m?thodes sur l'objet JSEPopup doivent donc etre r?cup?r?s par la m?thode getPropertyValue(). 
 *
 * @extends JSEUIObject
 * @includes JSEPopup
 */

function JSEPopupUI_fullscreen(){
}
Implements(JSEPopupUI_fullscreen,JSEUIObject);
with(JSEPopupUI_fullscreen)
{
	/* 
	 * attributs h?rit?s utilis?s dans cet objet:
	 *	- prefix      (JSEUIObject)   initialis? ? 'generic'
	 *	- container   (JSEPopup)      initialis? avec l'objet HTML destin? ? recevoir le code HTML
	 *	- titlebar    (JSEPopup)      initialis? ? true
	 */

	/* pour obtenir un pointeur sur la iframe */
	prototype.iframe;

	/* utilis? par la fonction Includes */ 
	prototype.prefix = 'fullscreen';


	/*
	 * pour rafraichir le code HTML ? l'int?rieur de la popup
	 */
	prototype.refresh = function()
	{
		var html='';
		var src = this.getAttribute('src');
		
		html+='<iframe id="'+this.id+'_iframe" frameborder="no" src="'+src+'" style="position:absolute;top:0px;left:0px;width:100%;height:100%;border:none;"></iframe>';

		this.container.innerHTML=html;	
		this.iframe = getElementById(this.id+'_iframe');
	}


	/*
	 * pour d?finir les actions ? effectuer quand la popup est affich?e
	 * 
	 * @comment l'affichage est assur?e par ma m?thode show() de JSEPopup
	 *
	 */
	/*prototype.show = function()
	{
	}*/
	

	/*
	 * pour d?finir les actions ? effectuer quand la popup est masqu?e
	 * 
	 * @comment le masquage est assur?e par ma m?thode hide() de JSEPopup
	 *
	 */
	prototype.hide = function()
	{
		if (this.iframe)
		{
			if (this.iframe.location)
			{
				this.iframe.location.href='about:blank'; // trigger the onUnload!
			}
		}
	}


	/*
	 * pour obtenir la valeur retourn?e par la popup
	 *
	 */
	/*prototype.getValue = function()
	{
		return null;
	}*/
	
	//prototype.startWaiting = function(){}	
	//prototype.stopWaiting = function(){}
}
Includes(JSEPopup,JSEPopupUI_fullscreen);



/*********************************** popup properties ***************************************/

/* 
 * popup de type properties, il s'agit ?galement d'une iframe affichant des informations relatives aux popups
 *
 * @comment les attributs de l'objet JSEPopup sont disponibles malgr? que JSEPopupUI_properties n'h?rite pas de l'objet JSEPopup.
 * Ceci grace ? l'appel de la fonction Includes qui recopie les m?thodes de l'objet JSEPopupUI_properties dans l'objet JSEPopup.
 *
 * @comment la m?thode bind() de JSEPopup n'est appel?e qu'une fois, lors de l'affichage de la popup.
 * Tous les attributs susceptibles de changer par l'appel de m?thodes sur l'objet JSEPopup doivent donc etre r?cup?r?s par la m?thode getPropertyValue(). 
 *
 * @extends JSEUIObject
 * @includes JSEPopup
 */

function JSEPopupUI_properties()
{
}
Implements(JSEPopupUI_properties,JSEUIObject);
with(JSEPopupUI_properties)
{
	/* 
	 * attributs h?rit?s utilis?s dans cet objet:
	 *	- prefix      (JSEUIObject)   initialis? ? 'generic'
	 *	- container   (JSEPopup)      initialis? avec l'objet HTML destin? ? recevoir le code HTML
	 *	- titlebar    (JSEPopup)      initialis? ? true
	 */

	/* pour obtenir un pointeur sur la iframe */
	prototype.iframe;

	/* utilis? par la fonction Includes */ 
	prototype.prefix = 'properties';


	/*
	 * pour rafraichir le code HTML ? l'int?rieur de la popup
	 */
	prototype.refresh = function()
	{
		var src = this.getAttribute('src');

		/* apparemment non utilis? */
		// var bHiddenFrame = (this.getAttribute('hiddenFrame')!=null);


		var html='<table width="100%" cellpadding="0" cellspacing="0" height="100%" class="JSPOPUP">';

		/* la barre de titre */
		if (this.titlebar)
		{
			html+=this.writeTitlebar();
		}
		else
		{
		    /* si popup mobile on ajoute les attributs en cons?quence */
		    if (this.move)
		    {
			    html='<table width="100%" cellpadding="0" cellspacing="0" height="100%" class="JSPOPUP" onmousedown="this.style.cursor=\'move\';POPUPSStartMove(\''+this.id+'\', event)" onmouseup="POPUPSEndMove()" />';
		    }
		}

		/* le contenu de la popup */		
		// netscape 6.2 n'arrive pas ? prendre en compte le 100% pour l'attribut height de la iframe, ce bug n'est pas seulement constat? pour la iframe
		// Apr?s tests, on se rend compte qu'un ?l?ment avec height=100% dans une cellule d'un tableau est affich? avec une hauteur r?duite
		// tant pis pour mozilla qui paye en meme temps
		var height=JSisMZ?(this.height+'px'):'100%';
		html+='<tr id="'+this.id+'_container" height="100%"><td align="center" colspan="3">';
		html+='<iframe id="'+this.id+'_iframe" frameborder="no" src="'+src+'" style="width:100%;height:'+height+';border:none;"></iframe>';
		html+='</td></tr>';

		/* le bas de la popup avec les ?ventuels boutons */
		html+='<tr><td align="center" colspan="3" class="JSPOPUP_FOOT"><table><tr>';
		html+=this.buttonCode('properties', 'OK'); //attention, mettre en dur le prefix est volontaire !!
		html+='</tr></table></td></tr></table>';

		html+= '</table>';

		this.container.innerHTML=html;	
		//this.iframe = getElementById(this.id+'_iframe');
		this.iframe = document.frames[this.id+'_iframe'];
	}


	/*
	 * pour d?finir les actions ? effectuer quand la popup est affich?e
	 * 
	 * @comment l'affichage est assur?e par ma m?thode show() de JSEPopup
	 *
	 */
	/*prototype.show = function()
	{
		//getElementById(this.id+'_ok').focus();
	}*/


	/*
	 * pour d?finir les actions ? effectuer quand la popup est masqu?e
	 * 
	 * @comment le masquage est assur?e par ma m?thode hide() de JSEPopup
	 *
	 */
	prototype.hide = function()
	{
		if (this.iframe)
		{
			if (this.iframe.location)
			{
				this.iframe.location.href='about:blank'; // trigger the onUnload!
			}
		}
	}

	

	/*
	 * pour obtenir la valeur retourn?e par la popup
	 *
	 */
	/*prototype.getValue = function() 
	{
		return null; 
	}*/
	


	/*
	 * pour masquer la iframe
	 * @comment cette m?thode doit etre appel?e lors du d?but du chargement du fichier dans la iframe
	 */
	prototype.startWaiting = function()
	{
		getElementById(this.id+'_container').style.display='none';
		// l'?l?ment ci dessous n'est pas d?fini par la fonction refresh !!
		//getElementById(this.id+'_waiting').style.display='';	
	}


	/*
	 * pour afficher la iframe
	 * @comment cette m?thode doit etre appel?e lors de la fin du chargement du fichier dans la iframe
	 */	
	prototype.stopWaiting = function()
	{
		getElementById(this.id+'_container').style.display='';	
		// l'?l?ment ci dessous n'est pas d?fini par la fonction refresh !!
		//getElementById(this.id+'_waiting').style.display='none';
	}
}
Includes(JSEPopup,JSEPopupUI_properties);


function JSEPopupUI_dragAndDropImage() 
{

}
Implements(JSEPopupUI_dragAndDropImage,JSEUIObject);
with(JSEPopupUI_dragAndDropImage)
{
	/* 
	 * attributs h?rit?s utilis?s dans cet objet:
	 *	- prefix      (JSEUIObject)   initialis? ? 'dragAndDropImage'
	 *	- container   (JSEPopup)      initialis? avec l'objet HTML destin? ? recevoir le code HTML
	 *	- titlebar    (JSEPopup)      initialis? ? false
	 */


	/* utilis? par la fonction Includes */ 
	prototype.prefix = 'dragAndDropImage';
	prototype.titleBar = false;	
	prototype.imgSrc = '_blank';
	prototype.firstMouseUp = true;
	prototype.onmousedown = '';
	prototype.onmouseup = '';
	prototype.onmouseover = '';
	prototype.onmouseout = '';
	prototype.dragData = '';
	
	/*
	 * pour rafraichir le code HTML ? l'int?rieur de la popup
	 */
	prototype.refresh = function()
	{			
		if(this.first)
		{
		    var html;        
	        html='<table width="100%" cellpadding="0" cellspacing="0" height="100%" class="JSPOPUP">';
    	    
		    /* le contenu de la popup */
		    html+='<tr height="100%"><td id="popup_'+this.id+'_html" style="background-image:url('+this.imgSrc+')" onmousedown="var popup=popups.get(\''+this.id+'\');eval(popup.onmousedown);if(popup.firstMouseUp==true){if(JSisMZ)popup.container.style.opacity=0.5; else popup.container.style.filter=\'alpha(opacity=50)\';POPUPSStartMove(popup.id, event);popup.firstMouseUp=false;}" onmouseout="var popup=popups.get(\''+this.id+'\');eval(popup.onmouseout);" onmouseover="var popup=popups.get(\''+this.id+'\');eval(popup.onmouseover);" onmouseup="var popup=popups.get(\''+this.id+'\');eval(popup.onmouseup);POPUPSEndMove();popup.hide();popup.container.style.cursor=\'default\';" align="center" height="100%" class="JSPOPUP_TEXT">'
		    html+='&#160;</td></tr>';		    
		    html+='</table>';
            this.container.innerHTML=html;	
            
		}
		else
		{ 
            var td = getElementById('popup_'+this.id+'_html');
            if(td)
            {
                td.style.backgroundImage='url('+this.imgSrc+')';		            
            }
		}
		if (JSisMZ)	        
            this.container.style.opacity=0;        	
        else
            this.container.style.filter='alpha(opacity=0)';
    	
	}
    prototype.onMoveStart = function(e)
    {
        this.container.style.cursor='move';
        POPUPSStartMove(this.id, e);
    }
    prototype.onMoveEnd = function(e)
    {
        this.container.style.cursor='';
        POPUPSEndMove();
    }

	/*
	 * pour d?finir les actions ? effectuer quand la popup est affich?e
	 * 
	 * @comment l'affichage est assur?e par ma m?thode show() de JSEPopup
	 *
	 */
	prototype.show = function(e)
	{
        this.firstMouseUp=true;
    }


	/*
	 * pour obtenir la valeur retourn?e par la popup
	 */
	/*prototype.getValue = function() 
	{ 
		return null; 
	}*/
}
Includes(JSEPopup,JSEPopupUI_dragAndDropImage);


/*********************************** gestionnaire de scroll pour les popups ***************************************/

/* Cette fonction est associ?e ? l'?v?nement onscroll du navigateur pour toujours garder les popup centr?es ? l'?cran */
function JSEPopup_scrollHandler()
{
	// si une fenetre bouge, il ne faut pas la recentrer
	if (popupMoving.popup) return;

	if (popups.activePopup)
	{	
	    if(popups.activePopup.theme!='dragAndDropImage')
	    {		    
		    var div = popups.activePopup.container;
		    if (JSisMZ)
		    {
			    div.style.left=(window.scrollX+div._left)+'px';
			    div.style.top=(window.scrollY+div._top)+'px';
		    }
		    else
		    {
			    div.style.posLeft=document.body.scrollLeft+div._left;
			    div.style.posTop=document.body.scrollTop+div._top;
		    }
		    popupsModalDiv.style.width=(GetClientWidth()>document.body.scrollWidth?GetClientWidth():document.body.scrollWidth)+'px';
			popupsModalDiv.style.height=(GetClientHeight()>document.body.scrollHeight?GetClientHeight():document.body.scrollHeight)+'px';			    
		}
	}	
}



/*********************************** popup calendar ***************************************/

/* 
 * popup de type calendar
 *
 * @comment les attributs de l'objet JSEPopup sont disponibles malgr? que JSEPopupUI_calendar n'h?rite pas de l'objet JSEPopup.
 * Ceci grace ? l'appel de la fonction Includes qui recopie les m?thodes de l'objet JSEPopupUI_calendar dans l'objet JSEPopup.
 *
 * @comment la m?thode bind() de JSEPopup n'est appel?e qu'une fois, lors de l'affichage de la popup.
 * Tous les attributs susceptibles de changer par l'appel de m?thodes sur l'objet JSEPopup doivent donc etre r?cup?r?s par la m?thode getPropertyValue(). 
 *
 * @extends JSEUIObject
 * @includes JSEPopup
 */

function JSEPopupUI_calendar()
{
}
//Implements(JSEPopupUI_prompt,JSEUIObject); // surement un malheureux copier-coller de krzys
Implements(JSEPopupUI_calendar,JSEUIObject);
with(JSEPopupUI_calendar)
{
	/* 
	 * attributs h?rit?s utilis?s dans cet objet:
	 *	- prefix       (JSEUIObject)   initialis? ? 'generic'
	 *	- container    (JSEPopup)      initialis? avec l'objet HTML destin? ? recevoir le code HTML
	 *	- titlebar     (JSEPopup)      initialis? ? true
	 *	- defaultValue (JSEPopup)      initialis? par la m?thode show de JSEPopups
	 */

	/* utilis? par la fonction Includes */ 
	prototype.prefix = 'calendar';


	/*
	 * pour rafraichir le code HTML ? l'int?rieur de la popup
	 */
	prototype.refresh = function()
	{
		var html;
		var msg = this.getAttribute('message');
		if (!msg) msg='';

		html = '<table width="100%" cellpadding="0" cellspacing="0" height="100%" class="JSPOPUP">';

		/* la barre de titre */
		if (this.titlebar)
		{
			html+=this.writeTitlebar();
		}

		/* le message et le champ de saisie sont d?sormais affich?s dans une table HTML 
		   l'icone associ?e au message n'est plus affich?e
		*/
		var table;
		table='<table height="100%">';
		table+='<tr height="50%" valign="bottom"><td align="center">'+msg+'</td></tr>';
		//table+='<tr height="50%" valign="top"><td align="center"><input type="text" size="30" value="'+this.defaultValue+'" id="'+this.id+'_value" onKeyDown="if (event.keyCode==13) {popups.get(\''+this.id+'\').dismiss(this.value);return;}; if (event.keyCode==27) { popups.get(\''+this.id+'\').dismiss(null);return;}"/></td></tr>';
		table+='<tr height="50%" valign="top"><td align="center" id="'+this.id+'_container">&#160;</td></tr>';
		table+='</table>';
		html+='<tr height="100%"><td align="center" colspan="3">'+table+'</td></tr>';

		/* ancien affichage: l'icone associ?e au message n'est plus affich?e */
		//html+='<tr height="50%"><td align="center" colspan="3"><img src="'+this.getPropertyValue('icon')+'" align="absmiddle">&#160;'+msg+'</td></tr>';
		//html+='<tr height="100%"><td align="center" colspan="3">'+msg+'</td></tr>';
		//html+='<tr height="50%"><td align="center" colspan="3"><input type="text" size="30" value="'+this.defaultValue+'" id="'+this.id+'_value" onKeyDown="if (event.keyCode==13) {popups.get(\''+this.id+'\').dismiss(this.value);return;}; if (event.keyCode==27) { popups.get(\''+this.id+'\').dismiss(null);return;}"/></td></tr>';

		/* le bas de la fenetre avec les ?ventuels boutons */
		html+='<tr class="JSPOPUP_FOOT"><td align="center" colspan="3"><table><tr>';
		html+=this.buttonCode('prompt', 'OK', 'CANCEL'); // attention, mettre le prefix en dur est volontaire !!
		html+='</tr></table></td></tr></table>';

		this.container.innerHTML=html;

		/* l'attribut defaultValue n'est pas utilis? par l'objet calendar !! */
		if (!this.defaultValue)
		{
			this.defaultValue=new Date();
		}
		if (typeof(this.defaultValue)!='string')
		{
			this.defaultValue=JSECalendar_Date2AMJ(this.defaultValue);
		}

		/* on ins?re le calendrier dans la cellule de la fenetre */
		this.kalan = new JSECalendar(this.id+'_kalan');
		this.kalan.loadData(this.selectSingleNode("CALENDAR").data);
		this.kalan.write(getElementById(this.id+'_container'));		
		this.kalan.refresh();
	}


	/*
	 * pour d?finir les actions ? effectuer quand la popup est affich?e
	 * 
	 * @comment l'affichage est assur?e par ma m?thode show() de JSEPopup
	 *
	 */
	/*prototype.show = function()
	{
		//getElementById(this.id+'_value').focus();
	}*/


	/*
	 * pour obtenir la valeur retourn?e par la popup
	 */
	prototype.getValue = function() {
		return this.kalan.getValue();
	}
}
Includes(JSEPopup,JSEPopupUI_calendar);




/***** tout le code qui suit a juste ?t? revu pour que la compression se passe bien mais il n'a pas ?t? test? ********/


// PopupButton: /!\ toolkit a l'"ancienne" /!\
var popupbuttons = new JSHolder();
var popupbuttons_currentlyOpened=null;
var wazaclick = false;
function JSEPopupButton(id,src,srcOver,srcDown,title,dir,visible,onShow,onHide,onClick)
{
	if (srcOver=='') srcOver=null;
	if (srcDown=='') srcDown=null;
	if (onClick=='') onClick=null;
	if (onShow=='') onShow=null;
	if (onHide=='') onHide=null;

	this.id = id;
	this.src=src;
	this.srcOver=(srcOver?srcOver:src);
	this.srcDown=(srcDown?srcDown:this.srcOver);
	this.title=(title?title:'');
	this.dir=(dir?dir:'LTR');
	this.visible=(visible==null)?false:visible;
	this.onClick=onClick;
	this.onShow=onShow;
	this.onHide=onHide;
	
	popupbuttons.add(this.id,this);
}
with(JSEPopupButton)
{
	prototype.dropUp=false;
	prototype.forceDropUp=false;
	prototype.width='200';
	prototype.height='147';
	prototype.autoClose=false;	
	prototype._oldMouseDown=null;
	prototype._oldMouseWheel=null;	
	prototype.first=true;
	prototype.disabled=false;	
	prototype.showPadding=0;	
	prototype.writeStart = function()
	{		
		if(this.disabled)
			document.write('<img alt="" id="'+this.id+'_bt" src="'+this.src+'" border="0" style="vertical-align:top;cursor:default"/>');
		else
			document.write('<img alt="" id="'+this.id+'_bt" src="'+this.src+'" lowsrc="'+this.srcOver+'" onMouseOver="switchSrc(this)" onMouseOut="switchSrc(this)" border="0" onClick="popupbuttons.get(\''+this.id+'\').click()" style="vertical-align:top;cursor:hand;cursor:pointer"/>');
			
		this.img = getElementById(this.id+'_bt');
		this.img.obj = this;
		
		document.write('<div onmousewheel="wazaclick=true;" id="'+this.id+'_popup" style="padding:0;position:absolute;visibility:hidden;z-index:667;top:-1000px;left:0px;" onMouseDown="wazaclick=true;return;">');
		this.container = getElementById(this.id+'_popup');
		this.container.obj = this;
		if (this.visible)
		{
			this.visible=false;
			window.setTimeout('popupbuttons.'+this.id+'.show()',25);
		}
		JSGarbageCollector.register(this);
	}
	prototype.writeEnd = function()
	{		
		document.write('</div>');		
	}
	
	prototype.destroy = function()
	{
		if (this.img) this.img.obj=null;
		this.img=null;
		if(this.container && this.container.parentNode) this.container.parentNode.removeChild(this.container);
		if (this.container) this.container.obj=null;
		this.container=null;
	}

	prototype.refreshPosition = function()
	{		
		var debug='';
		var left,x=0,y=0,obj=this.img;				
		while ((obj!=null)&&(obj!=document.body))
		{		
			if(JSisMZ)
			{										
				x+=obj.offsetLeft;
				y+=obj.offsetTop;
				//Gestion du scroll
				if(obj.scrollTop!=0) y-=obj.scrollTop;
				if(obj.scrollLeft!=0) x-=obj.scrollLeft;
				var objParent=obj.parentNode; 
				while(objParent.offsetParent==obj.offsetParent && objParent!=null)
				{
					if(objParent.scrollTop!=0) y-=objParent.scrollTop;
					if(objParent.scrollLeft!=0) x-=objParent.scrollLeft;
					objParent=objParent.parentNode; 
				}					 
			}
			else
			{			
				x+=obj.offsetLeft+(obj.tagName=='TABLE'?0:obj.clientLeft);
				y+=obj.offsetTop+(obj.tagName=='TABLE'?0:obj.clientTop);
				//Gestion du scroll
				if(obj.scrollTop!=0)y-=obj.scrollTop;
				if(obj.scrollLeft!=0) x-=obj.scrollLeft; 
			}
			if (obj.offsetParent==obj) break;
			//if(obj.style.position.toLowerCase()=='absolute') break;				
			obj=obj.offsetParent;
		}		
		// r?cup?ration de la position du div
		var bodyHeight = document.body.clientHeight;		
	    //Netscape 6.2 Compatibility
		if ((!JSisIE) && (!bodyHeight)) bodyHeight = window.innerHeight;		
		this.forceDropUp = ((y+this.img.offsetHeight+this.container.offsetHeight)>(bodyHeight+document.body.scrollTop));
		switch(JSLangDirection.toUpperCase())
		{
			case 'RTL':
				this.container.style.left=x+'px';				
				if(this.dropUp || this.forceDropUp)				
					this.container.style.top=(y-(this.container.offsetHeight==0?this.height:this.container.offsetHeight)-this.showPadding)+'px';				
				else
					this.container.style.top=(y+this.img.offsetHeight+this.showPadding)+'px';								
				break;
			case 'LTR':				
				this.container.style.left=(x-(this.container.offsetWidth==0?this.width:this.container.offsetWidth)+this.img.offsetWidth)+'px';
				if(this.dropUp || this.forceDropUp)					
					this.container.style.top=(y-(this.container.offsetHeight==0?this.height:this.container.offsetHeight)-this.showPadding)+'px';				
				else
					this.container.style.top=(y+this.img.offsetHeight+this.showPadding)+'px';				
				break;
		}	
	}
	prototype.show = function()
	{				
		if(this.first) document.body.insertBefore(this.container,document.body.lastChild);
		this.first=false;
		wazaclick=false;
		if (this.visible) return;
		if (popupbuttons_currentlyOpened)
			if (popupbuttons_currentlyOpened!=this) popupbuttons_currentlyOpened.hide();

		this._oldMouseDown=document.onmousedown;
		this._oldMouseWheel=document.onmousewheel;
		document.onmousedown=this.onMouseDown;
		document.onmousewheel=this.onMouseDown;
		popupbuttons_currentlyOpened=this;
		
		this.container.style.visibility='visible';			
		this.refreshPosition();		
	
		this.visible=true;
		if (this.onShow) eval(this.onShow);
	}
	prototype.hide = function()
	{
		wazaclick=false;			
		if (!this.visible) return;
		if (this._oldMouseDown) document.onmousedown=this._oldMouseDown;
		if (this._oldMouseWeel) document.onmousewheel=this._oldMouseWheel;
		this._oldMouseDown=null;
		this._oldMouseWheel=null;
		popupbuttons_currentlyOpened=null;		
		this.container.style.visibility='hidden';		
		this.visible=false;
		if (this.onHide) eval(this.onHide);
	}
	prototype.toggle = function()
	{
		if(this.disabled) return;
		if (this.visible) 
		{
			this.hide(); 
		}
		else 
		{ 
			this.show();
		}
	}
	prototype.click = function()
	{
		if (this.onClick) eval(this.onClick);
		this.toggle();
	}
	prototype.onMouseDown = function()
	{	   
		if (wazaclick) { wazaclick=false; return; }
		if (popupbuttons_currentlyOpened==null) return;
		if (popupbuttons_currentlyOpened.visible)
			window.setTimeout('popupbuttons.'+popupbuttons_currentlyOpened.id+'.hide()',100);
	}
	prototype.changeButtonSrc = function(src,srcOver,srcDown)
	{
	    if (srcOver=='') srcOver=null;
	    if (srcDown=='') srcDown=null;
	
	    this.src=src;
	    this.srcOver=(srcOver?srcOver:src);
	    this.srcDown=(srcDown?srcDown:this.srcOver);
	    this.img.src=this.src;
	    this.img.lowsrc=this.srcOver;
	}
}

function JSESelect_focus_keyDown(obj,event,id,boxOverClass,boxOutClass)
{    
    if(JSESelects.get(id).disabled) return;
    if(event.keyCode==40)
    {
        if(popupbuttons.get(id).visible)
        {
            var i=-1;            
            if(obj.jse_select_current_idx!=null) i=obj.jse_select_current_idx; 
            var opt=getElementById('jse_select_'+id+'_option_'+i);
            if(opt && getElementById('jse_select_'+id+'_option_'+(i+1)))
            {
                opt.className=boxOutClass;               
            }
            i++;
            opt=getElementById('jse_select_'+id+'_option_'+i);            
            if(opt)
            { 
                opt.className=boxOverClass;
                obj.jse_select_current_idx=i;
                if(opt.offsetTop+opt.offsetHeight>opt.parentNode.offsetHeight)
                {
                    opt.parentNode.scrollTop=opt.offsetTop+opt.offsetHeight-opt.parentNode.offsetHeight;
                }
            }
        } 
        else
        { 
            popupbuttons.get(id).show(); 
        } 
        return;       
    }
    if(event.keyCode==38)
    {
        if(popupbuttons.get(id).visible)
        {
            var i=-1;
            if(obj.jse_select_current_idx!=null) i=obj.jse_select_current_idx; 
            var opt=getElementById('jse_select_'+id+'_option_'+i);
            if(opt && getElementById('jse_select_'+id+'_option_'+(i-1)))
            {
                opt.className=boxOutClass;               
            } 
            i--;           
            opt=getElementById('jse_select_'+id+'_option_'+i);
            if(opt)
            {
                opt.className=boxOverClass;
                obj.jse_select_current_idx=i;
                if(opt.offsetTop<opt.parentNode.scrollTop)
                {
                    opt.parentNode.scrollTop=opt.parentNode.scrollTop-opt.offsetHeight;
                }                
            }            
        }  
        else
        {
             popupbuttons.get(id).show(); 
        }  
        return;                         
    }
    if(event.keyCode==13)
    {
        //Enter select current value.
        if(obj.jse_select_current_idx!=null)
        { 
           JSESelects.get(id).select(obj.jse_select_current_idx);      
        }        
        event.returnValue=false;
        return false;
    }
    if(event.keyCode==27)
    {
        popupbuttons.get(id).hide();
        return;
    }   
    if(event.keyCode==9)
    {
        if(popupbuttons.get(id).visible) popupbuttons.get(id).hide();
        return;       
    }  
    if(event.keyCode<100 && !event.altKey && !event.ctrlKey && event.keyCode>0 && event.keyCode!=16)
    {   
        //window.status = "KeyCode:" + event.keyCode; 
        var c =  String.fromCharCode(event.keyCode).toLowerCase();
        select = JSESelects.get(id);         
        if(select)
        {
            var currentIdx=0;
            if(obj.jse_select_current_idx!=null) currentIdx=obj.jse_select_current_idx;           
            var newIdx=currentIdx;            
            for(var i=0;i<select.options.length;i++)
            {
                var idx=i;
                if(currentIdx>0) idx=(currentIdx+1+i)%select.options.length;
                var label = ''+select.options[idx][1];
                label = label.replace(/[\s\u00A0]/gi,''); 
                
                if(c==label.substring(0,1).toLowerCase())
                {
                    newIdx=idx;
                    break;
                }
            }
        }
        if(newIdx!=currentIdx)
        {
            var lastOpt=getElementById('jse_select_'+id+'_option_'+currentIdx);
            var opt=getElementById('jse_select_'+id+'_option_'+newIdx);
            if(opt && lastOpt)
            {                     
                lastOpt.className=boxOutClass;
                opt.className=boxOverClass;
                obj.jse_select_current_idx=newIdx;
                if(opt.offsetTop+opt.offsetHeight>opt.parentNode.offsetHeight)
                {
                    opt.parentNode.scrollTop=opt.offsetTop+opt.offsetHeight-opt.parentNode.offsetHeight;
                } 
                if(!popupbuttons.get(id).visible)
                {
                    popupbuttons.get(id).show(); 
                }               
            }  
        }
    }
}

var JSESelects = new JSHolder();
function JSESelect(id,opts,overflow)
{
	this.id = id;
	this.options = opts;
	this.overflow=(overflow?overflow:14);
	JSESelects.add(id,this);
}
with(JSESelect)
{
	prototype.imageCombo=false;
	prototype.imageComboWidth=12;
	prototype.dropUp=false;
	prototype.value=null;
	prototype.text='';
	prototype.selectedIndex=-1;
	prototype.onClick=null;
	prototype.onChange=null;
	prototype.onStateChange=null;
	prototype.width=null;
	prototype.lettersChars = "il.:'Ijf)} 0123456789EFJL-abcde?ghknopqrstuvxyzABHKNPRSTmUMQCDGOVXYZW";
	prototype.lettersWidth = "1111144444466666666666666666666e6666666666666667777777777888888888889";
	prototype.resizeIntervalId = 0;
	prototype.overflow = 14;
	prototype.isOverflow = false;
	prototype.disabled = false;
	prototype.iconOn='JSE/JSSelectBox_On.gif';
	prototype.iconOff='JSE/JSSelectBox_Off.gif';
	prototype.iconDisabled='JSE/JSSelectBox_Disabled.gif';	
	prototype.iconRequired='JSE/JSSelectBox_Required.gif';		
	prototype.boxInputClass='JSSELECTBOXINPUT';
	prototype.boxInputSelectedClass='JSSELECTBOXINPUT_SELECTED';
	prototype.boxInputRequiredClass='JSSELECTBOXINPUT_INVALID';	
	prototype.boxPanelClass='JSSELECTBOXPANEL';
	prototype.boxOutClass='JSSELECTBOXOUT';
	prototype.boxOverClass='JSSELECTBOXOVER';
	prototype.required=false;
	prototype.initialValue=null;
	prototype.state=1;
	prototype.fisrtResize=true;
	prototype.fixedWidth=false;
	prototype.xform='';
		
	prototype.guessSize = function(s)
	{
		var l=s.length;
		if (l<3) return l*8;
		var sz = 0;
		for(var i=0;i<l;i++)
		{
			c=s.charAt(i);
			var p=this.lettersChars.indexOf(c);
			if (p>=0)
				sz+=parseInt(this.lettersWidth.charAt(p)); 			
			else
				sz+=4;			
		}
		return sz+s.length;
	}
	prototype.write = function()
	{		
		var l=0;
		var longestLabel='';
		if (this.width)
		{
			l=this.width;			
		}
		else
		{						
			for(var i=0;i<this.options.length;i++)
			{				
				var l2=this.options[i][1].length;
				if (l2>l) { longestLabel=this.options[i][1];l=l2; }
			}			
			l=this.guessSize(longestLabel)+8;							
		}
		this.width=l;
		
		this.resizeIntervalId = window.setInterval('try{getElementById("'+this.id+'").obj.resize()}catch(e){}',500);
		//Desactivee car pause des problemes lorsque le controle est display None
		//window.setTimeout('window.clearInterval('+this.resizeIntervalId+');',10000);	
	
		document.write('<input type="hidden" name="'+this.id+'" id="'+this.id+'"/>');
		this.container = getElementById(this.id);			
		this.container.obj=this;
		JSGarbageCollector.register(this);
		this.container.selectedIndex=-1;
		this.container.addOption=function(value,text){this.obj.addOption(value,text);};
		this.container.select=function(id){this.obj.select(id);};
		document.write('<div onkeydown="if(event.keyCode==40 || event.keyCode==38) return false;"><a href="#" id="'+this.id+'_ahref" onkeydown="JSESelect_focus_keyDown(this,event,\''+this.id+'\',\''+this.boxOverClass+'\',\''+this.boxOutClass+'\')" onfocus="var input = getElementById(\''+this.id+'_fake\'); if(input){input.lastClassName=input.className; input.className=\''+this.boxInputSelectedClass+'\'; var xform=\''+this.xform+'\'; if(document.xforms){var xformObj = XFORMGetForm(this.xform); if(xformObj) xformObj.focus();}}" onblur="var input=getElementById(\''+this.id+'_fake\');if(input){input.className=input.lastClassName; var xform=\''+this.xform+'\'; if(document.xforms){var xformObj = XFORMGetForm(this.xform); if(xformObj) xformObj.blur();}}"><table dir="ltr" onmousedown="wazaclick=true;return;" id="'+this.id+'_table" id="'+this.id+'_table" style="wdith:'+l+'px" cellpadding="0" cellspacing="0" class="'+(this.required?this.boxRequiredClass:this.boxClass)+'"><tr>');
		if(JSLangDirection.toUpperCase()=='LTR') document.write('<td><div style="'+(this.fixedWidth?'height:'+(JSisMZ?'14px':'16px')+'px;width:'+(l-(JSisMZ?19:19))+'px;overflow:hidden':'')+'" dir="ltr" id="'+this.id+'_fake" class="'+(this.required?this.boxInputRequiredClass:this.boxInputClass)+'" onclick="popupbuttons.'+this.id+'.toggle();">'+longestLabel+'</div></td>');			
			
		document.write('<td width="16">');	
		this.popupbutton = new JSEPopupButton(this.id,skinCache.getImage(this.disabled?this.iconDisabled:(this.required?this.iconRequired:this.iconOff)),skinCache.getImage(this.disabled?this.iconDisabled:(this.required?this.iconRequired:this.iconOff)),skinCache.getImage(this.disabled?this.iconDisabled:(this.required?this.iconRequired:this.iconOn)),'',JSLangDirection,false,'getElementById(\''+this.id+'_ahref\').focus();','','');
		this.popupbutton.disabled=this.disabled;
		this.popupbutton.autoClose=true;
		this.popupbutton.width=l;	
		this.popupbutton.showPadding=0;	
		this.popupbutton.dropUp=this.dropUp;		
		this.popupbutton.writeStart();		
		
		if (this.options.length>this.overflow)		
		{	
			this.isOverflow = true;
			document.write('<div dir="'+JSLangDirection.toLowerCase()+'" id="'+this.id+'_container" class="'+this.boxPanelClass+'" style="position:relative;height:'+(this.overflow*14+4)+'px;overflow-y:scroll;overflow-x:hidden">');
		}
		else
		{
			this.isOverflow = false;
			document.write('<div dir="'+JSLangDirection.toLowerCase()+'" id="'+this.id+'_container" class="'+this.boxPanelClass+'" style="position:relative;">');					
		}
		if(!this.disabled) this.writeOptions();
		document.write('</div>');
		this.popupbutton.writeEnd();			
		document.write('</td>');
		if(JSLangDirection.toUpperCase()=='RTL') document.write('<td><div dir="rtl" style="'+(this.fixedWidth?'height:'+(JSisMZ?'14px':'16px')+'px;width:'+(l-(JSisMZ?19:19))+'px;overflow:hidden':'')+'" id="'+this.id+'_fake" class="'+(this.required?this.boxInputRequiredClass:this.boxInputClass)+'" onclick="popupbuttons.'+this.id+'.toggle();">'+longestLabel+'</div></td>');			
					
		document.write('</tr></table></a></div>');		
		var tbl=getElementById(this.id+'_table');
		if(this.required) this.state=0;	
		
		if(document.xforms)
		{
			var xformObj = XFORMGetForm(this.xform);			
			if(xformObj && xformObj.currentZone) 
			{
				xformObj.currentZone.addItem(getElementById(this.id+'_ahref'));				
			}
		}
		
		
	}

	prototype.clone = function(cloneId)
	{		
		var JSESelectClone = new JSESelect(cloneId,this.options,this.overflow)
		JSESelectClone.fixedWidth=this.fixedWidth;

        JSESelectClone.imageCombo=this.imageCombo;
        JSESelectClone.imageComboWidth=this.imageComboWidth;
		JSESelectClone.dropUp=this.dropUp;
		JSESelectClone.value=this.value;
		JSESelectClone.text=this.text;
		JSESelectClone.selectedIndex=this.selectedIndex;
		JSESelectClone.onClick=this.onClick;
		JSESelectClone.onChange=this.onChange;
		JSESelectClone.onStateChange=this.onStateChange;
		JSESelectClone.width=this.width;
		JSESelectClone.overflow = this.overflow;
		JSESelectClone.isOverflow = this.isOverflow;
		JSESelectClone.disabled = this.disabled;
		JSESelectClone.iconRequired=this.iconRequired;
		JSESelectClone.iconOn=this.iconOn;
		JSESelectClone.iconOff=this.iconOff;
		JSESelectClone.iconDisabled=this.iconDisabled;
		JSESelectClone.boxInputClass=this.boxInputClass;
		JSESelectClone.boxPanelClass=this.boxPanelClass;
		JSESelectClone.boxOutClass=this.boxOutClass;
		JSESelectClone.boxOverClass=this.boxOverClass;
		JSESelectClone.required=this.required;
		JSESelectClone.initialValue=this.initialValue;
		JSESelectClone.state=this.state;
		JSESelectClone.fisrtResize=false;
		JSESelectClone.xform=this.xform;

		JSESelectClone.resizeIntervalId = window.setInterval('try{getElementById("'+cloneId+'").obj.resize()}catch(e){}',500);
		JSESelectClone.container = getElementById(cloneId);			
		JSESelectClone.container.obj=JSESelectClone;
		JSGarbageCollector.register(JSESelectClone);
		JSESelectClone.container.selectedIndex=this.container.selectedIndex;
		JSESelectClone.container.addOption=function(value,text){this.obj.addOption(value,text);};
		JSESelectClone.container.select=function(id){this.obj.select(id);};
			
		JSESelectClone.popupbutton = new JSEPopupButton(JSESelectClone.id,skinCache.getImage(JSESelectClone.disabled?JSESelectClone.iconDisabled:JSESelectClone.iconOff),skinCache.getImage(JSESelectClone.disabled?JSESelectClone.iconDisabled:JSESelectClone.iconOff),skinCache.getImage(JSESelectClone.disabled?JSESelectClone.iconDisabled:JSESelectClone.iconOn),'',JSLangDirection,false,'','','');
		JSESelectClone.popupbutton.img = getElementById(JSESelectClone.popupbutton.id+'_bt');
		JSESelectClone.popupbutton.img.obj = JSESelectClone.popupbutton;		
		JSESelectClone.popupbutton.container = getElementById(cloneId+'_popup');
		JSESelectClone.popupbutton.container.obj = JSESelectClone.popupbutton;
		JSESelectClone.popupbutton.onShow='getElementById(\''+JSESelectClone.id+'_ahref\').focus();';
		JSGarbageCollector.register(JSESelectClone.popupbutton);
		
		return(JSESelectClone);
		
	}


	prototype.reset=function()
	{
		this.selectByValue(this.initialValue,true);
		this.resize();
		if(this.required)
		{			
			if(this.state==1)
			{			
				var fake =getElementById(this.id+'_fake');
				fake.className=this.boxInputRequiredClass;
				fake.lastClassName=this.boxInputRequiredClass;
				this.popupbutton.changeButtonSrc(skinCache.getImage(this.iconRequired),skinCache.getImage(this.iconRequired),skinCache.getImage(this.iconRequired));
				//Start change state events			
				this.state=0;//State user has not selected a value
				if(this.onStateChange) { eval(this.onStateChange); }
			}
		}		
	}
	
	prototype.hasValue=function()
	{		
		if(this.required)
		{
			if(this.state==0)
			{
				var fake =getElementById(this.id+'_fake');
				fake.className=this.boxInputClass;
				fake.lastClassName=this.boxInputClass;
				this.popupbutton.changeButtonSrc(skinCache.getImage(this.iconOff),skinCache.getImage(this.iconOff),skinCache.getImage(this.iconOn));
				//Start change state events
				this.state=1;//State user has not selected a value
				if(this.onStateChange) { eval(this.onStateChange); }
			}
		}
	}
	
	prototype.select=function(id,noEvents)
	{			
		var oldIndex=this.selectedIndex;
		var fake =getElementById(this.id+'_fake');
		var opt=null;
		if(id>=this.options.length)
		{
			opt = ['','&#160;'];
			this.container.selectedIndex=-1;
			this.selectedIndex=-1;
		}
		else
		{ 			
			opt = this.options[id];
			this.container.selectedIndex=id;
			this.selectedIndex=id;
		}		
		if(opt==null) return;
		this.value=opt[0];
		this.text=opt[1];			
		this.container.value=opt[0];
		this.container.text=opt[1];
		var imageCode='';
	    if(this.imageCombo)
	    {
		    var hasImg = (opt.length==3 && opt[2].length!='');
		    imageCode = '<img '+(hasImg?'':' width="'+this.imageComboWidth+'"')+' valign="middle" border="0" hspace="1" vspace="0" style="margin:0px;padding:0px" src="'+JSPath2Images+(hasImg?opt[2]:'general/vide.gif')+'" alt="">';
		}
		fake.innerHTML=imageCode+((opt[1]!='')?opt[1]:'&#160;');
		fake.title = opt[1];
		
		if(this.fixedWidth) fake.style.overflow='hidden';
		popupbuttons[this.id].hide();
		
		if (!noEvents)
		{
			var ahref = getElementById(this.id+'_ahref');
		    if(ahref){try{ahref.blur();ahref.focus();}catch(e){}}
			if(this.required) 
			{				
				if(this.state==0)
				{
					fake.className=this.boxInputClass;
					fake.lastClassName=this.boxInputClass;
					this.popupbutton.changeButtonSrc(skinCache.getImage(this.iconOff),skinCache.getImage(this.iconOff),skinCache.getImage(this.iconOn));
					//Start change state events
					this.state=1;//State user has selected a value
					if(this.onStateChange) { eval(this.onStateChange); }
				}
			}
			if (oldIndex!=id)
			{				
				if(this.onChange) { eval(this.onChange); }
			}			
		}
		
	}
	prototype.selectByValue = function(value,noEvents)
	{		
		var id=0;
		
		for(var i=0;i<this.options.length;i++)
			if (value==this.options[i][0]) { return this.select(i,noEvents); }
		
		this.select(id,noEvents);
	}
	prototype.writeOptions = function(obj)
	{
		var html='';
		for(var i=0;i<this.options.length;i++)
		{
		    var imageCode='';
			if(this.imageCombo)
			{
			    var hasImg = (this.options[i].length==3 && this.options[i][2].length!='');
			    imageCode = '<img '+(hasImg?'':'width="'+this.imageComboWidth+'"')+' valign="middle" border="0" hspace="1" vspace="0" style="margin:0px;padding:0px" src="'+JSPath2Images+(hasImg?this.options[i][2]:'general/vide.gif')+'" alt="">';
			}
			if(JSisMZ)
				html+='<div id="jse_select_'+this.id+'_option_'+i+'" value="'+this.options[i][0]+'" style="overflow:hidden;white-space:nowrap" class="'+this.boxOutClass+'" onmouseover="this.className=\''+this.boxOverClass+'\'; var ahref=getElementById(\''+this.id+'_ahref\');if(ahref){ var opt=getElementById(\'jse_select_'+this.id+'_option_\'+ahref.jse_select_current_idx);if(opt){opt.className=\''+this.boxOutClass+'\';} ahref.jse_select_current_idx='+i+'}" onmouseout="this.className=\''+this.boxOutClass+'\'" onClick="getElementById(\''+this.id+'\').select('+i+')">'+imageCode+this.options[i][1]+'</div>';
			else
				html+='<div id="jse_select_'+this.id+'_option_'+i+'" value="'+this.options[i][0]+'" style="overflow:hidden;white-space:nowrap" class="'+this.boxOutClass+'" onmouseover="this.className=\''+this.boxOverClass+'\'; var ahref=getElementById(\''+this.id+'_ahref\');if(ahref){ var opt=getElementById(\'jse_select_'+this.id+'_option_\'+ahref.jse_select_current_idx);if(opt){opt.className=\''+this.boxOutClass+'\';} ahref.jse_select_current_idx='+i+'}" onmouseout="this.className=\''+this.boxOutClass+'\'" onClick="getElementById(\''+this.id+'\').select('+i+')">'+imageCode+this.options[i][1]+'</div>';
		}
		if (obj)
		{			
			obj.innerHTML=html;			
		}
		else 
		{			
			document.write(html);
		}
	}
	
	prototype.addOption = function(value,text)
	{
		var opt=[value,text];		
		this.options[this.options.length]=opt;
		this.writeOptions(getElementById(this.id+'_container'));
		
	}	
	prototype.setOptions = function(options)
	{			
		delete this.options;		
		this.options = options;
		
		var obj=getElementById(this.id+'_container');
		if (this.options.length>this.overflow)// && !JSisMZ)
		{			
			this.isOverflow = true;
			obj.style.overflow='auto';
			obj.style.height=(this.overflow*14+4)+'px';
		}
		else
		{
			this.isOverflow = false;
			obj.style.overflow='';
			obj.style.height='';
		}			
		this.writeOptions(getElementById(this.id+'_container'));				
	}
	prototype.clear = function()
	{		
		for(var i=0;i<this.options.length;i++)
		{
			delete this.options[i];
		}
		delete this.options;
		this.options = new Array();
		this.writeOptions(getElementById(this.id+'_container'));
		var newWidth = (this.fixedWidth?this.width:20);
		getElementById(this.id+'_table').style.width = newWidth+'px';						
		getElementById(this.id+'_container').style.width = (JSisMZ?newWidth-2:newWidth)+'px';
		getElementById(this.id+'_popup').style.width = newWidth+'px';		
		this.fisrtResize=true;		
	}
	prototype.destroy = function()
	{	
		if (this.container) this.container.obj=null;
		this.container=null;	
		if(this.options)
		{			
			for(var i=0;i<this.options.length;i++)
			{
				delete this.options[i];
			}
			delete this.options;		
		}
		if(this.popupbutton) this.popupbutton.destroy();
		this.popupbutton=null;
		
	}		
	prototype.resize = function()
	{		
		//Recalcul de la taille du select;	
		if(this.popupbutton.container.offsetWidth!=0)
		{
			var newWidth;
			window.clearInterval(this.resizeIntervalId);				
			if(this.isOverflow)		
			{	
				if(JSisMZ) this.setOptions(this.options);
				newWidth = this.popupbutton.container.offsetWidth;									
			}
			else
			{						
				if(JSLangDirection.toUpperCase()=='RTL' && JSisMZ) 
				{
					newWidth = getElementById(this.id+'_table').offsetWidth;
				}
				else
				{
					newWidth = this.popupbutton.container.offsetWidth+(this.fisrtResize?this.popupbutton.img.offsetWidth:0);					
					this.fisrtResize=false;										
				}
				if(JSisMZ)
				{
					var testWidth = newWidth;
					for(var i=0;i<getElementById(this.id+'_container').childNodes.length;i++)
					{
						var child=getElementById(this.id+'_container').childNodes[i];							
						if(child.scrollWidth>testWidth) testWidth=child.scrollWidth+this.popupbutton.img.offsetWidth;
					}
					newWidth=testWidth;						
				}
			}
			if(this.fixedWidth)			
			{			   
			    if(newWidth<this.width) newWidth = this.width;		    
			}
			else
			{
			    getElementById(this.id+'_table').style.width = newWidth+'px';
			}    
			getElementById(this.id+'_container').style.width = (JSisMZ?newWidth-2:newWidth)+'px';
			getElementById(this.id+'_popup').style.width = newWidth+'px';
			if(getElementById(this.id).value != this.value) this.selectByValue(getElementById(this.id).value);							
		}			
	}
}

var dateSelectors = new JSHolder();
function JSEDateSelector(id,date,onChange)
{
	var d = new Date();
	this.todayValue = ''+d.getFullYear()+LZ(''+(d.getMonth()+1))+LZ(''+d.getDate());
	this.initialValue=date;
	if(date==null || date=='')
	{	 
		date = this.todayValue;
		if(this.required) this.value=date;
	}	
	else
	{		    
	    this.value=date;	
	}  
	this.id=id;	
	this.onChange=onChange;	
	this.year=parseInt2(date.substring(0,4));
	this.month=parseInt2(date.substring(4,6));
	this.day=parseInt2(date.substring(6,8));
	//this.value = ''+this.year+LZ(this.month)+LZ(this.day);
	this.generalizedTimeFormat  = this.value+'000000.0Z';
	dateSelectors.add(id,this);
	JSECalendarUI.prototype.setLang(JSLangCode);		
	this.dayNames = JSECalendarUI.prototype.langs[1];
	this.state=1;	
}
with(JSEDateSelector)
{
	prototype.dropUp=false;
	prototype.year = 0;
	prototype.month = 0;
	prototype.day = 0;
	prototype.value = '00000000';
	prototype.initialValue = '00000000';
	prototype.dayNames = null;
	prototype.disabled=false;
	prototype.simpleMode=false;
	prototype.textMode=false;
	prototype.scale='day';
	prototype.generalizedTimeFormat='00000000';
	prototype.startYear=2000;
	prototype.numberOfYear=10;
	prototype.staticYearList=false;
	prototype.required=false;
	prototype.onChange=null;
	prototype.onStateChange=null;
	prototype.objCal=null;
	prototype.objPop=null;
	prototype.objName=null;
	prototype.date_AMJ = /^(\d{4})(\d{2})(\d{2})$/;
	prototype.date_JMA = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{2}|\d{4})$/;
	prototype.date_MA = /^(\d{1,2})(\/|-)(\d{2}|\d{4})$/;
	prototype.date_AMJHMS = /^(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})$/;
	prototype.format = 'JJ/MM/AAAA';
	prototype.todayValue = '';
			
	prototype.lateBind = function()
	{		
		if(!this.textMode)
		{
		    var selectDay = eval('g_dateSelector_'+this.id+'_day');
		    var selectMonth = eval('g_dateSelector_'+this.id+'_month');
		    var selectYear = eval('g_dateSelector_'+this.id+'_year');		
		    selectDay.initialValue=this.day;		
		    selectMonth.initialValue=this.month;		
		    selectYear.initialValue=this.year;
		}
		this.objName = getElementById(this.id+'_nameDay');
		this.objPop = popupbuttons[this.id+'_pop'];
		this.objCal = calendars[this.id+'_cal'];		
		JSGarbageCollector.register(this);
		if(this.required) this.state=0;		
		if(this.textMode) getElementById(this.id+'_textbox').value=(this.value=='00000000'?'':this.displayDate());		
		if(!prototype.disabled) this.refresh(true);
	}
	
	prototype.destroy = function()
	{		
		if(!this.textMode)
		{
		    try
		    {
		        var selectDay = eval('g_dateSelector_'+id+'_day');
		        var selectMonth = eval('g_dateSelector_'+this.id+'_month');
		        var selectYear = eval('g_dateSelector_'+this.id+'_year');
		        //Destroy Select of Date Calendar
		        if(selectDay) selectDay.destroy();
		        //this.objYear = null;
		        if(selectMonth) selectMonth.destroy();
		        //this.objMonth = null;
		        if(selectYear) selectYear.destroy();
		        //this.objDay = null;
		    }
		    catch(ex){}
		}
		this.objName = null;
		this.objPop = null;
		this.objCal = null;			
	}

	prototype.refresh = function(majDay,dontMajCal)
	{			
		var nbDays = JSECalendarUI.prototype.daysInMonth(this.month-1,this.year);			
		var optDays=new Array();
        if(!this.textMode)
        {
	        var selectDay   = eval('g_dateSelector_'+this.id+'_day');
	        var selectMonth = eval('g_dateSelector_'+this.id+'_month');
	        var selectYear  = eval('g_dateSelector_'+this.id+'_year');
	    }
	    
	    switch(this.scale)
	    {
		    case 'day':
			    if(!this.textMode)
			    {
			        if (majDay)
			        {		
				        for(var i=0;i<nbDays;i++) optDays[i]=[LZ(i+1),LZ(i+1)];
				        selectDay.setOptions(optDays);
			        }					
			        selectDay.select(this.day-1,true);
			    }
			    break;
		    case 'week':
			    var d=new Date(this.year,this.month-1,this.day);										
			    if(d.getDay()!=1)
			    {	
				    d.setDate(d.getDate()-(d.getDay()-1));
				    this.month=d.getMonth()+1;						
				    this.year=d.getFullYear();
				    this.day=d.getDate();
			    }
			    if(!this.textMode)
			    {									
			        d=new Date(this.year,this.month-1,1);					
			        var start=d.getDay();
			        if(start!=1)
				        start=8-start;					
			        var iSel=0;
			        for(var i=start;i<nbDays;i=i+7)
			        { 
				        if(i==this.day-1) iSel=optDays.length; 
				        optDays[optDays.length]=[LZ(i+1),LZ(i+1)];
			        }
			        selectDay.setOptions(optDays);		
			        selectDay.select(iSel,true);
			    }
			    break;
		    case 'month':
			    if(!this.textMode)
			    {
			        optDays[0]=[01,01];
			        selectDay.setOptions(optDays);		
			        selectDay.select(0,true);
			    }
			    break;
		    default:
			    if(!this.textMode)
			    {
			        if (majDay)
			        {
				        for(var i=0;i<nbDays;i++) optDays[i]=[LZ(i+1),LZ(i+1)];
				        selectDay.setOptions(optDays);		
			        }
			        selectDay.select(this.day-1,true);
			    }
			    break;
	    }
		if(!this.textMode)
		{			
		    //Recentrage des ann?es
		    if(this.staticYearList==false)
		    {
			    var optsYear = new Array(),iStartYear=this.year-(this.numberOfYear/2);
			    for(var i=0;i<=this.numberOfYear;i++) optsYear[i]=[''+(iStartYear+i),''+(iStartYear+i)];
			    selectYear.setOptions(optsYear);							
		    }		
		    if (getElementById(this.id+'_year').value!=this.year) selectYear.selectByValue(this.year,true);
		    if (getElementById(this.id+'_month').value!=this.month) selectMonth.select(this.month-1,true);		
		}
		if(getElementById(this.id)) getElementById(this.id).value = (this.textMode?getElementById(this.id+'_textbox').value:this.value);		
		var d = new Date(this.year,this.month-1,this.day);
		if(!this.simpleMode && this.scale=='day') getElementById(this.id+'_nameDay').innerHTML = this.dayNames[d.getDay()];
		delete d;
		if (!dontMajCal)
		{
			this.objCal.documentElement.putPropertyValue('date',(this.value=='00000000'?this.todayValue:this.value));
		}

	}
	//Renvoie vrai si la date est valide
	prototype.isValid = function()
	{
	    if(this.textMode)
	        return (this.checkDateFormat(this.value,false)!=null);
	    else
	        return true;
	}
	prototype.isEmpty = function()
	{	    
	    if(this.value=='00000000')
	        return true;
	    else
	        return false;
	}	
	prototype.setValue = function(y_or_value,m,j,dontMajCal)
	{
		var y,value;
		if (m==null)
		{	    
			if(y_or_value!='')
			{
			    y=parseInt2(y_or_value.substring(0,4));
			    m=parseInt2(y_or_value.substring(4,6));
			    j=parseInt2(y_or_value.substring(6,8));
			    value=y_or_value;
			}	
			else
			{
			    y=0;
			    m=0;
			    j=0;
			    value='00000000';
			}		
		}
		else
		{
			y=parseInt2(y_or_value);
			m=parseInt2(m);
			j=parseInt2(j);
			value=''+y+LZ(m)+LZ(j);
		}

		var majDay = ((this.month!=m)||(this.year!=y));
		this.year=y;
		this.month=m;
		this.day=j;
		var oldValue = this.value;
		this.value=value;		
		this.generalizedTimeFormat  = this.value+'000000.0Z';
		if(this.textMode) 
		{ 		   
		    getElementById(this.id+'_textbox').value=(this.value=='00000000'?'':this.displayDate());
		    if(this.value=='00000000' && this.required==true) getElementById(this.id+'_textbox').className='XFORMSTEXTBOX_INVALID'; else getElementById(this.id+'_textbox').className='XFORMSTEXTBOX_VALID';
		}
		this.refresh(majDay,dontMajCal);
		if(getElementById(this.id)) 
		{
		    getElementById(this.id).value = (this.textMode?getElementById(this.id+'_textbox').value:this.value);		
		}
		if (this.onChange) 
		{ 			
			if(this.value!=oldValue)
			{
				eval(this.onChange); 
			}
		}
		if(this.required)
		{
			if(this.state==0)
			{
				this.state=1;
				if(!this.textMode)
				{
				    var selectDay   = eval('g_dateSelector_'+this.id+'_day');
				    var selectMonth = eval('g_dateSelector_'+this.id+'_month');
				    var selectYear  = eval('g_dateSelector_'+this.id+'_year');			
				    selectDay.hasValue();
				    selectMonth.hasValue();
				    selectYear.hasValue();	
				}
				if(this.onStateChange) eval(this.onStateChange);
			}
		}
	}

	prototype.addValue = function(delta)
	{	
		var majDay=false;
		switch(this.scale)
		{
			case 'day':
				this.day+=delta;
				if (this.day==0)
				{ // previous month
					majDay=true;
					this.month--;
					if (this.month==0) { this.month=12; this.year--; }
					this.day=JSECalendarUI.prototype.daysInMonth(this.month-1,this.year);			
				}
				else 
				{
					if (this.day>JSECalendarUI.prototype.daysInMonth(this.month-1,this.year))
					{ // next month
						majDay=true;
						this.day=1;
						this.month++;
						if (this.month==13) { this.month=1; this.year++; }
					}
				}
				break;
			case 'week':
				var d=new Date(this.year,this.month-1,this.day);
				d.setDate(d.getDate()+(delta*7));
				this.day=d.getDate();
				this.month=d.getMonth()+1;
				this.year=d.getFullYear();
				break;
			case 'month':
				this.month+=delta;
				if (this.month==0) { this.month=12; this.year--; }
				if (this.month==13) { this.month=1; this.year++; }
				break;
		}	
		var oldValue = this.value;	
		this.value = ''+this.year+LZ(this.month)+LZ(this.day);
		this.generalizedTimeFormat  = this.value+'000000.0Z';
		if(this.textMode) 
		{  		   
		    getElementById(this.id+'_textbox').value=(this.value=='00000000'?'':this.displayDate());
		    if(this.value=='00000000' && this.required==true) getElementById(this.id+'_textbox').className='XFORMSTEXTBOX_INVALID'; else getElementById(this.id+'_textbox').className='XFORMSTEXTBOX_VALID';
		}
		this.refresh(majDay);
		if (this.onChange) 
		{ 			
			if(this.value!=oldValue) eval(this.onChange); 			
		}
		if(this.required)
		{
			if(this.state==0)
			{
				this.state=1;
				if(!this.textMode)
				{
				    var selectDay   = eval('g_dateSelector_'+this.id+'_day');
				    var selectMonth = eval('g_dateSelector_'+this.id+'_month');
				    var selectYear  = eval('g_dateSelector_'+this.id+'_year');			
				    selectDay.hasValue();
				    selectMonth.hasValue();
				    selectYear.hasValue();	
				}
				if(this.onStateChange) eval(this.onStateChange);
			}
		}
	}
	//The Date change
	prototype.selHasChanged = function()
	{		
		this.setValue(getElementById(this.id+'_year').value,getElementById(this.id+'_month').value,getElementById(this.id+'_day').value);
	}
	
	//Reintialise the component
	prototype.reset=function()
	{		
		this.setValue(this.initialValue);		
		if(!this.textMode) 
		{
		    var selectDay   = eval('g_dateSelector_'+this.id+'_day');
		    var selectMonth = eval('g_dateSelector_'+this.id+'_month');
		    var selectYear  = eval('g_dateSelector_'+this.id+'_year');	
		    selectDay.reset();
		    selectMonth.reset();
		    selectYear.reset();	
		}
		if(this.required)
		{
			if(this.state==1)
			{
				this.state=0;
				if(this.onStateChange) eval(this.onStateChange);
			}
			if(this.textMode) 
			{
			    //getElementById(this.id+'_textbox').value = this.initialValue;
			    getElementById(this.id+'_textbox').className='XFORMSTEXTBOX_INVALID';
			}
		}		
		
	}
	
	// teste le format de la date
	prototype.checkDateFormat=function(value,hms)
	{		
		if(value==''){return '';};
		var j,m,a;	
		var h,n,s;
		reg=this.date_AMJ;
		if (reg.test(value))
		{
			ar=reg.exec(value);
			j=parseInt(ar[3],10);m=parseInt(ar[2],10);a=parseInt(ar[1],10);
			h=n=s=0;
		}
		else
		{
			reg=this.date_JMA;
			if (reg.test(value))
			{
				ar=reg.exec(value);
				j=parseInt(ar[1],10);m=parseInt(ar[3],10);a=parseInt(ar[5],10);
				h=n=s=0;
			}
			else
			{
				//if (this.format)
				//{
					/*switch(this.format)
					{
						case 'AAAA':
							// 2 to 4 digits
							if (/^\d{2,4}$/.test(value))
							{
								a=parseInt(value,10);
								j=m=1;
								h=n=s=0;
							}
							else return null;
							break;
						case 'AAAAMM':
							// 2 to 6 digits, or "[#]#/[[#]#]##"
							if (/^\d{2,6}$/.test(value))
							{
								a=parseInt(value,10);
								m=a%100;
								a=(a-m)/100;
								j=1;
								h=n=s=0;
							}
							else if (this.date_MA.test(value))
							{
								ar=this.date_MA.exec(value);
								a=parseInt(ar[3],10);
								m=parseInt(ar[1],10);
								j=1;
								h=n=s=0;
							}
							else 
							{
								return null;
							}
							break;
						case 'AAAAMMJJHHMMSS':*/
							if (/^\d{10,14}$/.test(value))
							{
								a=parseInt(value,10);
								s=a%100;a=(a-s)/100;
								n=a%100;a=(a-n)/100;
								h=a%100;a=(a-h)/100;
								j=a%100;a=(a-j)/100;
								m=a%100;a=(a-m)/100;
							}
							else if (this.date_AMJHMS.test(value))
							{
								ar=this.date_AMJHMS.exec(value);
								a=parseInt(ar[1],10);
								m=parseInt(ar[2],10);
								j=parseInt(ar[3],10);
								h=parseInt(ar[4],10);
								n=parseInt(ar[5],10);
								s=parseInt(ar[6],10);
							}
							else return null;
							/*break;
							
						default:
							return null;
					}			
				}*/
			}
		}
		if (a<100) if (a>30) a+=1900; else a+=2000;
		if ((j<1)||(j>31)) return null;
		if ((m<1)||(m>12)) return null;
		var dt=new Date(a,m-1,j);
		if (dt.getMonth()+1!=m) return null; // (jour > 28|30|31)
		a=''+a; if (a.length==3) a='0'+a;
		if (hms) return a+LZ(m)+LZ(j)+LZ(h)+LZ(n)+LZ(s);
		return a+LZ(m)+LZ(j);
	}
	
	prototype.displayDate=function()
	{
		var date = this.value;			
		switch(this.format)
		{
			case 'JJ/MM/AAAA':
				return date.substring(6,8)+'/'+date.substring(4,6)+'/'+date.substring(0,4);
				break;
			case 'AAAA':
				return date.substring(0,4);
				break;
			case 'MM/AAAA':
				return date.substring(4,6)+'/'+date.substring(0,4);
				break;
			case 'JJ/MM':
				return date.substring(6,8)+'/'+date.substring(4,6);
				break;
			case 'JJ/MM/AAAA HH:MM:SS':
				return date.substring(6,8)+'/'+date.substring(4,6)+'/'+date.substring(0,4)+' '+date.substring(8,10)+':'+date.substring(10,12)+':'+date.substring(12,14);
				break;
			case 'HH:MM:SS':
				return date.substring(0,2)+':'+date.substring(2,4)+':'+date.substring(4,6);
				break;
			default:
				return date.substring(6,8)+'/'+date.substring(4,6)+'/'+date.substring(0,4);
				break;
			
		}
		return date;
	}
}

//Trace un popup
function JSEPopup_Trace(id,msg)
{
    var div = getElementById('divTracePopup'+id);
    if(!div) 
    {
        div = document.createElement('div');
        div.id='divTracePopup'+id;
        div.style.zIndex=666;					
        div.style.position='absolute';	
        div.style.display='';
        div.style.left='20px';
        div.style.top=(20*id)+'px';
        div.width='200px';
        div.height='20px';
        div.style.backgroundColor='ffffff';
        document.body.insertBefore(div,document.body.firstChild);	
    }
    div.style.top=(20*id+document.body.scrollTop)+'px';    
    div.innerHTML=msg;
}

//Check a regular expression for value of input text
function validateInput_checkRegExp(value,sreg)
{
	var reg=new RegExp(sreg,'ig');	
	return reg.test(value);
}


// [EOF] for file POPUPS.js

//package loaded!
packages.complete('POPUPS');

// Served in 742 ms