// Package CORE / Copyright 2018 Archimed SA / JSE
// file: CORE.js

// JSE Core - v0.7.0 - Copyright (c) 2000-2004 Archimed SA
// (voir le fichier CHANGELOG pour l'historique)

//var JSUserAgent= window.navigator.userAgent;
var JSisOpera = (JSBrowserType=='OP');
var JSisIE = (JSBrowserType=='IE')||JSisOpera;
var JSisMZ = (JSBrowserType=='MZ');
var JSisWAI = (JSBrowserType=='WAI');
var JSisROBOT = (JSBrowserType=='ROBOT');
var JSisNS = false;
var debugConsole=null;

function getElementById(id) 
{ 
    if(JSisIE) 
        return document.all[id]; 
    else
        return document.getElementById(id);    
}


// 2->'02'
function LZ(v) { v=''+v; if (v.length<2) return '0'+v; else return v; }
// '02'->2
function parseInt2(s) { return parseInt(s,10); }

// DEC->HEX
var hexs = "0123456789ABCDEF";
function hex(n) { return hexs.charAt((n>>4)&0xF)+hexs.charAt(n&0xF); }
function hexW(n) { return hex((n>>8)&0xFF)+hex(n&0xFF); }

// UNICODE-aware !
function escapeU(s)
{
	var r='', c;
	for(var i=0;i<s.length;i++)
	{
		c=s.charCodeAt(i);
		if (c==32) r+='+'; else if ((c>32)&&(c<128)) r+=s.charAt(i); else r+='%u'+hexW(c);
	}
	return r;
}

// Manipulation de QueryString
function removeQSParam(qs,name)	{ return replaceQSParam(qs,name,''); }
function replaceQSParam(qs,name,value)
{
	var b,n,p,s,fqs;
	var rp = (value=='')?'':('&'+name+'='+escapeU(''+value));
	b=(qs.charAt(0)=='&');
	fqs=(b?'':'&')+qs;
	p = fqs.toLowerCase().indexOf('&'+name.toLowerCase()+'=');
	if (p<0) return qs+rp;
	n = fqs.indexOf('&',p+2);
	if (n<0) s=fqs.substring(b?1:0,p)+rp; else s=(p?fqs.substring(b?1:0,p):'')+rp+fqs.substring(n);
	if (s.charAt(0)=='&') { if (!b) return s.substring(1); } else	{ if (b) return '&'+s; }
	return s;	
}
function replaceQSParams(qs,params)
{
	var n=params.length;
	for(var i=0;i<n;i++) qs=replaceQSParam(qs,params[i][0],params[i][1]);
	return qs;
}


function JSGo(url) { window.location.href=url; }
function switchDisplay(obj) {obj.style.display=(obj.style.display=='none')?'':'none';}

function switchSrc(img) 
{
    if (JSisMZ)
    {
        var src=img.src;img.src=img.getAttribute('lowsrc');img.setAttribute('lowsrc',src);
    }
    else
    {
        var src=img.src;img.src=img.lowsrc;img.lowsrc=src;
    }
}

function switchQuadSrc(img) {var src=img.src;img.src=img.getAttribute('lowsrc');img.setAttribute('lowsrc',src);src=img.getAttribute('altsrc');img.setAttribute('altsrc',img.getAttribute('altlowsrc'));img.setAttribute('altlowsrc',src);}
function swapQuadSrc(img)   {var t=img.src;img.src=img.getAttribute('altsrc');img.setAttribute('altsrc',t);t=img.getAttribute('lowsrc');img.setAttribute('lowsrc',img.getAttribute('altlowsrc'));img.setAttribute('altlowsrc',t);}

function switchClass(obj) {var cls=obj.className;obj.className=obj.getAttribute('classOver');obj.setAttribute('classOver',cls);}
function rollOver(classOut,classOver) { return ' class="'+classOut+'" classOver="'+classOver+'" onMouseOver="switchClass(this)" onMouseOut="switchClass(this)" '; }

if (JSisMZ||JSisOpera)
{
	function selectListRow(obj) {
	obj.selected=true;
	obj.className=obj.mover?'JSLISTROWSELECTEDOVER':'JSLISTROWSELECTED';	
	obj.setAttribute('CLASSOUT','JSLISTROWSELECTED');
	obj.setAttribute('CLASSOVER', 'JSLISTROWSELECTEDOVER');
	}
	function deselectListRow(obj) {
	obj.selected=null;	
	if(obj.getAttribute('INTERVAL')!=null)
		obj.className=obj.mover?'JSLISTROWOVER':'JSLISTROW_INTERVAL';
	else	
		obj.className=obj.mover?'JSLISTROWOVER':'JSLISTROW';
	obj.setAttribute('CLASSOUT','');
	obj.setAttribute('CLASSOVER', 'JSLISTROWOVER');
	}
}
else
{
	function selectListRow(obj) { obj.selected=true; obj.className=obj.CLASSOUT='JSLISTROWSELECTED'; obj.CLASSOVER = 'JSLISTROWSELECTEDOVER'; }
	function deselectListRow(obj) { obj.selected=null; obj.className=obj.CLASSOUT='JSLISTROW'+(obj.INTERVAL?'_INTERVAL':''); obj.CLASSOVER = 'JSLISTROWOVER'; }
}

// IE bug workaround...
function writeAlphaPNG(src, width, height, alt)
{
	if (document.all)
		document.write('<div style="width:'+width+';height:'+height+';filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src=\''+src+'\',sizingMethod=\'scale\');" title="'+alt+'"></div>');
	else
		document.write('<img src="'+src+'" width="'+width+'" height="'+height+'" alt="'+alt+'"/>');
}

// Mozilla bug workaround...
var tickBoxSrcSelected=JSPath2Images+'JSE/selected.gif';
var tickBoxSrcNotSelected=JSPath2Images+'JSE/unselected.gif';
function clickOnTickBox(tb){if (tb.getAttribute('selected')==1){tb.setAttribute('selected',0);tb.src=tickBoxSrcNotSelected;tb.selected=false;}else{tb.setAttribute('selected',1);tb.src=tickBoxSrcSelected;tb.selected=true;}}

function JSHolder() {}
JSHolder.prototype.add = function(id,data) { return this[id]=data; }
JSHolder.prototype.get = function(id) { return this[id]; }

function packages() {}
packages.acknowledge = function(pack)
{
	this[pack]=1; // loading
}
packages.complete = function(pack)
{
	this[pack]=2; // loaded
	/*if (debugConsole)
	{
		var menu = getElementById('menu_PACKAGES');
		debugConsoleAppendMenuItem(menu,pack,pack);
	}*/
	
}
packages.requires = function(pack)
{
	var build='0';
	if (this[pack]==null)
	{ 
	// load package
		this[pack]=0; // linking
		// v?rification des d?pendances
		for(var i=0;i<this.dependencies.length;i++)
		{
			
			var dep =this.dependencies[i];
			if (dep[1])
			if (dep[0]==pack)
			{
				build=dep[2];
				for(var j=0;j<dep[1].length;j++) this.requires(dep[1][j]);
			}
		}
		document.write('<script src="'+JSPath2Script+'?PACKAGE='+pack+'&SKIN='+JSGlobalSkinName+'&BROWSER='+JSBrowserType+'&BUILD='+build+'"></script>');
	}		
}


function JSFormatMessage()
{
	var n=arguments.length;
	if (n==0) return '';
	var msg = arguments[0];
	if (n==1) return msg;
	// formatage des param?tres
	for(var i=1;i<n;i++)
	{
		msg=msg.replace(new RegExp('%'+i,"ig"),arguments[i]);
	}
	return msg;
}


// -- DEFAULT CODE FOR BUTTONS --
var JSButtons__cpt=0;
function JSWriteButtonStart(id,onClick)
{
	if (id==null) id='BUTTON_'+(JSButtons__cpt++);
	document.write('<TABLE HEIGHT="17" CELLSPACING="0" CELLPADDING="0"><TR HEIGHT="17"><TD WIDTH="2" HEIGHT="17"><IMG SRC="'+JSPath2Images+'General/buttons/buttons/button-left.gif"></TD>');
	document.write('<TD HEIGHT="17" background="'+JSPath2Images+'General/buttons/buttons/button-middle.gif"><CENTER>');
	document.write('<A ID="'+id+'" STYLE="FONT-FAMILY: Verdana, Arial;FONT-SIZE: xx-small;FONT-WEIGHT: bold;TEXT-DECORATION: none" HREF="#" CLASS="BUTTONLINK" onClick="'+onClick+';return false;"><NOBR>&nbsp;');
}
function JSWriteButtonEnd()
{
	document.write('&nbsp;</NOBR></A></CENTER></TD>');
	document.write('<TD WIDTH="2" HEIGHT="17"><IMG SRC="'+JSPath2Images+'General/buttons/buttons/button-right.gif"></TD></TR></TABLE>');
}
function JSWriteButton(id,label,onClick)
{
	JSWriteButtonStart(id,onClick);
	document.write(label);
	JSWriteButtonEnd();
}
function JSGetButtonCode(id,onClick,label)
{
	if (!id) id='BUTTON_'+(JSButtons__cpt++);
	var html='<table height="17" cellspacing="0" cellpadding="0"><tr height="17"><td width="2" height="17"><img src="'+JSPath2Images+'General/buttons/buttons/button-left.gif"></td>';
	html+='<td height="17" bgcolor="#5F8182" background="'+JSPath2Images+'General/buttons/buttons/button-middle.gif"><center>';
	html+='<a id="'+id+'" style="FONT-FAMILY: Verdana, Arial;FONT-SIZE: xx-small;FONT-WEIGHT: bold;TEXT-DECORATION: none" href="#" class="BUTTONLINK" onClick="'+onClick+';return false;"><nobr>&nbsp;';
	html+=label;
	html+='&nbsp;</nobr></a></center></td><td width="2" height="17"><img src="'+JSPath2Images+'General/buttons/buttons/button-right.gif"/></td></tr></table>';
	return html;
}
// raccourcis pour alleger le code
function jswbs(id,onClick){JSWriteButtonStart(id,onClick);}
function jswbe(id,onClick){JSWriteButtonEnd();}
function jswb(id,label,onClick){JSWriteButton(id,label,onClick);}

function JSGarbageCollector(){}
JSGarbageCollector.objects = null;
JSGarbageCollector.register = function(obj){if (!this.objects) this.objects=new Array();this.objects[this.objects.length]=obj;}
JSGarbageCollector.collect = function()
{
	if (!this.objects) return;
	for(var i=0;i<this.objects.length;i++)
	{
		this.objects[i].destroy();
		this.objects[i]=null;
	}
	this.objects=null;
}
function JSGarbageCollect() { JSGarbageCollector.collect(); }

//Insert new flash object for IE.
function NewFlashObject(id,src,width,height,wmode,quality,bgcolor,alt)
{
    if(JSisIE)
		document.write('<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+width+'" height="'+height+'" id="'+id+'" alt="'+alt+'"><param name="movie" value="'+src+'"/><param name="quality" value="'+quality+'"/><param name="wmode" value="'+wmode+'"/><param name="bgcolor" value="'+bgcolor+'"/></object>');
	else
		document.write('<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+width+'" height="'+height+'" id="'+id+'" alt="'+alt+'"><param name="movie" value="'+src+'"/><param name="quality" value="'+quality+'"/><param name="wmode" value="'+wmode+'"/><param name="bgcolor" value="'+bgcolor+'"/><embed width="'+width+'" height="'+height+'" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" name="{@name}" bgcolor="'+bgcolor+'" wmode="'+wmode+'" quality="'+quality+'" src="'+src+'" alt="'+alt+'"/></object>');
}

//Reurn the integer value for style position, ie: 129px -> 129. 
function ParseStylePosition(sPos)
{
    if(sPos)
       return (sPos.length==0?0:parseInt(sPos.replace(/px/ig,'')));
    else
        return 0;
}

function GetClientWidth()
{
    if(document.body.parentNode.clientWidth>0)
        return document.body.parentNode.clientWidth;
    else
        return document.body.clientWidth; 
   
}

function GetClientHeight()
{
    if(document.body.parentNode.clientHeight>0)
        return document.body.parentNode.clientHeight;
    else
        return document.body.clientHeight; 
   
}

// [EOF] for file CORE.js

//package loaded!
packages.complete('CORE');

// Served in 504 ms

//load packages dependencies...
packages.dependencies=[['STRUCT', null, ''], ['XFORM', ['DOMCORE'], ''], ['POPUPS', ['DOMCORE'], ''], ['DYNTREE', ['DOMCORE'], ''], ['ONGLETS', ['CORE'], ''], ['CORE', null, ''], ['TREE', ['CORE'], ''], ['BROWSER', null, ''], ['UILIB', ['DOMCORE'], ''], ['DOMCORE', ['CORE'], ''], ['DEBUG', null, ''], ['LPOPUPS', null, ''], ['BAM_DOSSDOC', null, ''], ['BAM_TIMEOUT', null, ''], ['BAM_DIDYOUMEAN', ['BAM_AJAX_ENGINE'], ''], ['BAM_AJAX_ENGINE', null, ''], ['BAM_JQUERY_SLIDER', ['BAM_JQUERY'], ''], ['BAM_TABS', null, ''], ['BAM_EXTJSMENU', ['BAM_JQUERY_ALL', 'BAM_EXTJS'], ''], ['BAM_JQUERY_FORMCHECK', ['BAM_JQUERY_ALL'], ''], ['BAM_EXTJS', null, ''], ['BAM_GOOGLESPELL', ['BAM_EXTJS'], ''], ['BAM_JQUERY_ALL', null, ''], ['ConsultationSearch', null, ''], ['CatalogEdit', null, ''], ['ConsultationList', null, ''], ['ERMES_SCHEDULING', null, ''], ['ERMES_AIE', null, ''], ['ERMES_NAVIGATION_THEMATIQUE', null, ''], ['ERMES_ECP', null, ''], ['ERMES_MEDIAS', ['BAM_JQUERY_ALL'], ''], ['ERMES_CARS', ['DOMCORE'], ''], ['ERMES_COMMUNICATION_ENCART', null, ''], ['ERMES_UNISHELL', ['DOMCORE'], ''], ['ERMES_COMMUNICATION_ADMINISTRATION', null, ''], ['ERMES_COMMUNICATION_CLIENT', null, ''], ['ERMES_STATION', null, ''], ['ERMES_CUSTOM', ['ERMES_RESA'], ''], ['ERMES_SELECTIONS', null, ''], ['ERMES_QUOTA', null, ''], ['ERMES_COMMON', null, ''], ['ERMES_PROXY', ['DOMCORE'], ''], ['ERMES_STAT', ['DOMCORE'], ''], ['ERMES_RESA', null, ''], ['IDESIAINDEXATIONTOOLS', null, ''], ['EVENTMANAGER', null, ''], ['MENU', ['DOMCORE'], ''], ['INCIPIO', null, ''], ['RICHTEXT', null, ''], ['EXPLORER', ['DOMCORE'], ''], ['MENUMANAGER_3_00', null, ''], ['EVENTMANAGER_2_01', null, ''], ['APPSMANAGER', null, ''], ['MENUFRIENDLYMANAGER', null, ''], ['USERPORTAIL', null, ''], ['FILEMANAGER', null, ''], ['MEDIAS_SIMPLESEARCH', null, ''], ['MENUMANAGER', null, ''], ['DIRECTORY_3_00', null, ''], ['HEADER', null, ''], ['GUIJS', ['BAM_EXTJS'], ''], ['MENUMANAGER_2_01', null, ''], ['EDITOR', null, ''], ['MAILBOX', null, ''], ['IDESIA_CURRENTLEXICONS', null, ''], ['FCKEDITOR', null, ''], ['ADMINISTRATION', ['DOMCORE', 'DYNTREE'], ''], ['PORTAL', ['DOMCORE'], ''], ['BOOKLINE_ALL', ['BAM_EXTJS', 'BAM_JQUERY_ALL'], ''], ['MENUFRIENDLYMANAGER_2_01', null, ''], ['TYPINGTOOLS', null, ''], ['SIMPANIER', null, ''], ['SIMLISTES', null, ''], ['GRILLESPERSO', null, ''], ['SIMGUI', null, ''], ['DOSSIERSDOC', null, ''], ['GUI', null, ''], ['SIMMPA12B', null, ''], ['CDL', null, '']];

