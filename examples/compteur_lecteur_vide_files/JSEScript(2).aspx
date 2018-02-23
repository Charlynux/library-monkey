// Package HEADER / Copyright 2018 Archimed SA / JSE

//loading package...
packages.acknowledge('HEADER');

// file: menu-monoframe.js

/******************* Crystal Framework 3.0 ******************
	?Copyright: 2005-2006 Archimed SA
	Date:	 01/05/2005	
	Name:	 menu-mnoframe.js
	Version: 3.01	
	Author: Bleuse Emmanuel	
	Comment: Plugins for header menu display 
*/
//
// Modifications:
//
// 28/11/2007 - Ajout de la possibilit? de param?trer le d?calage du second niveau grace ? la variable g_level1MenuOffsetHeight.
//
// 26/09/2007 - Ajout d'un logo loading lors du chargement de la page.
//
// 07/12/2006 - Ajout d'un effet slide sur l'affichage du niveau 2 et niveau 3 et ajout d'une opacit? ? 85%.
//              
//
// 30/08/2006 - Ajout d'une surcharge sur la m?thode writeLevel1Ex2 afin de g?rer un s?parateur entre les entr?es du menu de type image
//              Ajout de la m?thode writeLevel1WithImgSeparator , appelant la surcharge avec g_level1MenuSeparator en param?tre.
//
// 03/04/2006 - Correction sur le postionnement des niveaux 3 par les langues RTL
// 03/04/2006 - Ajout de nouvelle surcharge sur les writeLevel.. permettant de transmettent un menuId
//
// 30/01/2006 - Fonction qui lance une url directement sans passer par le launcher, 
//	interessant pour que les pages WebContent soit bien index?s par les Robots.
//
//
// 25/05/2005 - Ajout des fonctionnalit?s de s?lection d'entr?e 
//				et transmission de l'identifiant de synchronisation ? launch.aspx
//
//************************************************************************************

var g_displayPageLoader = false;
var launchDiv=document.createElement('div');
launchDiv.id='JSELaunchDiv';
launchDiv.style.backgroundColor='transparent';
launchDiv.style.position = 'absolute';
launchDiv.style.left='5px';
launchDiv.style.top='5px';
launchDiv.style.width='50px';
launchDiv.style.height='50px';
var launchModalImg = launchDiv.appendChild(document.createElement('img'));
launchModalImg.alt = 'loading...';
launchModalImg.src = JSPath2Images+'loading.gif';
var launchModalDiv=document.createElement('div');
launchModalDiv.id='JSELaunchModalDiv';
launchModalDiv.style.backgroundColor='#ffffff';
launchModalDiv.style.position = 'absolute';
launchModalDiv.style.left='0px';
launchModalDiv.style.top='0px';
if (JSisMZ)
    launchModalDiv.style.opacity=0;
else
	launchModalDiv.style.filter='alpha(opacity=0)';	
launchDiv.style.display = 'none';	
launchModalDiv.style.display = 'none';	

// 30/01/2006 - Fonction qui lance une url directement sans passer par le launcher, ineretessant pour les pages WebContent.
function crystalMenuDirectLaunch(strTarget,strUrl)
{
	crystalMenuDirectLaunchEx(strTarget,strUrl,'')
}
function crystalMenuDirectLaunchEx(strTarget,strUrl,strSyncMenu)
{
	var frm=null;

	if (strSyncMenu!='')
		{
		 strUrl=strUrl+'&SYNCMENU=' + strSyncMenu;
		}

	switch(strTarget)
	{				
		case '_top':	frm = top; break;
		case '_self':
		    pageLoading();				
			frm = window;					
			break;
		case '_parent': 			
			frm = window.parent;
			break;
		case '_new':
		case '_blank': frm = window.open(); break;
		default:
			var w=window;
			while ((w!=top)&&(frm==null))
			{
				frm = w.parent.frames[strTarget];
				w=w.parent;									
			}
			if (!frm) return;
	}	
	frm.location.href = strUrl;	
}
// Url du launcher surchargable
function crystalMenuLaunch(id)
{					
	crystalMenuLaunchEx2(id,i_strHeaderMenuId,'');
}
// 25/05/2005 - Nouvelle m?thode avec passage de l'identifiant de synchronisation
function crystalMenuLaunchEx(id,sSynchroId)
{
	crystalMenuLaunchEx2(id,i_strHeaderMenuId,sSynchroId);
}
// 03/04/2006 - Nouvelle m?thode avec passage de l'identifiant du menu
function crystalMenuLaunchEx2(id,menuId,sSynchroId)
{					
   var frm=getElementById('frame_launch');
	var sUrl = '';
	try
	{
		sUrl = i_crystalMenuLauncherUrl;
	}
	catch(e)
	{
		sUrl = '/masc/launch.asp';	
	}
	sUrl += '?INSTANCE='+i_strInstance+'&MENUID='+escapeU(menuId)+'&HIDDENFRAME=true&ENTRYID=' + id + '&SYNCMENU=' + sSynchroId;		
	
	
	if(frm)
	{ 	    
	    pageLoading();
	    frm.src = sUrl;
	}	
}

/// Changement de la page
function pageLoading()
{    
    if(!g_displayPageLoader) return;
    if(launchDiv.style.display.length==0) return;
    document.body.insertBefore(launchModalDiv,document.body.lastChild);
	document.body.insertBefore(launchDiv,launchModalDiv);
	launchModalDiv.style.width=(GetClientWidth()>document.body.scrollWidth?GetClientWidth():document.body.scrollWidth)+'px';
	launchModalDiv.style.height=(GetClientHeight()>document.body.scrollHeight?GetClientHeight():document.body.scrollHeight)+'px';
	launchDiv.style.display='';
	launchModalDiv.style.display='';
}
function pageLoaded()
{	
	if(!g_displayPageLoader) return;
	launchDiv.style.display='none';
	launchModalDiv.style.display='none';
}
var bSubmit=false;
function EnterKeyPressOnLogin(e) {
	if(JSisMZ)		
	{
		if (e.keyCode==13) {
			bSubmit=false;
			document.forms['header_frmLogin']['pwd'].focus();
		}
	}
	else
	{
		if (event.keyCode==13) {
			bSubmit=false;
			document.forms['header_frmLogin']['pwd'].focus();								
		}
	}
	return false;
}

function EnterKeyPressOnPWD(e) {
	if(JSisMZ)		
	{
		if (e.keyCode==13) {
			bSubmit=true;
			document.forms['header_frmLogin'].submit();
		}
	}
	else
	{
		if (event.keyCode==13) {
			bSubmit=true;
			document.forms['header_frmLogin'].submit();
		}
	}
}
/* Gestion du menu dynamique */
var g_lastMenuVisible='';
var g_lHideMenuHandler=null;
var g_level1MenuSeparator = '|';
var g_lastSlideShowInterval = 0;
var g_lastSlideHideInterval = 0;
var g_slideStep = 15;
var g_slideIntervalMs = 10;
var g_slideIntervalL2Ms = 20;
var g_menuOpacity = 90;
var g_level1MenuOffsetHeight = 12;

function showMenu(sID)
{
	window.clearTimeout(g_lHideMenuHandler);	
	var obj=getElementById('img_'+sID);
	var div=getElementById('div_'+sID);
	var x=0,y=0;
	if(div && !div.menuState) div.menuState = 'HIDE';
	if(div && div.menuState != 'SHOWING')
	{
	    var clientWidth=document.body.scrollWidth;		
	    //Stop the current hiding
		if(div.menuState=='HIDING') window.clearInterval(div.hideInterval); 
		div.menuState = 'SHOWING';
		while ((obj!=null)&&(obj!=document.body))
		{
			if(obj.style.position!='absolute')
			{
			x+=obj.offsetLeft;
			y+=obj.offsetTop;
			}
			if (obj.offsetParent==obj) break;
			obj=obj.offsetParent;
		}						
		// r?cup?ration de la position du div		
		switch(JSLangDirection.toUpperCase())
		{
			case 'LTR':
			    if(x+div.firstChild.offsetWidth>clientWidth)
			        div.style.left=clientWidth-div.firstChild.offsetWidth-4;
			    else
				div.style.left=x+'px';
				div.style.top=(y+g_level1MenuOffsetHeight)+'px';
				div.menuReverseDirection=false;				
				break;
			case 'RTL':				
				if(x-(div.firstChild.offsetWidth)<0)
				{
					div.style.left='0px';
				}
				else
				{
				if(JSisMZ)
					div.style.right=GetClientWidth()-x;
				else
						div.style.left=(x-(div.firstChild.offsetWidth))+'px';										
				}
					div.style.top=(y+g_level1MenuOffsetHeight)+'px';				
				div.menuReverseDirection=true;
				break;
		}								
        if (JSisMZ)
            div.firstChild.style.opacity=(g_menuOpacity*0.01);
        else
	        div.firstChild.style.filter='alpha(opacity='+g_menuOpacity+')';
		var code = 'slideShowMenu("'+sID+'",'+(div.firstChild.offsetWidth+4)+','+(div.firstChild.offsetHeight+4)+')'; 
		div.style.visibility='visible';								
		if(getElementById(g_lastMenuVisible) && g_lastMenuVisible!=sID)
		{ 
		    hideMenu(g_lastMenuVisible);
		}
		g_lastMenuVisible=sID;
		div.showInterval = window.setInterval(code,g_slideIntervalMs);
		
	}
}
function slideShowMenu(id,width,height)
{
    var div=getElementById('div_'+id);
    if(div && div.menuState=='SHOWING') 
    {        
        var newHeight = (parseInt(div.style.height.replace(/px/ig,'')) + g_slideStep);
        var newWidth = (parseInt(div.style.width.replace(/px/ig,'')) + g_slideStep);
        if(newHeight<height)
        {
            div.style.height = newHeight+'px';
        }
        else
        {
            if(div.style.height!=height+'px') div.style.height = height+'px';           
        } 
        if(div.menuReverseDirection)
        {
            if(div.style.width!=width+'px')  div.style.width = width+'px';
        }
        else
        {
        if(newWidth<width)
        {
            div.style.width = newWidth+'px';
        }
        else
        {
            if(div.style.width!=width+'px') div.style.width = width+'px';            
        } 
        }
        if(newHeight>=height && newWidth>=width)
        {
            window.clearInterval(div.showInterval);            
            div.menuState='SHOW';
        }          
    }
}

function slideHideMenu(id)
{
    var div=getElementById('div_'+id);
    if(div && div.menuState=='HIDING') 
    {        
        var newHeight = (parseInt(div.style.height.replace(/px/ig,'')) - g_slideStep);
        var newWidth = (parseInt(div.style.width.replace(/px/ig,'')) - g_slideStep);
        if(newHeight>1)
        {
            div.style.height = newHeight+'px';           
        }
        else
        {
            if(div.style.height!='1px')
            {
                div.style.height = '1px';
                if(div.menuReverseDirection) div.style.width = '1px';           
                div.style.visibility='hidden';
        } 
        } 
        if(!div.menuReverseDirection)
        {
        if(newWidth>1)
        {
            div.style.width = newWidth+'px';           
        }
        else
        {
            if(div.style.width!='1px') div.style.width = '1px';            
        } 
        }        
        if(newHeight<=1 && newWidth<=1)
        {
            div.style.visibility='hidden';
            div.menuState=='HIDE';
            window.clearInterval(div.hideInterval);                        
        }          
    }
}

function showMenuLevel2(sParentID,sID,lPos)
{										
	window.clearTimeout(g_lHideMenuHandler);
	var div=getElementById('div_'+sID);
	var tbl=getElementById('table_'+sParentID);
	var divParent=getElementById('div_'+sParentID);

	var x=0,y=0;
	
	if(div && !div.menuState) div.menuState = 'HIDE';
	if(div && divParent && tbl && div.menuState != 'SHOWING')
	{		
	    var clientWidth=document.body.scrollWidth;	
	    //Stop the current hiding
		if(div.menuState=='HIDING') window.clearInterval(div.hideInterval); 
		div.menuState = 'SHOWING';
		switch(JSLangDirection.toUpperCase())
		{
			case 'LTR':
			    var x=parseInt(divParent.style.left.toLowerCase().replace('px',''))+divParent.offsetWidth-10;
			    if(x+div.firstChild.offsetWidth>clientWidth)
			    {			        
			        div.style.left=parseInt(divParent.style.left.toLowerCase().replace('px',''))-div.firstChild.offsetWidth+10;
			        div.menuReverseDirection=true;
			    }
			    else
			    {
				    div.style.left=x;
				    div.menuReverseDirection=false;
				}
				div.style.top=parseInt(divParent.style.top.toLowerCase().replace('px',''))+((lPos-1)*18);
				break;
			case 'RTL':
			    var x = parseInt(divParent.style.left.toLowerCase().replace('px',''))-div.firstChild.offsetWidth+5;
				//03/04/2006 - Correction sur le postionnement des niveaux 3 par les langues RTL
				if(x<0)
				{
				    div.menuReverseDirection=false;
				    div.style.left=parseInt(divParent.style.left.toLowerCase().replace('px',''))+divParent.offsetWidth-10;
				}
				else
				{
				    div.menuReverseDirection=true;
				if(JSisMZ)										
					div.style.right=parseInt(divParent.style.right.toLowerCase().replace('px',''))+tbl.offsetWidth-20;					
				else
					    div.style.left=parseInt(divParent.style.left.toLowerCase().replace('px',''))-div.firstChild.offsetWidth+5;
				}					
				div.style.top=parseInt(divParent.style.top.toLowerCase().replace('px',''))+((lPos-1)*18);
				break;
		}
		if (JSisMZ)
            div.firstChild.style.opacity=(g_menuOpacity*0.01);
        else
	        div.firstChild.style.filter='alpha(opacity='+g_menuOpacity+')';	
		var code = 'slideShowMenu("'+sID+'",'+(div.firstChild.offsetWidth+4)+','+(div.firstChild.offsetHeight+4)+')'; 
		div.style.visibility='visible';
		div.showInterval = window.setInterval(code,g_slideIntervalL2Ms);				
	}
}
function hideMenu(sID)
{						
	var div=getElementById('div_'+sID);					
	if(div && !div.menuState) div.menuState = 'HIDE';
	if(div && div.menuState!='HIDING')	
	{
	    //Stop the current showing
		if(div.menuState=='SHOWING') window.clearInterval(div.showInterval); 
	    div.menuState='HIDING';	    	    
		div.hideInterval = window.setInterval('slideHideMenu("'+sID+'")',g_slideIntervalMs);				
	}
}
function hideMenuLevel2(sParentID,sID,hideParent)
{						
	var div=getElementById('div_'+sID);
	var divParent=getElementById('div_'+sParentID);			
	if(div && !div.menuState) div.menuState = 'HIDE';
	if(div && div.menuState!='HIDING')	
	{
	    //Stop the current showing
		if(div.menuState=='SHOWING') window.clearInterval(div.showInterval); 
	    div.menuState='HIDING';	    	    
		div.hideInterval = window.setInterval('slideHideMenu("'+sID+'")',g_slideIntervalL2Ms);				
	}	
	if(hideParent) g_lHideMenuHandler = window.setTimeout('hideMenu("'+sParentID+'")',500);
}	

function writeLevel1(sId,bEvent,bLast,sLabel,sHref,sTarget,sDesc)
{
	writeLevel1Ex2(sId,i_strHeaderMenuId,bEvent,bLast,sLabel,sHref,sTarget,sDesc,"",false)
}
// 25/05/2005 - Nouvelle m?thode avec passage de l'identifiant de synchronisation et l'?tat de s?lection
function writeLevel1Ex(sId,bEvent,bLast,sLabel,sHref,sTarget,sDesc,sSynchroId,bSelected)
{
	writeLevel1Ex2(sId,i_strHeaderMenuId,bEvent,bLast,sLabel,sHref,sTarget,sDesc,sSynchroId,bSelected);
}

// 03/04/2006 - Nouvelle m?thode avec passage de l'identifiant du menu
function writeLevel1Ex2(sId,sMenuId,bEvent,bLast,sLabel,sHref,sTarget,sDesc,sSynchroId,bSelected)
{
    writeLevel1Ex3(sId,sMenuId,bEvent,bLast,sLabel,sHref,sTarget,sDesc,sSynchroId,bSelected,g_level1MenuSeparator)
}
// 30/08/2006 - Nouvelle m?thode de la gestion du separator entre les entr?es du menu
function writeLevel1Ex3(sId,sMenuId,bEvent,bLast,sLabel,sHref,sTarget,sDesc,sSynchroId,bSelected,imgSeparator)
{
	if(sMenuId=='') sMenuId=i_strHeaderMenuId;	
	var sHtml='';	
	sHtml = '<td><img id="img_'+sId+'" src="'+JSPath2Images+'General/vide.gif" width="5" height="5" alt=""/></td><td style="white-space: nowrap;text-decoration:none" class="header-menu-cell-L0" id="td_'+sId+'"';
	if(bEvent)
	{
		if(sHref=='')
			sHtml += ' onClick="crystalMenuLaunchEx2(\''+sId+'\',\''+sMenuId+'\',\''+sSynchroId+'\');event.cancelBubble=true;event.returnValue=false;return false;"';
		else
			sHtml += ' onClick="crystalMenuDirectLaunchEx(\''+sTarget+'\',\''+sHref+'\',\''+sSynchroId+'\');event.cancelBubble=true;event.returnValue=false;return false"';
	}
	sHtml +='><a title="'+(sDesc?sDesc:'')+'" onmouseover="this.style.textDecoration=this.style.textDecoration;hideMenu(g_lastMenuVisible);showMenu(\''+sId+'\');" onmouseout="g_lHideMenuHandler = window.setTimeout(\'hideMenu(\\\''+sId+'\\\')\',1000);" class="header-menu-cell-L0'+(bSelected?'-selected':'')+'"';
	if(bEvent)
	{	
		if(sHref=='')
			sHtml += ' href="#" onClick="crystalMenuLaunchEx2(\''+sId+'\',\''+sMenuId+'\',\''+sSynchroId+'\');event.cancelBubble=true;event.returnValue=false;return false;"';
		else
			sHtml += ' href="'+sHref+'" target="'+sTarget+'"';
	}
	if(imgSeparator.length<4)
	    sHtml += '>'+sLabel+(bLast?'&#160;</a></td>':'</a></td><td style="white-space: nowrap" class="header-menu-cell-L0"><img src="'+JSPath2Images+'General/vide.gif" width="5" height="5" alt=""/>'+imgSeparator+'</td>');
	else
	    sHtml += '>'+sLabel+(bLast?'&#160;</a></td>':'</a></td><td style="white-space: nowrap"><img src="'+JSPath2Images+imgSeparator+'" alt=""/></td>');	
	
	document.write(sHtml);
}


function writeMenu_start()
{
	document.write('<table class="header-menu-table-L0" cellpadding="0" cellspacing="0" border="0"><tr>');
}
function writeLevel1_start(sId)
{
	var sHtml='';
	sHtml='<div style="border:none;padding:0;position:absolute;visibility:hidden;z-index:667;background:transparent;height:1;width:1;overflow:hidden" id="div_'+sId+'" onmouseover="showMenu(\''+sId+'\');" onmouseout="g_lHideMenuHandler = window.setTimeout(\'hideMenu(\\\''+sId+'\\\')\',500);">';
	sHtml+='<table cellpadding="0" cellspacing="1" border="0" class="header-menu-cell-L1-Border" id="table_'+sId+'">';
	document.write(sHtml);
}
function writeMenu_end()
{
	document.write('</tr></table>');
}
function writeLevel2(lPos,sId,sParentId,bEvent,sLabel,sHref,sTarget,sDesc,sSynchroId,bSelected)
{
	writeLevel2Ex2(lPos,sId,i_strHeaderMenuId,sParentId,bEvent,sLabel,sHref,sTarget,sDesc,"",false);
}
// 25/05/2005 - Nouvelle m?thode avec passage de l'identifiant de synchronisation et l'?tat de s?lection
function writeLevel2Ex(lPos,sId,sParentId,bEvent,sLabel,sHref,sTarget,sDesc,sSynchroId,bSelected)
{
	writeLevel2Ex2(lPos,sId,i_strHeaderMenuId,sParentId,bEvent,sLabel,sHref,sTarget,sDesc,sSynchroId,bSelected);
}
// 03/04/2006 - Nouvelle m?thode avec passage de l'identifiant du menu
function writeLevel2Ex2(lPos,sId,sMenuId,sParentId,bEvent,sLabel,sHref,sTarget,sDesc,sSynchroId,bSelected)
{
	if(sMenuId=='') sMenuId=i_strHeaderMenuId;	
	var sHtml='';
	sHtml = '<tr><td style="white-space:nowrap;border-'+(JSLangDirection=='RTL'?'left':'right')+':0px" class="header-menu-cell-L1" onmouseover="this.className=\'header-menu-cell-L1-over\';showMenuLevel2(\''+sParentId+'\',\''+sId+'\','+lPos+')" onmouseout="this.className=\'header-menu-cell-L1\';hideMenuLevel2(\''+sParentId+'\',\''+sId+'\',false);"';
	if(bEvent)
	{
		if(sHref=='')
			sHtml += ' onClick="crystalMenuLaunchEx2(\''+sId+'\',\''+sMenuId+'\',\''+sSynchroId+'\');event.cancelBubble=true;event.returnValue=false;return false"';
		else
			sHtml += ' onClick="crystalMenuDirectLaunchEx(\''+sTarget+'\',\''+sHref+'\',\''+sSynchroId+'\');event.cancelBubble=true;event.returnValue=false;return false"';
	}
	sHtml += '><a title="'+(sDesc?sDesc:'')+'" class="header-menu-cell-L1-href'+(bSelected?'-selected':'')+'"';
	if(bEvent)
	{
		if(sHref=='')
			sHtml += ' href="#" onClick="crystalMenuLaunchEx2(\''+sId+'\',\''+sMenuId+'\',\''+sSynchroId+'\');event.cancelBubble=true;event.returnValue=false;return false;"';
		else
			sHtml += ' href="'+sHref+'" target="'+sTarget+'"';
	}	
	sHtml += '>'+sLabel+'&#160;</a></td></tr>';
	document.write(sHtml);
}
function writeLevel1_end()
{
	var sHtml='</table></div>';
	document.write(sHtml);
}

function writeLevel2_start(lPos,sId,sParentId)
{
	var sHtml='';		   
	sHtml='<div style="border:none;padding:0;position:absolute;visibility:hidden;z-index:668;background:transparent;height:1px;width:1px;overflow:hidden" id="div_'+sId+'" onmouseover="showMenuLevel2(\''+sParentId+'\',\''+sId+'\','+lPos+');" onmouseout="hideMenuLevel2(\''+sParentId+'\',\''+sId+'\',true);">';
	sHtml+='<table cellpadding="0" cellspacing="1" border="0" class="header-menu-cell-L2-Border" id="table_'+sId+'">';
	document.write(sHtml);
}
function writeLevel3(lPos,sId,sParentId,bEvent,sLabel,sHref,sTarget,sDesc)
{
	writeLevel3Ex2(lPos,sId,i_strHeaderMenuId,sParentId,bEvent,sLabel,sHref,sTarget,sDesc,'',false);
}
// 25/05/2005 - Nouvelle m?thode avec passage de l'identifiant de synchronisation et l'?tat de s?lection
function writeLevel3Ex(lPos,sId,sParentId,bEvent,sLabel,sHref,sTarget,sDesc,sSynchroId,bSelected)
{
	writeLevel3Ex2(lPos,sId,i_strHeaderMenuId,sParentId,bEvent,sLabel,sHref,sTarget,sDesc,sSynchroId,bSelected)	
}
// 03/04/2006 - Nouvelle m?thode avec passage de l'identifiant du menu
function writeLevel3Ex2(lPos,sId,sMenuId,sParentId,bEvent,sLabel,sHref,sTarget,sDesc,sSynchroId,bSelected)
{
	if(sMenuId=='') sMenuId=i_strHeaderMenuId;	
	var sHtml='';	
	sHtml += '<tr><td style="white-space: nowrap" class="header-menu-cell-L2" onmouseover="this.className=\'header-menu-cell-L2-over\';" onmouseout="this.className=\'header-menu-cell-L2\';"';
	
	if(bEvent)
	{
		if(sHref=='')
			sHtml += ' onClick="crystalMenuLaunchEx2(\''+sId+'\',\''+sMenuId+'\',\''+sSynchroId+'\');event.cancelBubble=true;event.returnValue=false;return false"';
		else
			sHtml += ' onClick="crystalMenuDirectLaunchEx(\''+sTarget+'\',\''+sHref+'\',\''+sSynchroId+'\');event.cancelBubble=true;event.returnValue=false;return false"';
	}
	sHtml += '><a title="'+(sDesc?sDesc:'')+'" class="header-menu-cell-L2-href'+(bSelected?'-selected':'')+'"';
	if(bEvent)
	{
		if(sHref=='') 
			sHtml += ' href="#" onClick="crystalMenuLaunchEx2(\''+sId+'\',\''+sMenuId+'\',\''+sSynchroId+'\');event.cancelBubble=true;event.returnValue=false;return false;"';
		else
			sHtml += ' href="'+sHref+'" target="'+sTarget+'"';
	}
	sHtml += '>'+sLabel+'&#160;</a></td></tr>';
	document.write(sHtml);													
}		
function writeLevel2_end()
{
	var sHtml='</table></div>';
	document.write(sHtml);
}													
												
function GetCookie(name,key)
{  	
	var arg = name + "="; 
	
	var alen = arg.length;	  
	var clen = document.cookie.length;  
	var i = 0;	 
	while (i < clen) 
	{    
		var j = i + alen; 	
		if (document.cookie.substring(i, j) == arg) return getCookieVal (j,key);    
		i = document.cookie.indexOf(" ", i) + 1;    
		if (i == 0) break;   
	}
	
	if(unescape(arg)!=arg)
	{
		var newArg=unescape(arg);
		alen=newArg.length
		i=0;
		while (i < clen) 
		{    
			var j = i + alen; 			
			if (document.cookie.substring(i, j) == newArg) return getCookieVal (j,key);    
			i = document.cookie.indexOf(" ", i) + 1;    
			if (i == 0) break;   
		}
	}	
	return '';
}
function getCookieVal(offset,key) {
	var endstr = document.cookie.indexOf (";", offset);
	if (endstr == -1) endstr = document.cookie.length;
	var val=unescape(document.cookie.substring(offset, endstr));	
	if(key!='')
	{		
		var arg = key + "=";
		var alen = arg.length;
		var clen = val.length;
		var i = 0;
		var bFound=false;
		while (i < clen) 
		{    
			var j = i + alen; 
			if (val.substring(i, j).toUpperCase() == arg.toUpperCase())
			{   
				if(val.indexOf("&", j)==-1)	
				{					
					val=val.substring(j,val.length);    
					bFound=true;
				}
				else
				{
					val=val.substring(j,val.indexOf ("&", j));
					bFound=true;  				
				}
			}
			i = val.indexOf("&", i) + 1;    
			if (i == 0) break;   
		}	
		if(!bFound) val='';	 	
	}	
	if(val==null)
		return '';
	else
		return val;										
}

/***********************************************************/

// [EOF] for file menu-monoframe.js

//package loaded!
packages.complete('HEADER');

// Served in 4 ms