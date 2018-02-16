// Package GUIJS / Copyright 2018 Archimed SA / JSE

//loading package...
packages.acknowledge('GUIJS');

// file: gui.js


switcher = new switchManager();
/*****************************************************************************
 Define switching controls
*****************************************************************************/

//create a switcher form ('container-id', 'label')

if(document.getElementById('content-sub')!==null){
	var screenSwitcher2 = new bodySwitcher('content-sub', s_WAI_TYPES_COLORS_LABEL);

	//add a new class option ('classname', 'label')
	screenSwitcher2.defineClass('default', '-');
	screenSwitcher2.defineClass('colors_blackwhite', s_WAI_TYPES_COLORS_OPTIONS_colors_blackwhite);
	screenSwitcher2.defineClass('colors_whiteblack', s_WAI_TYPES_COLORS_OPTIONS_colors_whiteblack);
	screenSwitcher2.defineClass('colors_blackyellow', s_WAI_TYPES_COLORS_OPTIONS_colors_blackyellow);
}

if(document.getElementById('content-sub')!==null){
	var screenSwitcher3 = new bodySwitcher('content-sub', s_WAI_TYPES_FONT_FAMILY_LABEL);

	//add a new class option ('classname', 'label')
	screenSwitcher3.defineClass('default', '-');
	screenSwitcher3.defineClass('fontfamily_courier', s_WAI_TYPES_FONT_FAMILY_OPTIONS_fontfamily_courier);
	screenSwitcher3.defineClass('fontfamily_arial', s_WAI_TYPES_FONT_FAMILY_OPTIONS_fontfamily_arial);
	screenSwitcher3.defineClass('fontfamily_tahoma', s_WAI_TYPES_FONT_FAMILY_OPTIONS_fontfamily_tahoma);
	screenSwitcher3.defineClass('fontfamily_trebuchet_ms', s_WAI_TYPES_FONT_FAMILY_OPTIONS_fontfamily_trebuchet_ms);
}


//**** Fonctions du chat anciemmement dans GUI.XSL
function submitConnected() {
	var strDataUrl = "/ermes/chat/requests/notifyConnected.aspx?INSTANCE=" + i_strInstance;
	var xhr; // on d?clare l'instance

	if (window.XMLHttpRequest) xhr = new XMLHttpRequest(); // Firefox, Opera, Konqueror, Safari, ...
	else if (window.ActiveXObject) xhr = new ActiveXObject('Microsoft.XMLHTTP'); // Internet Explorer
	else alert('Votre navigateur est incompatible'); 

	xhr.open('POST',strDataUrl,true);
	xhr.onreadystatechange = function() // attribution de la fonction
	{	
		//reponse du serveur
		if (xhr.readyState == 4)
		{       
			//alert(xhr.responseText);                
		}
	}
	xhr.send('<NOTIFY />');
	timeoutID = setTimeout("submitConnected()",300000);
};

function setTitlePage() {
	if(cptTitlePage%2==0)
		document.title = defaultTitlePage;
	else{
		if(nbWaitingMsg > 1)
			document.title = nbWaitingMsg+' '+g_strNewMessages;
		else
			document.title = nbWaitingMsg+' '+g_strNewMessage;				 
	}
	cptTitlePage++;
	timeoutPageTitleNotif = setTimeout("setTitlePage()",5000);
};

function getThirtyChar(texte) {
	if (texte.length > 30) texte = texte.substring(0, 27)+'...';     
	return texte;
}


function WaitingMessage() {

	this.isShow = true,
	this.g_strInstance = i_strInstance;
	
	this.CreateDivForWaitingMessage = function()
	{	
		var div_waiting_message = Ext.get('div_waiting_message');		   
		div_waiting_message.setVisible(false);
		div_waiting_message.setWidth(222);
		div_waiting_message.setHeight(50);		            
		div_waiting_message.setX(document.body.clientWidth / 2-111);	
	},

	this.slideDivIn = function(){
		this.isShow = true;
		Ext.get('div_waiting_message').slideIn('b', {  
			easing: 'easeOut',  
			duration: 2  
		});             
	},

	this.slideDivOut = function(){
		if(this.isShow){
			window.clearTimeout(timeoutPageTitleNotif);
			document.title = defaultTitlePage
			Ext.get('div_waiting_message').slideOut('b', {  
				easing: 'easeOut',  
				duration: 2  
			});       
			this.isShow = false;
		}
	},		

	this.closeDiv = function(){			
		window.clearTimeout(timeoutPageTitleNotif);
		document.title = defaultTitlePage
			if(this.isShow){							
			Ext.get('div_waiting_message').setVisible(false);
			this.isShow = false;
		}
	},

	this.goChat = function(){
		window.clearTimeout(timeoutGetMsgInWait);	
		window.clearTimeout(timeoutPageTitleNotif);
		this.nbMsg = "0";
	},

	this.getPopupMessage = function(nbMsgTmp){
		if(nbMsgTmp == 1)
			return '<a href="/ermes/chat/home.aspx?instance='+this.g_strInstance+'">'+g_strYouHave+' '+nbWaitingMsg+' '+g_strNewMessage+'</a> '+imgCancelPopupWaitingMsg;								
		else
			return '<a href="/ermes/chat/home.aspx?instance='+this.g_strInstance+'">'+g_strYouHave+' '+nbWaitingMsg+' '+g_strNewMessages+'</a> '+imgCancelPopupWaitingMsg;								
	}, 

	this.CheckWaitingMessage = function (timer){		
		var strDataUrl = "/ermes/chat/requests/getWaitingMessage.aspx?INSTANCE=" + i_strInstance;	
		Ext.Ajax.request({
		url: strDataUrl,
		method: 'GET',
		params:{idCurrentInterlocuteurEncart:idCurrentInterlocuteurEncart},
		success: function(response, request) {
			var doc = response.responseXML;		
			
			if(!doc.getElementsByTagName('R'))
				return;
			
			if(!doc.getElementsByTagName('R')[0])
				return;
			
			if(doc.getElementsByTagName('R')[0].getAttribute('enableNotification')=="true"){										
			
				timeoutGetMsgInWait = setTimeout('waitingMessage.CheckWaitingMessage('+timer+')',timer);
				if(doc.getElementsByTagName('R')[0].getAttribute('nbMsg')!="0" && waitingMessage.isShow==true){				
						window.clearTimeout(timeoutPageTitleNotif);	
						setTitlePage();
						waitingMessage.isShow = true;							
						nbWaitingMsg = doc.getElementsByTagName('R')[0].getAttribute('nbMsg');
						waitingMessage.slideDivIn();
						Ext.get('last_popup_content_msg').dom.innerHTML = doc.getElementsByTagName('SENDER_NAME')[0].childNodes[0].nodeValue + '<br /><i>' + getThirtyChar(doc.getElementsByTagName('DATA')[0].childNodes[0].nodeValue)+'</i>';						
						Ext.get('content_popup_waiting_msg').dom.innerHTML = waitingMessage.getPopupMessage(nbWaitingMsg);
				}
			}else{}
		},
		failure: function(response, request) {timeoutGetMsgInWait = setTimeout('waitingMessage.CheckWaitingMessage('+timer+')',timer);},
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		}
		}); 			

	}
}

function calcScroll(){
	if(Ext.isIe){
		scrollTop = body.scrollTop + document.body.clientHeight -46;
	}		
}

var waitingMessage = new WaitingMessage();

function launchTimerWaitingMsg(){	
	if(popupWaitingMsgIsEnable){			
		waitingMessage.CreateDivForWaitingMessage();      			
		waitingMessage.CheckWaitingMessage('50000');			
	}
}

$(window).load(function(){
	$("iframe#frame_control_bkl").attr("src", "/ClientBookline/controlBKL.asp?INSTANCE=" + i_strInstance);
});



// **** Language

function setLanguage(strLanguage) {											
	var tValues1 = window.location.href.split("?");
	if(tValues1[1]) {
		var tValues2 = tValues1[1].split("&");
		var strNewURL = tValues1[0]+"?";
		var bLanguageFound=0;
		var i=0;
		for(i=0;i<tValues2.length;i++) {
			if (tValues2[i].substring(0,11)=="SETLANGUAGE") {
				bLanguageFound=1;
				strNewURL+="SETLANGUAGE="+strLanguage;
			} else {
				//alert(tValues2[i].charAt(tValues2[i].length-1));
				if (tValues2[i].charAt(tValues2[i].length-1)=='#') {
					strNewURL+=tValues2[i].substring(0,tValues2[i].length-1);
				} else {
					strNewURL+=tValues2[i];
				}
			}
			if (i<tValues2.length-1) {
				strNewURL+="&";
			}
		}
		if (!bLanguageFound) {
			strNewURL = "";
			for(i=0;i<tValues1.length;i++) {
				strNewURL += tValues1[i];
				if (i<tValues1.length-1)
					 strNewURL += "?";
			}
			strNewURL+="&SETLANGUAGE="+strLanguage;
		}
		window.location=strNewURL;
	} else {
		window.location.href = window.location.href + "?SETLANGUAGE="+strLanguage;
	}
}



// [EOF] for file gui.js

//package loaded!
packages.complete('GUIJS');

// Served in 117 ms