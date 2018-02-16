// Package PORTAL / Copyright 2018 Archimed SA / JSE

//loading package...
packages.acknowledge('PORTAL');

// file: PORTAL.js

/// PortalManager // JSE 0.6.0 / BLEUSE E. // Archimed SA // Copyright 2006/

// * v2.6: 17/11/2006 - Correction sur le resize
//	- PB: L'affectation de la taille meme inchang? provoque la propagation 
//        d'evenement qui peut entrainer l'aparition du curseur sablier.

// * v2.5: 15/12/2005 - Ajout de la fonction JSPortalCalculHeight
//	- Permet de calculer la hauteur totale d'un encart contenant de l'element en position absolut.

// * v2.4: 21/10/2005 - Gestion du mode print friendly
//	- Corrections apport?es sur la gestion du l'impression, sur plusieurs page quand on faisait 
//	un aper?u avant impression la premi?re page ne s'afficher pas. 
//	- Ajout d'une propri?t? PRINTABLE d?table sur les encarts afin qu'il n'apparaissent pas lors l'impression
//	de la page ou sur l'aper?u avant impression.

// * v2.3: 12/04/2005
//	- Modification sur le positionnement sur Mozilla: on d?duit par d?faut la taille du scrollbar
//	pour ?viter l'effet acord?on au chargement (En revanche cette effet r?apparait quand il n'y a pas de scrollbar)

// * v2.2: 23/02/2004
//	- Correction des bugs de chevauchement des encarts au premier chargement
//  - Resize Auto pour Mozilla et IE

// * v2.1: 10/02/2004
//	 - Gestion d'un padding sur les portails et les encarts	
//   - Meilleur gestion des resizes
//	 - Correction des bugs de chevauchement des encarts	 

// * v1.1: 21/11/2001
//   - Gestion du resize horizontal, et du resize d'une frame.
//   - Mozilla: timer pour contourner le pb des onResize (0.9.6 et -)

// * v1.0: 01/10/2001
//   - Version de base, layout verticale dynamique

var portals=new JSHolder();
var divDebug; 
/*var divDebug = document.createElement('div');
divDebug.id='PORTAL_DEBUG_HIDDEN';divDebug.style.zIndex=150;
divDebug.style.height='20px';
divDebug.style.width='20px';
divDebug.style.position='absolute';
divDebug.style.background='transparent';
divDebug.style.left='20px';
divDebug.style.top='0px';
divDebug.style.cursor='hand';
divDebug.onclick=portalDebug;
divDebug.innerHTML='&#160;&#160;&#160;&#160;';
document.body.insertBefore(divDebug,document.body.firstChild);*/
var sPortalDebug='';	 
function writeHTML(s)
{
	document.write(s);
	sPortalDebug+='\n'+s;		
}
function writeDebug(s){sPortalDebug+='\nDEBUG[ '+s+' ]';}
function portalDebug()
{
	var divViewDebug = document.createElement('textarea');	
	divViewDebug.style.zIndex=250;
	divViewDebug.id='PORTAL_DEBUG_HIDDEN_TEXT';	
	divViewDebug.style.height='300px';
	divViewDebug.style.width="90%";
	divViewDebug.style.position='absolute';
	divViewDebug.style.background='#ffffff';
	divViewDebug.style.left='20px';
	divViewDebug.style.top='0px';
	divViewDebug.value=sPortalDebug;
	
	document.body.insertBefore(divViewDebug,document.body.firstChild);
}
function JSPortalLayout(id)
{ 	
	this.id = id;
	this.childNodes = new Array();
	portals.add(id,this);
}
Implements(JSPortalLayout,Hashtable);
with(JSPortalLayout)
{
	prototype.parentNode=null;
	prototype.childNodes = null;
	prototype.currentFrame = null;
	prototype.sommeY = 0;
	prototype.width = 1;
	prototype.left = 0;
	prototype.fixedWidth = false;//Largeur fixe
	prototype.align = 'left';
	prototype.background='';
	prototype.maxY = 0;
	prototype._resizing=false;
	prototype._refreshTimer=-1;
	prototype.padding=0;
	prototype.relativeFrame=null;
	prototype.frameLinkID='';
	prototype.divFrameLink=null;
	prototype.printing=false;
	prototype.bodyHeight = 1;
	prototype.originalWidth = 1;
	prototype.adaptativeWidth = false;
	prototype.pourcentageWidth = 1;
				
	/* retourne l'ordonnee minimale que doit avoir une frame pour ne pas ?craser les pr?c?dentes */
	prototype.minY = function(x,l,maxI)
	{
		var min=0;
		this.relativeFrame=null;		
		if (maxI==null) maxI=this.childNodes.length;
		for(var i=0;i<maxI;i++)
		{
			var frame = this.childNodes[i];
			var a=frame.x;
			var b=a+frame.l-2;
			var c=x;
			var d=x+l-2;
			// la frame pass? en parametre(via son abscisse et sa largeur) se superpose
			// sur la frame en cours de test, elles sont donc dans la meme colonne verticale
			// <=> if (d>a && c<b)
			if (!((d<a)||(c>b)))
			{				
				if (min<frame.realY+frame.realHeight-1) 
				{
					min=frame.realY+frame.realHeight;
					this.relativeFrame=frame;
				}
			}
		}
		return min;
	}

	prototype.start = function(sPadding, sFrameLinkID) {

	    this.originalWidth = this.width;
	    var bodyWidth;
	    if (JSisMZ) {
	        bodyWidth = GetClientWidth() - 16; //Substract the scrollBar 
	        this.bodyHeight = GetClientHeight() - 16; //Substract the scrollBar 
	    }
	    else {
	        bodyWidth = GetClientWidth();
	        this.bodyHeight = GetClientHeight();
	    }
	    //Netscape 6.2 Compatibility
	    if ((!JSisIE) && (!bodyWidth)) bodyWidth = window.innerWidth;
	    if ((!JSisIE) && (!this.bodyHeight)) this.bodyHeight = window.innerHeight;

	    if (this.width.indexOf && this.width.indexOf('%') > 0) {
	        this.adaptativeWidth = true;
	        this.pourcentageWidth = (parseInt(this.width.replace('%', '')) / 100);
	        this.width = parseInt(bodyWidth * this.pourcentageWidth);
	    }

	    //Portal Padding
	    this.padding = 0;
	    if (sPadding != '' && sPadding) this.padding = parseInt(sPadding);
	    //Portal link		
	    this.frameLinkID = sFrameLinkID;
	    if (this.align == 'center' && this.fixedWidth) {
	        this.left = ((bodyWidth - this.width) + ((bodyWidth - this.width)%2)) / 2;
	        if (this.left < 0) this.left = 0;
	    }
	    if (this.frameLinkID == '') {
	        writeHTML('<div dir="ltr" id="portal_' + this.id + '" class="PORTAL_LAYOUT"  style="' + ((this.background != '') ? 'background-image:url(' + this.background + ');' : '') + 'position:absolute;padding:' + this.padding + ';width:' + (this.fixedWidth ? (this.adaptativeWidth ? this.originalWidth : this.width) : '100%') + ';height:100%;left:' + this.left + ';overflow:hidden;" onResize="portals.' + this.id + '.resize(null)">');
	        this.container = getElementById('portal_' + this.id);
	        if (!this.fixedWidth) {
	            if (this.container.offsetWidth > bodyWidth)
	                this.width = bodyWidth - (2 * this.padding);
	            else
	                this.width = this.container.offsetWidth - (2 * this.padding);
	        }
	        else {
	            this.width = this.width - (2 * this.padding);
	            this.container.style.width = this.width + 'px';
	            if (this.align == 'center') {
	                this.left = (bodyWidth - this.width) / 2;
	                this.container.style.left = this.left + 'px';
	            }
	        }
	    }
	    else {
	        this.divFrameLink = getElementById(sFrameLinkID);
	        var sFrameWidth = this.divFrameLink.style.width;
	        sFrameWidth = sFrameWidth.replace(/px/ig, '');
	        writeHTML('<div dir="ltr" id="portal_' + this.id + '" class="PORTAL_LAYOUT" style="position:absolute;padding:' + this.padding + ';width:100%;height:100%;overflow:hidden;" onResize="portals.' + this.id + '.resize(null)">');
	        this.container = getElementById('portal_' + this.id);
	        this.width = (parseInt(sFrameWidth) - (2 * this.padding));
	    }
	    this.height = this.container.offsetHeight;
	}	
	prototype.end = function()
	{
		writeHTML('</div>');
		this.container.style.height=(this.maxY+(JSisMZ?(-1*this.padding):this.padding))+'px';		
		if(this.divFrameLink) this.divFrameLink.style.height=(this.maxY+(JSisMZ?(-1*this.padding):this.padding))+'px';
		JSPortal_id=this.id;
		if (JSisMZ)
		{
			this.container.style.width = this.width+'px';
		}			
		// setting up a timer to check for resize.
		this._refreshTimer = window.setInterval('portals.'+this.id+'._refresh()',2000);
		// hook up window.onResize			
		if(this.frameLinkID=='')
		{			
			JSWindowResizeFctHandler=window.onresize;
			window.onresize=JSPortal_resize;
		}
		window.onbeforeprint=JSPortal_beforeprint;	
		window.onafterprint=JSPortal_afterprint;							
	}
	var JSWindowResizeFctHandler=null;
	var JSWindowPrintFctHandler=null;
	var JSPortal_id='';	
	var nbResize=0;
	function JSPortal_beforeprint(e){window.onresize=null;portals[JSPortal_id].printing=true;portals[JSPortal_id].resize(null);}
	function JSPortal_afterprint(e){portals[JSPortal_id].printing=false;portals[JSPortal_id].resize(null);window.onresize=JSPortal_resize;}
	
	function JSPortal_resize(e){portals[JSPortal_id].resize(null);if(JSWindowResizeFctHandler)JSWindowResizeFctHandler(e);}	
	prototype._refresh = function(){this.resize(null);}	
	prototype.startFrame = function(frameInfo)
	{		
		var frame = new JSPortalFrame(this,frameInfo);
		frame.index = this.childNodes.length;		
		this.currentFrame=frame;
		this.currentFrame.start();
		this.childNodes[this.childNodes.length]=frame;		
		return frame;
	}	
	prototype.endFrame = function()
	{
		this.currentFrame.end();
		this.sommeY+=this.currentFrame.realHeight;						
		this.currentFrame = null;
	}
	prototype.item = function(id)
	{
		for(var i=0;i<this.childNodes.length;i++)
			if (this.childNodes[i].id==id) return this.childNodes[i];
		return null;
	}	
	prototype.getProp = function(id,prop)
	{
		if (id==null)
		{
			switch(prop)
			{
				case 'x': 
				case 'y':
				case 'left':
				case 'top':	return 0;
				case 'l': 
				case 'width':
				case 'r':
				case 'right': return this.width;
				case 'h': return this.height;
				case 'height': return this.height;
				case 'clientHeight':
				    var bodyHeight = GetClientHeight();			
			        //Netscape 6.2 Compatibility
					if ((!JSisIE) && (!bodyHeight)) bodyHeight = window.innerHeight;
					return bodyHeight;
				case 'b':
				case 'bottom': return 0;
			}
			return 0;		
		}
		var frm = null;
		for(var i=0;i<this.childNodes.length;i++)
			if (this.childNodes[i].id==id) frm=this.childNodes[i];
		if (!frm) return 0;
		switch(prop)
		{
			case 'x': return frm.x;
			case 'y': return frm.y;
			case 'left': return frm.x;
			case 'top': return frm.y;
			case 'l': return frm.l;
			case 'h': return frm.realY;
			case 'width': return frm.h;
			case 'height': return frm.realHeight;
			case 'r': return frm.x+frm.l;
			case 'b': return frm.realY+frm.realHeight;
			case 'right': return frm.x+frm.l;
			case 'bottom': return frm.realY+frm.realHeight;
		}
		return 0;
	}	
	prototype.prct = function(v) {return (v*this.width)/100;}
	prototype.resize = function(id) {
	    if (!id) {
	        var bodyWidth;
	        var lastWidth = this.width;
	        bodyWidth = GetClientWidth();
	        var newBodyHeight;
	        newBodyHeight = GetClientHeight();

	        //Netscape 6.2 Compatibility
	        if ((!JSisIE) && (!bodyWidth)) bodyWidth = window.innerWidth;
	        if ((!JSisIE) && (!newBodyHeight)) newBodyHeight = window.innerHeight;
	        if (this.printing) {
	            //On fixe la taille id?ale pour le formatage avant impression
	            this.width = 652;
	            this.container.style.width = this.width + 'px';
	            this.container.style.overflow = 'visible';
	        }
	        else {
	            if (this.container.style.overflow != 'hidden') this.container.style.overflow = 'hidden';
	        }

	        this.bodyHeight = newBodyHeight;
	        if (this.divFrameLink) {
	            var sFrameWidth = this.divFrameLink.style.width;
	            sFrameWidth = sFrameWidth.replace(/px/ig, '');
	            this.width = (parseInt(sFrameWidth) - (2 * this.padding));
	        }
	        else {
	            if (JSisMZ) {
	                if (!this.fixedWidth && !this.printing) this.width = (bodyWidth > 300 ? (bodyWidth - (2 * this.padding)) : 300);
	                if (this.align == 'center' && this.fixedWidth) {
	                    if (!this.printing) {
	                        if (this.adaptativeWidth) this.width = parseInt(bodyWidth * this.pourcentageWidth);
	                        this.left = (bodyWidth - this.width + ((bodyWidth - this.width)%2)) / 2 - this.padding;
	                    }
	                    else {
	                        this.left = 0;
	                    }
	                    if (this.left < 0) this.left = this.padding;
	                    this.container.style.left = this.left + 'px';
	                }
	                this.container.style.width = this.width + 'px';
	            }
	            else {
	                if (!this.fixedWidth && !this.printing) this.width = (bodyWidth > 300 ? (bodyWidth - (2 * this.padding)) : 300);

	                if (this.align == 'center' && this.fixedWidth) {
	                    if (!this.printing) {
	                        if (this.adaptativeWidth) this.width = bodyWidth * this.pourcentageWidth;
	                        this.left = (bodyWidth - this.width) / 2 - this.padding;
	                    }
	                    else {
	                        this.left = 0;
	                    }
	                    if (this.left < 0) this.left = this.padding;
	                    this.container.style.posLeft = this.left;
	                }
	                this.height = this.container.offsetHeight;
	                //this.container.style.offsetWidth = this.width + (2 * this.padding);
	                //if(!this.fixedWidth) this.container.style.offsetWidth = this.width+(2*this.padding);
	                if (!this.fixedWidth || this.adaptativeWidth) {
	                    var sWidthFixedOnResize = this.width + (2 * this.padding);
	                    if (this.container.style.offsetWidth != sWidthFixedOnResize) {
	                        this.container.style.offsetWidth = sWidthFixedOnResize;
	                        this.container.style.width = sWidthFixedOnResize;
	                    }
	                }
	            }	            
	        }
            
	        for (var i = 0; i < this.childNodes.length; i++) {
	            var frm = this.childNodes[i];
	            frm.x = this.printing ? this.left : parseInt(frm.decodeExpr(frm.exprX)) + this.padding;
	            frm.l = this.printing ? this.width - 4 : frm.decodeExpr(frm.exprL);

	            if (frm.frameDirection.toUpperCase() == 'RTL') {
	                frm.x = (this.width - frm.x - frm.l) + (2 * this.padding);
	            }
	            if (JSisMZ) {
	                frm.container.style.left = frm.x + 'px';
	                frm.container.style.width = frm.l - 2 * frm.framePadding + 'px';
	            }
	            else {
	                frm.container.style.posLeft = frm.x;
	                frm.container.style.posWidth = frm.l;
	            }
	            //Modify height of frame
	            if (frm.exprH.indexOf('LAYOUT.clientHeight') >= 0) {
	                frm.h = frm.decodeExpr(frm.exprH);
	                frm.container.style.height = frm.h + 'px';
	                frm.realHeight = frm.container.offsetHeight;
	            }
	            frm.realHeight = frm.container.offsetHeight;

	            //Modify top position of frame	
	            var my = this.minY(frm.container.offsetLeft, frm.container.offsetWidth, i);
	            my = (frm.y > my) ? frm.y : my;
	            frm.realY = my + (my == 0 ? this.padding : 0);
	            if (JSisMZ)
	                frm.container.style.top = frm.realY + 'px';
	            else
	                frm.container.style.posTop = frm.realY;
	            //Don't display the frame non printable					
	            if (this.printing && !frm.printable)
	                frm.container.style.display = 'none';
	            else
	                frm.container.style.display = '';

	            //Display none	
	            if (this.printing) {
	                var bFound = false;
	                for (var idx = 0; idx < frm.container.childNodes.length && bFound == false; idx++) {
	                    var elt = frm.container.childNodes[idx];
	                    if (elt.className.toLowerCase() == 'no-print') bFound = true;
	                }
	                if (bFound == true) { frm.container.style.display = 'none'; }
	            }
	        }

	        //Modify height of portal
	        var maxHeight = this.maxY;
	        this.maxY = 0;
	        for (var i = 0; i < this.childNodes.length; i++) {
	            frm = this.childNodes[i];
	            if ((frm.realY + frm.realHeight) > this.maxY) this.maxY = (frm.realY + frm.realHeight);
	        }
	        this.container.style.height = (this.maxY + (JSisMZ ? (-1 * this.padding) : this.padding)) + 'px';

	        if (this.divFrameLink) this.divFrameLink.style.height = (this.maxY + (JSisMZ ? (-1 * this.padding) : this.padding)) + 'px';
	        if (this.printing) {
	            this.width = lastWidth;
	            this.container.style.width = this.width + 'px';
	        }
	        //FrameResize
	        for (var i = 0; i < this.childNodes.length; i++) {
	            frm = this.childNodes[i];
	            frm.container.resize();
	        }
	        return true;
	    }
	}
	prototype.toString = function() {return 'PORTAL['+this.id+'](width='+this.width+';height='+this.height+')';}
}
//Frame class
function JSPortalFrame(parent,frameInfo)
{		
	this.parentNode = parent;
	this.id = frameInfo[0];
	this.exprX = frameInfo[1];
	this.exprY = frameInfo[2];
	this.exprL = frameInfo[3];
	this.exprH = frameInfo[4];
	this.x  = parseInt(this.decodeExpr(this.exprX))+parseInt(this.parentNode.padding);
	this.y  = parseInt(this.decodeExpr(this.exprY))+parseInt(this.parentNode.padding);
	this.l  = this.decodeExpr(this.exprL);
	this.h  = this.decodeExpr(this.exprH);
	if(frameInfo[5] && frameInfo[5]!='') this.className=frameInfo[5];
	if(frameInfo[6] && frameInfo[6]!='') this.framePadding = frameInfo[6];
	if(frameInfo[7] && frameInfo[7]!='') this.frameDirection = frameInfo[7];
	if(frameInfo[8] && frameInfo[8]!='') this.portalLink = frameInfo[8];
	if(this.frameDirection.toUpperCase() == 'RTL'){this.x = this.parentNode.width-this.x - this.l+(2*this.parentNode.padding);}
	if(frameInfo[9]!=null) this.printable=frameInfo[9];
	
}
with(JSPortalFrame)
{
	prototype.width;
	prototype.parentNode = null;
	prototype.container = null;	
	prototype.x = 0;
	prototype.y = 0;
	prototype.h=0;
	prototype.l=0;
	prototype.realY = 0;
	prototype.realHeight=0;
	prototype.className='PORTAL_FRAME';
	prototype.framePadding=0;
	prototype.frameDirection = 'LTR';
	prototype.portalLink=null;	
	prototype.printable=true;	
	prototype.decodeExpr = function(s)
	{
		var t;
		t = s.replace( /\[(.*)\].(\w)/ig ,'this.parentNode.getProp(\'$1\',\'$2\')');
		t = t.replace( /(\d+)\%/ig       ,'this.parentNode.prct($1)');
		t = t.replace( /LAYOUT.(\w*)/ig  ,'this.parentNode.getProp(null,\'$1\')');
		return eval(t);	
	}	
	prototype.start=function()
	{		
		var my=this.parentNode.minY(this.x,this.l);				
		this.realY = (this.y>my)?this.y:my;		
		this.currentSommeY = this.parentNode.sommeY;		
		var ry = this.realY;		
		// le fait de mettre height:0px dans le style du div engendrait des bugs d'affichage sous mozilla 1.3
		// offsetHeight retournait un nombre erron?.
		var height;
		if (this.h>0){height = 'height:'+this.h+'px;'}		
		this.realHeight=this.h;			
		if (JSisMZ)		
			writeHTML('<div dir="'+this.frameDirection+'" id="'+this.id+'" class="'+this.className+'"  style="padding:'+this.framePadding+';position:absolute;left:'+this.x+'px;top:'+ry+'px;width:'+(this.l-2*this.framePadding)+'px;height:'+height+';">');				
		else			
			writeHTML('<div dir="'+this.frameDirection+'" id="'+this.id+'" class="'+this.className+'"  style="padding:'+this.framePadding+';position:absolute;left:'+this.x+'px;top:'+ry+'px;width:'+this.l+'px;height:'+height+';">');						
		this.container = getElementById(this.id);
		this.container.resize=function(){};	
	}
	prototype.end=function()
	{
		writeHTML('</div>');
		this.realWidth=this.container.offsetWidth;		
		if(this.exprH.indexOf('LAYOUT.clientHeight')==-1) 
		this.realHeight=this.container.offsetHeight;
		else
		    this.container.style.height=this.realHeight+'px';
		if ((this.realY+this.realHeight)>this.parentNode.maxY) this.parentNode.maxY=(this.realY+this.realHeight);				
	}
	prototype.toString = function(){return '\nFRAME['+this.id+'|'+this.parentNode.id+'|'+this.x+'x'+this.y+'|'+this.l+'x'+this.h+'|'+this.realWidth+'x'+this.realHeight+']';}
}

//Calcul the frame height width absolute positioning elements
function JSPortalCalculHeight(parent,top)
{	
	if(parent!=null)
	{		
		var height=0;
		for(var i=0;i<parent.childNodes.length;i++)
		{
			var child=parent.childNodes[i];			
			if(child.style!=null && child.style.position.toLowerCase()=='absolute')
			{				
				var childHeight =(isNaN(child.offsetTop)?0:child.offsetTop)+(isNaN(child.offsetHeight)?0:child.offsetHeight);				
				if(childHeight>height) height=childHeight;
			}
			else
			{								
				var childTop = top+(isNaN(child.offsetTop)?0:child.offsetTop);
				var childHeight = childTop+(isNaN(child.offsetHeight)?0:child.offsetHeight);				
				if(childHeight>height) height=childHeight;
				var childHeight=JSPortalCalculHeight(child,childTop);
				if(childHeight>height) height=childHeight;
			}
		}
		return height;
	}
	else
		return 0;
}

// [EOF] for file PORTAL.js

//package loaded!
packages.complete('PORTAL');

// Served in 816 ms