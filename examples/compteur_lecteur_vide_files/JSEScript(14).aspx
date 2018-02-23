// Package BOOKLINE_ALL / Copyright 2018 Archimed SA / JSE

//loading package...
packages.acknowledge('BOOKLINE_ALL');

// file: bkldetaillednotice.js

/*jslint evil: true*/
/* DEBUT OPENURL */
function ProcessOULRequests() {

	var CountReq = g_arrOULReqs.length;

	for (var i=0;i<CountReq;i++) {
		eval(g_arrOULReqs[i]);
	}
}

function Initialize(sOULCode) {
	try {
		eval('OUL_Req'+sOULCode+'=new ActiveXObject("Msxml2.XMLHTTP");');
	} catch(e) {
		try {
			eval('OUL_Req'+sOULCode+'=new ActiveXObject("Microsoft.XMLHTTP");');
		} catch(oc) {
			eval('OUL_Req'+sOULCode+'=null;');
		}
	}
	eval('if(!OUL_Req'+sOULCode+'&&typeof XMLHttpRequest!=="undefined") OUL_Req'+sOULCode+'= new XMLHttpRequest();');
} 

function SendQuery(sOULCode,sSearchString,sCodeDocBaseList,sLibelle,sPremierIndicateur) {
	Initialize(sOULCode); 
	var url="/clientBookline/recherche/common/sources/OUL_Dispatch.asp?INSTANCE="+sInstance+"&SEARCHSTRING="+escapeU(sSearchString)+"&CODEBASELIST="+sCodeDocBaseList+'&LIBELLE='+escapeU(sLibelle);
	if (sPremierIndicateur==2) {
		url+="&DISPLAYRESULTS=TRUE";
	}
	url+= "&BACKURL="+escape(window.location.href);
	//open(url);					
	eval('if(OUL_Req'+sOULCode+'!=null)	{OUL_Req'+sOULCode+'.onreadystatechange = Process'+sOULCode+';OUL_Req'+sOULCode+'.open("GET", url, true);OUL_Req'+sOULCode+'.send(null);}');
}
/* FIN OPENURL */

var xhr=null;

function getXhr() {
	if(window.XMLHttpRequest) {// Firefox et autres
		xhr = new XMLHttpRequest();
	} else if(window.ActiveXObject) { // Internet Explorer
		try {
			xhr = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		}
	} else { // XMLHttpRequest non support? par le navigateur
	  alert("Votre navigateur ne supporte pas les objets XMLHTTPRequest...");
	  xhr = false;
	}
}

function updateHolding(objDiv){
  xhr=null;
  getXhr();

  xhr.onreadystatechange  = function() { 
	   if(xhr.readyState  === 4) {
			if(xhr.status  === 200) {
				objDiv.innerHTML=xhr.responseText;
				objDiv.title='';
				window.status='Encart ' + objDiv.id + ' charg?.';
			}
			else {
			   objDiv.innerHTML='Failed...';
			}
	   }
  }; 
  xhr.open("GET",objDiv.title,true);
  xhr.send(null);
}

function updateHoldings(){
  var objDivs=document.getElementsByTagName('div');
  var objDiv=null;
  for(var i=0;i!=objDivs.length-1;i++){
	objDiv=objDivs[i];
	if(objDiv.id.substring(0,13)=='DIV_HOLDINGS_') {
	  updateHolding(objDiv);
	}
  }
}

function getResaURL(cote) {
	window.location.href = 'AuthentificationDossier.asp?reservation=1&value=' + cote + '&backURL=' + escape(window.location.href);
	return false;
}

function ValiderFormulaireDetailledNotice( sUrl, bAll ) {
	var sName, bConfirm;
	sUrl = sUrl;
	if(document.FORM_NOTICES_DETAILLEES !== null){
		var CountElements = document.FORM_NOTICES_DETAILLEES.elements.length;
		
		for (var i=0; i<CountElements; i++) {
			if (document.FORM_NOTICES_DETAILLEES.elements[i].type === "checkbox") {
				sName = document.FORM_NOTICES_DETAILLEES.elements[i].name;
				if (document.FORM_NOTICES_DETAILLEES.elements[i].checked) {
					sUrl = sUrl + "&chk" + sName.substring(3) + "=on";
				} else {
					sUrl = sUrl + "&chk" + sName.substring(3) + "=off";
				}
			}
		}
	}
	window.location.href = sUrl + '&DISPLAYMENU='+displaymenu+'&INSTANCE=' + sInstance + '&PORTAL_ID='+sPortalId;
}


var bDblClick = false;
var bValiderFormulaire = false;
var sNavigator = navigator.appName;
var currentOps = '';

function ClickOneNotice( iNotice, lDebut ) {
	if (! bDblClick) {
		if (document.FORM_NOTICES_DETAILLEES.elements['chk' + iNotice].checked === false) {
			if (sNavigator.toLowerCase() !== 'netscape') {
			}
			document.FORM_NOTICES_DETAILLEES.elements['chk' + iNotice].checked = true;
		} else  {
			if (sNavigator.toLowerCase() !== 'netscape') {
			}
			document.FORM_NOTICES_DETAILLEES.elements['chk' + iNotice].checked = false;
		}
	} else {
		if (! bValiderFormulaire) {
			bValiderFormulaire = true;
			ValiderFormulaireDetailledNotice( 'NoticesDetaillees.asp?ldebut=' + lDebut );
		}
	}
}

function SelectOneNotice( iNotice, ldebut ) {
	if (! bValiderFormulaire) {
		bValiderFormulaire = true;
		bDblClick = true;
		document.FORM_NOTICES_DETAILLEES.elements['chk' + iNotice].checked = true;
		ValiderFormulaireDetailledNotice( 'NoticesDetaillees.asp?iNotice='+iNotice+'&ldebut=' + ldebut );
	}
}

function Navigate( lDebut ) {
	document.FORM_NOTICES_DETAILLEES.action = 'NoticesCourtes.asp';
	document.FORM_NOTICES_DETAILLEES.ldebut.value = lDebut;
	ValiderFormulaireDetailledNotice( 'NoticesCourtes.asp?lDebut=' + lDebut );
}

function NavigateProgress( lDebut ) {
	document.FORM_NOTICES_DETAILLEES.action = 'executerRechercheProgress.asp';
	document.FORM_NOTICES_DETAILLEES.ldebut.value = lDebut;
	ValiderFormulaireDetailledNotice( 'executerRechercheProgress.asp?lDebut=' + lDebut );
}

function PutIntoBasketND(sID) {
	var i, sName, bConfirm, sBackUrl;
	var nbAdded=0;
	sBackUrl = thisurl;
	sUrl='/clientbookline/recherche/common/sources/AddEltsIntoBasket.asp?INSTANCE='+sInstance;
	var ifrm = document.getElementById('w_action');
	if (sID === '') {
		ifrm.src = sUrl + '&DOCID=' + sDocId + '&DOCBASE='+sCodeBase+'&BACKURL=' + escape(sBackUrl);
	} else {
		ifrm.src = sUrl + '&ID=' + sID + '&BACKURL=' + escape(sBackUrl);
	}
}

function IsExportFunctionChecked(FormatShortName) {

	var FormatFullName = 'chkExport_' + FormatShortName;
	
	var CheckBox = document.getElementById(FormatFullName);
		
	if (CheckBox != undefined) {
		if (CheckBox.checked != undefined) {
			return CheckBox.checked;
		}
	}
	

	return false;
}

function ExportND(sID) {
	var i, sName, bConfirm, sBackUrl;
	var nbAdded=0;
	// Url
	sBackUrl = thisurl;
	sUrl='/clientbookline/recherche/common/sources/exportNotices.asp?';
	// Options d'export
	var oElems = document.FORM_NOTICES_DETAILLEES.elements;
	var ResTable=new Array(3);	
	var sTypeExport, sFormatExport,sCodeDisplay;
	
	
	if (document.getElementsByName('chkExport')[0].checked) {
		sTypeExport=4;		
		sFormatExport='';
		sCodeDisplay = '';
	} else if (document.getElementsByName('chkExport')[1].checked) {
		sTypeExport=3;		
		// SL - 20090901 - Choix de l'encodage de caract?re pour le format ISO2709					
		if (getElementById('TYPEEXPORTISO2709') != null)
			sFormatExport=getElementById('TYPEEXPORTISO2709').value;
		else
			sFormatExport='';
		// SL - 20090901 - Choix de l'encodage de caract?re pour le format ISO2709					
		sCodeDisplay = '';
	} else if (document.getElementsByName('chkExport')[2].checked) {
		sTypeExport=getElementById('TYPEEXPORT').value;		
		sFormatExport=getElementById('FORMATEXPORT').value;
		switch(sFormatExport) {
			case 0:
				sCodeDisplay = display_notice_courte;
				break;
			case 1:
				sCodeDisplay = display_notice_complete;
				break;
			default:
				sCodeDisplay = '';
		}
	}
	
	// GJ-20090115 : Export PDF depuis la boite d'export Incipio
	else if(document.getElementsByName('chkExport')[5].checked)
	{
		$('#formPdf').submit();
		return;
	} else if (IsExportFunctionChecked('ENDNOTE')) {
		alert('Not Implemented yet.');
	}
	
	// GJ-20090115 : Export PDF depuis la boite d'export Incipio

	var ifrm = document.getElementById('w_action');
	// SL - 20090901 - Choix de l'encodage de caract?re pour le format ISO2709 - utilisation docid et docbase					
	ifrm.src = sUrl + 'DOCID='+sDocId+'&DOCBASE='+sCodeBase+'&TYPEEXPORT=' + sTypeExport + '&FORMATEXPORT=' + sFormatExport + '&CODE_DISPLAY=' + sCodeDisplay + '&BACKURL=' + escape(sBackUrl);
	// SL - 20090901 - Choix de l'encodage de caract?re pour le format ISO2709 - utilisation docid et docbase					

	return false;
}

/*
function ExportND(sID) {
	var i, sName, bConfirm, sBackUrl;
	var nbAdded=0;
	// Url
	sBackUrl = thisurl;
	sUrl='/clientbookline/recherche/common/sources/exportNotices.asp?';
	// Options d'export
	var oElems = document.FORM_NOTICES_DETAILLEES.elements;
	var ResTable=new Array(3);	
	var sTypeExport, sFormatExport,sCodeDisplay;
	
	
	if (document.getElementsByName('chkExport')[0].checked) {
		sTypeExport=4;		
		sFormatExport='';
		sCodeDisplay = '';
	} else if (document.getElementsByName('chkExport')[1].checked) {
		sTypeExport=3;		
		sFormatExport='';
		sCodeDisplay = '';
	} else if (document.getElementsByName('chkExport')[2].checked) {
		sTypeExport=getElementById('TYPEEXPORT').value;		
		sFormatExport=getElementById('FORMATEXPORT').value;
		switch(sFormatExport) {
			case 0:
				sCodeDisplay = display_notice_courte;
				break;
			case 1:
				sCodeDisplay = display_notice_complete;
				break;
			default:
				sCodeDisplay = '';
		}
	}
	
	// GJ-20090115 : Export PDF depuis la boite d'export Incipio
	else if(document.getElementsByName('chkExport')[5].checked)
	{
		$('#formPdf').submit();
		return;
	}
	// GJ-20090115 : Export PDF depuis la boite d'export Incipio

	var ifrm = document.getElementById('w_action');
	ifrm.src = sUrl + 'INOTICE=' + sID + '&TYPEEXPORT=' + sTypeExport + '&FORMATEXPORT=' + sFormatExport + '&CODE_DISPLAY=' + sCodeDisplay + '&BACKURL=' + escape(sBackUrl);

	return false;
}*/

function Imprimer(sID) {
	var sName, bConfirm, sBackUrl,sUrl;
	var nbAdded=0;
	sBackUrl = thisurl;
	sUrl='/clientbookline/recherche/common/sources/print_preview.asp?ID=' + sID;
	// Format
	
	var CountElts = document.getElementsByName('FORMAT').length;
	
	for (var i=0; i<CountElts;i++) {
		if (document.getElementsByName('FORMAT')[i].checked) {
			sUrl = sUrl + "&FORMAT=" + document.getElementsByName('FORMAT')[i].value;
		}
	}
	window.open(sUrl);
	return false;
}

function viewMARCNotice() {	
	window.location.href = thisurl+'&MARC=1';
}

function viewFormatedNotice() {	
	var queryString = querystring;
	window.location.href = url + "?" + queryString.substring(0, queryString.length - 7);
}

function addLink() {
	var backURL = url + '?PARAM='&+querystring+'&FROM=LINKEDIT';
	window.location.href = 'importer.asp?NOTICE='+inotice+'&BACKURL=' + escape(backURL);
}

function viewBasketND() {
	var backURL = thisurl;
	window.location.href = '../service/panier.asp?BACKURL=' + escape(backURL);
}

function DoOperationND(iNotice) {
	var oElems = document.FORM_NOTICES_DETAILLEES;
	var i;
	var CountElts = oElems.length;
	
	for (i=0; i<CountElts;i++) {
		if (oElems[i].type === 'radio' && oElems[i].checked) {
			if (oElems[i].value === 'EXPORT') {
				ExportND(iNotice);
			} else if (oElems[i].value === 'PRINT') {
				Imprimer(iNotice);
			} else if (oElems[i].value === 'BASKET') {
				PutIntoBasketND(iNotice);
			} else if (oElems[i].value === 'VIEWBASKET') {
				viewBasketND();
			} else if (oElems[i].value === 'MARC') {
				viewMARCNotice();
			} else if (oElems[i].value === 'FORMAT') {
				viewFormatedNotice();
			} else if (oElems[i].value === 'LINK') {
				addLink();
			}
			return;
		}
	}
}

/*
function CheckAllItem(chk) {
	var oElems = document.FORM_NOTICES_DETAILLEES.elements;
	var i;
	for (i=0;i<oElems.length;i++) 
	{
		if (oElems[i].type === 'checkbox'){
			if (chk.checked) {			
				oElems[i].checked = true;
			} else {
				oElems[i].checked = false;
			}
		}							
	}
}*/

/**********************************************************************************************/
/*	HIP - bulletinage : DEBUT */
/**********************************************************************************************/
var reqHIP;				
function InitializeHIP() {
	try {
		reqHIP=new ActiveXObject("Msxml2.XMLHTTP");
	} catch(e) {
		try {
			reqHIP=new ActiveXObject("Microsoft.XMLHTTP");
		} catch(oc) {
			reqHIP=null;
		}
	}

	if(!reqHIP && typeof XMLHttpRequest!=="undefined") {
		reqHIP= new XMLHttpRequest();
	}
}

var currentDivId = "";
function ProcessHIP() {
	if (reqHIP.readyState === 4) {
		// only if "OK"
		if (reqHIP.status === 200) {
			if(reqHIP.responseText!=="") {
				document.getElementById(currentDivId ).innerHTML = reqHIP.responseText;
			}
		} else {
			document.getElementById(currentDivId ).innerHTML="There was a problem retrieving data:<br>"+reqHIP.statusText;
		}
	}
}

function SendQueryHIP(copykey,docid) {
	if (! copykey) {
		return false;
	}
	InitializeHIP();
	currentDivId = "divSerial"+copykey;
	
	if(reqHIP!==null) {
		var url="/clientBookline/integration/HIP/getHIPSerials.asp?instance=" + sInstance + "&copyKey="+copykey+"&docid="+docid+"&CODEBASE=" + sCodeBase;
		reqHIP.onreadystatechange = ProcessHIP;
		reqHIP.open("GET", url, true);
		reqHIP.send(null);
	}
}


/**********************************************************************************************/
/*	HIP - bulletinage : FIN */
/**********************************************************************************************/
var bLicenseStart = false;
var licenseUID = -1;
var bLicenseWait = false;
var bLicenseError = false;
var licenseTicks = 60000;
var licenseTimeout;
var licenseTimeoutStop;

function callbackLicenseStop() {
}


// stop la licence
function licenseStop() {
	var url = '/bam/resource/licenseLight.aspx?INSTANCE=' + sInstance + '&UID='+licenseUID+'&ACT=STOP';
	if (bLicenseWait) {
	url = url + '&MODE=WAIT';
	}
	popups.get('popupLicense').putPropertyValue('src',url);
	popups.show('popupLicense',callbackLicenseStop);
}

// stop la licence et arrete l'application
function killAll() {
	if (licenseTimeoutStop) {
		clearTimeout(licenseTimeoutStop);
	}
	licenseStop();
	document.getElementById('ErmesLauncher1').Stop(false);
}

function callbackLaunchTs(id,value) {
}

//demande une licence et lance l'application si ok
function LaunchAppli() {
	var url;
	try {
		document.getElementById('ErmesLauncher1').EID = sDocId;
		document.getElementById('ErmesLauncher1').Instance = sInstance;
		document.getElementById('ErmesLauncher1').Server = sErmesServer;
		document.getElementById('ErmesLauncher1').XmlLaunch = sErmesXmlLaunch;
		document.getElementById('ErmesLauncher1').LaunchXml();
	} catch(e) {
		if (sErmesTS) {
			url = '/bam/resource/termserv.aspx?INSTANCE=' + sInstance + '&EID=' + sDocId;
			popups.get('popupLaunchTs').putPropertyValue('title','Lancement de l\'application ...');
			popups.get('popupLaunchTs').putPropertyValue('src',url);
			popups.show('popupLaunchTs',callbackLaunchTs);
			//JSGo(url);
		}
	}
	
	/*licenseUID = -1;
	licenseWait = false;
	licenseError = false;
	bLicenseStart = false;
	while (ReadMessage());
	popups.get('popupLicense').putPropertyValue('title','Lancement de l\'application ...');
	popups.get('popupLicense').putPropertyValue('src','/bam/resource/licenseLight.aspx?INSTANCE=' + sInstance + '&SIMEID=' + sDocId);
	popups.show('popupLicense',callbackLaunch);*/
}

function ReadMessage() {
	var result = document.getElementById('ErmesLauncher1').ReadMessage();
	return result;
}

function GetMessage() {
	var result = document.getElementById('ErmesLauncher1').GetMessage();
	var aResult = result.split('|');
	return aResult[0];
}



function callbackLaunch(id,value) {
	if (!value) {
		killAll();
	}
}


// stop la licence si l'application s'arrete
function ActiveStop() {
	var valMessage;
	while (ReadMessage()) {
		valMessage = GetMessage();
		if (valMessage === -2 || valMessage === 3 || valMessage === -3) {
			try {
				popups.get('popupLicense').dismiss(false);
			} catch(e) {
				killAll();
			}
			return false;
		}
	}
	licenseTimeoutStop = setTimeout("ActiveStop()",1000);
}

// d?marre l'application
function startAppli() {
	var xmlLauncher = sErmesXmlLaunch;
	document.getElementById('ErmesLauncher1').XmlLaunch = xmlLauncher;
	document.getElementById('ErmesLauncher1').Start();
	var valMessage ;
	while (ReadMessage()) {
		valMessage = GetMessage();
		if (valMessage === -2 || (bLicenseStart && valMessage === 3)) {
			popups.get('popupLicense').dismiss(false);
			licenseStop();
			return false;
		}
		
		if (valMessage === 2) {
			bLicenseStart = true;
			ActiveStop();
			return true;
		}
	}
}

//attente active pour la licence
function ActiveWait() {
	if (licenseTimeout) {
		clearTimeout(licenseTimeout);
	}

	var url = '/bam/resource/licenseLight.aspx?INSTANCE=' + sInstance;
	url = replaceQSParam(url,'SIMEID',"");
	url = replaceQSParam(url,'UID',licenseUID);
	if (bLicenseWait) {
		url = replaceQSParam(url,'MODE',"WAIT");
		url = replaceQSParam(url,'ACT',"WAIT");
	} else {
		url = replaceQSParam(url,'MODE',"");
		url = replaceQSParam(url,'ACT',"LOAD");
	}
	
	//alert(url)
	if (!bLicenseError) {
		//document.location.href = url;
		licenseTimeout = setTimeout("ActiveWait()",licenseTicks);
		try {
			popups.get('popupLicense').dismiss(true);
		} catch(e) {
		}
		popups.get('popupLicense').putPropertyValue('src',url);
		popups.show('popupLicense',callbackLaunch);
	}
}


function licenseWait() {
	alert('wait');
}

/*GJ-20090119 : suppression de commentaires*/
var ucUidToRemove=null;
function callbackRemoveComment(id, value) {
	if (value) {
		$.get(
			"/medias/getressourcecomments.aspx", {
				INSTANCE: sInstance,
				RSC_UID:sRscUid,
				VALIDATE:ucUidToRemove,
				ACT:"DELETE"
			},
			function(){
				window.location.reload();
			},
			"html");
	}
}

function removeComment(ucUid) {
	ucUidToRemove=ucUid;
	popups.show('confirmRemoveComment', callbackRemoveComment,'');
}

/*GJ-20090119 : suppression de commentaires*/
function callbackAddComment(id,value) {
	if (value) {
		JSGo(document.location.href);
	}
}

function addComment() {
	popups.get('popupComments').putPropertyValue('title', wml_COMMENTS_POPUP_TITLE);
	popups.get('popupComments').putPropertyValue('src','/medias/manageressourcecomment.aspx?INSTANCE=' + sInstance + '&RSC_UID=' + sRscUid);
	popups.show('popupComments',callbackAddComment);
}

function editComment(ucUid) {
	popups.get('popupComments').putPropertyValue('title', wml_COMMENTS_POPUP_TITLE);
	popups.get('popupComments').putPropertyValue('src','/medias/manageressourcecomment.aspx?INSTANCE=' + sInstance + '&RSC_UID=' + sRscUid + '&UCUID='+ucUid);
	popups.show('popupComments',callbackAddComment);

}

function showCommentForm() {
	var objDiv=document.getElementById('div_commentaire');

	if(!objDiv)	{
		return;
	}

	lDivOffset=0;
	objDiv.style.display='';
}

function callbackComments(id,value) {
}

function seeComments() {
	popups.get('popupComments').putPropertyValue('title','Commentaires...');
	popups.get('popupComments').putPropertyValue('src','/medias/getressourcecomments.aspx?INSTANCE=' + sInstance + '&RSC_UID=' + sRscUid);
	popups.show('popupComments',callbackComments);
}

function submitComment() {
	var bCanValidate = true;
	if(document.getElementById('UC_TITLE').value === '') {
		bCanValidate = false;
		document.getElementById('UC_TITLE').value='Saisissez un titre';
	}
	
	if(document.getElementById('UC_COMMENT').value === '') {
		bCanValidate = false;
		document.getElementById('UC_COMMENT').value='Saisissez un commentaire';
	}
	
	if(bCanValidate) {
		document.getElementById('form_comment').submit();
	}
}

function openThumbnail() {
	window.open('/medias/adminThumbnail.aspx?INSTANCE=' + sInstance + '&DDC=thumbnail.xml&ID=' + sRscUid,'_blank','resizable=no,scrollbar=no,toolbar=no,status=no,height=550,width=550;',false);
	return false;
}

function EditResource(sUrl) {
	// ALA-20090402 : Remplacement de la valeur en dur INCIPIO par l'instance 
	window.location.href='/bam/resource/home.aspx?instance=' + sInstance + '&DEFAULT_ACTION=URL:'+escape(sUrl);
}

// * EXEMPLAIRES INFODOC VIA WEBSERVICES : DEBUT *****************************************

var HoldingNavigator=function(){

    var holdings = new Ext.data.Record.create(
	[
                {name:'AlternativeCallNumber', mapping:'AlternativeCallNumber'},
                {name:'CallNumber', mapping:'CallNumber'},
                {name:'HoldingNumber', mapping:'HoldingNumber'},
                {name:'InCreation', mapping:'InCreation'},
                {name:'InventoryNumber', mapping:'InventoryNumber'},
                {name:'LocationNote', mapping:'LocationNote'},
                {name:'PublicNote', mapping:'PublicNote'},
                {name:'ReservationCount', mapping:'ReservationCount'},
                {name:'HoldingStatus', mapping:'HoldingStatus.Label'},
                {name:'Location', mapping:'Location.Name'},
                {name:'Site', mapping:'Site.Label'},
                {name:'LoanCategory', mapping:'LoanCategory.Label'}
	]);
    
	// D?finition d'un enregistrement JSON
	var holdingReader = new Ext.data.JsonReader({
		    root: 'd.Holdings',
        successProperty:'success' } ,holdings);

    var holdingsStore=new Ext.data.Store({
	    proxy: new Ext.data.HttpProxy({
		    url: '/exploitation/infodoc/LibraryManagementPortalService.svc/GetBibliographicUnit?descNoticeId='+sDocId
		    }),
	    reader: holdingReader
    }); 

    var holdingTemplate=new Ext.XTemplate(
            '<br/>',
            '<table class="ermes_medias_section_bar" width="100%">',
            '<tr>',
            '<td>Exemplaires</td>',
            '</tr>',
            '<tr><td>',
	        '<table width="100%">',
            '<tr>',
		            '<td class="detail-libelle-fiche">Site</td>',
		            '<td class="detail-libelle-fiche">Localisation</td>',
		            '<td class="detail-libelle-fiche">Cote</td>',
		            '<td class="detail-libelle-fiche">Cat?gorie de pr?t</td>',
		            '<td class="detail-libelle-fiche">Statut</td>',			           
            '</tr>',
		    '<tpl for=".">',
		        '<tr>',
		            '<td class="detail-valeur-fiche">{Site}</td>',
		            '<td class="detail-valeur-fiche">{Location}</td>',
		            '<td class="detail-valeur-fiche">{CallNumber} {AlternativeCallNumber}</td>',
		            '<td class="detail-valeur-fiche">{LoanCategory}</td>',
		            '<td class="detail-valeur-fiche">{HoldingStatus}</td>',			           
		        '</tr>',
		    '</tpl>',
		    '</table>',
        '</td></tr>',
        '</table>',
        '<br/>'
    );

	var dataView=new Ext.DataView({
		renderTo:'holdingTargetDiv',
		store:holdingsStore,
		tpl:holdingTemplate,
		autoHeight:true,
		autoWidth:true,
		itemSelector:'table.ermes_medias_section_bar',
    loadingText:'Chargement...<img src="/skins/'+sInstance+'/images/specific/BAM/spinner.gif"/>'
	});                        
				
	return {
		init:function(){
			holdingsStore.load();
			var i=1;
		}
	};
};

var holdingNavigator;
function runHoldings(){
	holdingNavigator=new HoldingNavigator();
	holdingNavigator.init();
	
}						
// * EXEMPLAIRES INFODOC VIA WEBSERVICES : FIN *****************************************

// [EOF] for file bkldetaillednotice.js

// file: bklformulaire.js

// DEBUT ********** Bases selection ********** 
function cb_BaseSelection(id, result) {
	if(result){
		document.location.href = "formulaire.asp?ACT=CHANGEBASE&NouvelleRecherche=0";
	}
}

/* ALA-20090707 : on passe en mode fancybox  */
function OpenBaseSelection() {
	$('#BaseSelectionLink').click();
}

/*
function OpenBaseSelection() {
	popups.get('BaseSelection').putPropertyValue("src","dlgBaseSelection.asp");
	popups.show("BaseSelection",cb_BaseSelection);									
}*/

//FIN ********** Bases selection ********** 
								
function SortKeySelected() {
    if (document.FORMULAIRE.chkDedoublonnage !== null && document.FORMULAIRE.chkSortKey !== null && !document.FORMULAIRE.chkSortKey.checked) {
        document.FORMULAIRE.chkDedoublonnage.disabled = false;
    } else {
        if (document.FORMULAIRE.chkDedoublonnage !== null) {
            document.FORMULAIRE.chkDedoublonnage.checked = false;
            document.FORMULAIRE.chkDedoublonnage.disabled = true;
        }
    }
    return false;
}

//Enclenche lorsque le tri du formulaire change
function SortKeyChanged(objSelect, sCode) {
    document.getElementById('chk' + sCode).checked = (objSelect.value.length !== 0);
    SortKeySelected();
}

function DeselectSortKey() {
    if (document.FORMULAIRE.chkDedoublonnage !== null && !document.FORMULAIRE.chkDedoublonnage.checked) {
        if (document.FORMULAIRE.chkSortKey !== null) {
            document.FORMULAIRE.chkSortKey.disabled = false;
        }
    } else {
        if (document.FORMULAIRE.chkSortKey !== null) {
            document.FORMULAIRE.chkSortKey.checked = false;
            document.FORMULAIRE.chkSortKey.disabled = true;
        }
    }
    return false;
}

function SetFocus() {
    var oElems = document.FORMULAIRE.elements;
    var i;
	var CountElements = oElems.length;
	
    for (i = 0; i < CountElements; i++) {
        if (oElems[i].type === 'text') {
            oElems[i].focus();
            return;
        }
    }
}

function copyEvent(dstIndexCode, srcIndexCode) {
    // On a chang? d'index, on doit modifier la combobox en cons?quence
	if(Ext.get('txtINDEX_' + dstIndexCode).dom===null) {
		return;
	}

	var oldValue=Ext.select('input#txtINDEX_' + dstIndexCode).elements[0].value;
    Ext.get('IndexContainer_' + dstIndexCode).dom.innerHTML = '';
    // Suppression du controle original
    var newControl=formControls.item(srcIndexCode).cloneConfig({
        // Cr?ation du nouveau controle en reprenat les m?mes name et id que l'ancien
        renderTo: 'IndexContainer_' + dstIndexCode,
        id: 'txtINDEX_' + dstIndexCode,
        name: 'txtINDEX_' + dstIndexCode,
		value:oldValue,
		width:210
    });
	
	// On ajoute le controle Google sur tous les champs (qu'ils soient texte ou selectbox)
	new GoogleSpell(newControl.getEl());
	
	// Si l'on ne voulait activer le control Google QUE pour les champs texte, il faudrait faire la chiose suivante (en commentaire)
	/*
	if(newControl.mode==null){
		new GoogleSpell(newControl.getEl());
	}
	*/
	
	// On cr?e le controle
	newControl.render();
}

function resetForm() {
    var objForm = document.FORMULAIRE;
    if (!objForm) {
        return;
	}

    var objElements = objForm.elements;
    if (!objElements) {
        return;
	}

    var objElement = null;
	var CountElements = objElements.length;
	
    for (var i = 0; i < CountElements; i++) {
        objElement = objElements[i];
        if (objElement) {
			if (objElement.name.substring(0, 3) === 'txt') {
				objElement.value = '';
			}
		}
        //alert(objElement.name.substring(0,3));
	}
}
// FIN VP : Gestion du MultiIndex


// Cocher la case dont le nom est pass???? en param????tre
function Check(strChk) {
    if (document.FORMULAIRE.elements[strChk].type !== 'hidden') {
        document.FORMULAIRE.elements[strChk].checked = true;
    }
}

// Traitement du message d'alerte
function ProcessAlert(sMsgAlert, sIndex) {
    var sFinalMsg;
    var ipos = sMsgAlert.indexOf('%');
    if (ipos >= 0) {
        sFinalMsg = sMsgAlert.substring(0, ipos) + sIndex + sMsgAlert.substring(ipos + 1);
        return sFinalMsg;
    } else {
        return sMsgAlert;
    }
}

function VerifyForm(sMsgAlert) {
    var iElem;
    var sName;
    var oElements = document.FORMULAIRE.elements;
	
	var CountElements = oElements.length;
	
    for (iElem = 0; iElem < CountElements; iElem++) {
        sName = oElements[iElem].name;
        if (oElements[iElem].type === 'hidden' && sName.substring(0, 4) === '_CHK') {
            // C'est un index obligatoire, il faut v????rifier que sa valeur n'est
            // pas nulle
            if (oElements[sName.substring(4)].value === '') {
                alert(ProcessAlert(sMsgAlert, oElements['_LIBELLE' + sName.substring(4)].value));
                return false;
            }
        } else if (oElements[iElem].type === 'text' && sName.substring(0, 9) === 'txtINDEX_') {
			// il faut vider les champs qui ne contiennent que des espaces
			var sValue;
			sValue = '';

			var CurrentElt = oElements[iElem];			
			var CountCurrent = CurrentElt.value.length;
			
			for (var j=0;j<CountCurrent;j++) {
				if (CurrentElt.value.charAt(j)!=' ') {
					sValue+=CurrentElt.value.charAt(j);
				}
			}						
			if (sValue.length===0) {
				CurrentElt.value='';
			}
        }
    }
    return true;
}

// Validation du formulaire de recherche
// Le formulaire doit se nommer 'FORMULAIRE'
function Valider(sMsgAlert) {
    // V????rification des champs obligatoires
    if (!VerifyForm(sMsgAlert)) {
        return false;
	}

    //GJ-20070105 : PORTAL_ID est d?duit du config.xml SEUL
    //if (getElementById('chkRepartitionKey')!== null && getElementById('chkRepartitionKey').checked) {
    //	document.FORMULAIRE.elements['PORTAL_ID'].value='bookline_repartition.xml';
    //}

    // Submit
    document.FORMULAIRE.submit();
}

function ChangeSearchOptions() {
    var dlg;
    dlg = window.showModalDialog("dlgCommon.asp?URL=" + escape('dlgSearchOptions.asp'), null, "dialogWidth:650px;dialogHeight:300px;help:no;maximize:no;minimize:no;scrollbars:no");
    if (dlg === 'ok') {
        document.FORMULAIRE.action = 'formulaire.asp';
        document.FORMULAIRE.ACT.value = 'CHANGEOPTIONS';
        document.FORMULAIRE.submit();
    }
}

function ChangeBaseSelection(strIdGrille) {
    var dlg;
    //				if (bw.ie) {
    dlg = window.showModalDialog("dlgCommon.asp?URL=" + escape('dlgBaseSelection.asp'), null, "dialogWidth:650px;dialogHeight:540px;help:no;maximize:no;minimize:no;scrollbars:no;status:no");
    if (dlg === 'ok') {
        document.FORMULAIRE.action = 'formulaire.asp';
        document.FORMULAIRE.ACT.value = 'CHANGEBASE';

        //GJ-20070105 : PORTAL_ID est d?duit du config.xml SEUL
        //document.FORMULAIRE.elements["PORTAL_ID"].value = 'bookline_formulaire.xml';
        document.FORMULAIRE.submit();
    }
    //				} else {
    //					window.location.href="dlgCommon.asp?URL=" + escape('dlgBaseSelection.asp');
    //				}
    }

function TermList(strCodeIndex, strCodeIndexAut, strType) {
    //alert('Liste de terme');
    if (document.FORMULAIRE.elements['txtINDEX_' + strCodeIndex].value !== '') {
        document.FORMULAIRE.ACT.value = 'TERMLIST';
        document.FORMULAIRE.VALUE.value = strCodeIndex + '#' + strCodeIndexAut + '#' + strType;
        document.FORMULAIRE.submit();
    }
}

function AjouterIndexExpert() {
    if (document.FORMULAIRE.txtSearchString.value !== "") {
        document.FORMULAIRE.txtSearchString.value = document.FORMULAIRE.txtSearchString.value + " ";
	}
    document.FORMULAIRE.txtSearchString.value = document.FORMULAIRE.txtSearchString.value + document.FORMULAIRE.cboIndexExpert.value + "=\"\"";
}
function AjouterOperateurExpert(sOp) {
    if (document.FORMULAIRE.txtSearchString.value !== "") {
        document.FORMULAIRE.txtSearchString.value = document.FORMULAIRE.txtSearchString.value + " ";
	}
    document.FORMULAIRE.txtSearchString.value = document.FORMULAIRE.txtSearchString.value + sOp;
}

function VerifySearchString() {
    if (document.FORMULAIRE.txtSearchString.value !== "") {
        var objXMLDoc = new ActiveXObject('MICROSOFT.XMLDOM');
        objXMLDoc.async = false;
        if (!objXMLDoc.load('common/sources/verifySearchString.asp?SEARCHSTRING=' + escape(document.FORMULAIRE.txtSearchString.value))) {
            alert(objXMLDoc.parseError.reason);
            return false;
        } else {
            if (objXMLDoc.selectSingleNode('VERIFYSEARCHSTRING/RETURNVALUE').text === 'ERROR') {
                return false;
            } else {
                return true;
            }
        }
        return false;
    } else {
        return false;
    }
}




// ***********************************************************************
// IDESIABROWSEBOX 
//Global variable
var g_strIdesiaXPath = null;
var g_lNbIdesiaLexicons = 0;
var g_strIdesiaBase = "";
var g_strIdesiaThes = "";
var g_strIdesiaForm = "";
var g_strIdesiaView = "";
var g_strIdesiaLexicons = "";
var g_strCurrentSelectionName = "";
var g_strCurrentSelectionValue = "";
var g_strXPath = "";
var g_objIdesiaNode = null;
var g_strCurrentIdesiaTagType = "";

//Idesia Popup and URLs variable
var g_cwf_instance = null;
var g_cwf_divIdesiaBrowser = document.createElement('div');
var g_cwf_resolveLexicons = '/masc/toolkit/idesia/plugin/rb/resolveLexicons.asp';
//var g_cwf_popupIdesiaBrowserUrl = '/masc/toolkit/idesia/plugin/browsebox.asp';
var g_cwf_popupIdesiaBrowserUrl = "/cda/tools/idesiabrowser/idesiabrowser.aspx";
var g_cwf_refreshThesaurusTree = '/masc/toolkit/idesia/plugin/rb/refreshthesaurustree.asp';
var g_cwf_currentIdesiaBoxEditing = '';
var g_cwf_currentIdesiaDialogCallbackFunction = '';

g_cwf_divIdesiaBrowser.id = 'cwf_divIdesiaBrowser';
g_cwf_divIdesiaBrowser.style.zIndex = 666;
g_cwf_divIdesiaBrowser.style.position = 'absolute';
g_cwf_divIdesiaBrowser.style.display = 'none';

var g_cwf_popupIdesiaBrowser = null;

//Callback function when the idesia browser popup is closed
function cwf_ReceptIdesiaLexicons(id, returnValues) {
    if (returnValues.length > 0) {

        // returnValues[0][0] : id du lexicon
        getElementById(g_strXPath).value = returnValues[0][1];
    }
}

//Call this function for show the Idesia Browser dialog
function cwf_OpenIdesiaBrowserDialog(id, src, callBackFunction) {
    var wd = window.open(src, 'cwf_popupIdesiaBrowser', 'titlebar=no ,toolbar=no,location=no,status=no,menubar=no,resizable=no,width=650,height=400');
    wd.focus();
    //Save the current idesia text box ID.
    g_cwf_currentIdesiaBoxEditing = id;
    //Save the current idesia text box callback function.
    g_cwf_currentIdesiaDialogCallbackFunction = callBackFunction;
}

function openIdesiaBrowseBoxEx(id, strPath, nbLexicons, strBase, strThes, strForm, strView, sAddCdd, sAddStd) {
    g_lNbIdesiaLexicons = nbLexicons;
    g_strIdesiaBase = strBase.toUpperCase();
    g_strIdesiaThes = strThes;
    g_strIdesiaForm = strForm;
    g_strIdesiaView = strView;
    g_strXPath = strPath;

    var url = g_cwf_popupIdesiaBrowserUrl + '?INSTANCE=' + i_strInstance + '&IDZBASE=' + g_strIdesiaBase + '&IDZTHES=' + g_strIdesiaThes + '&IDZVIEW=' + g_strIdesiaView + '&IDZFORM=' + g_strIdesiaForm + '&IDZSEL=' + '' + '&IDZMAX=' + g_lNbIdesiaLexicons + '&IDZADDCDD=' + sAddCdd + '&IDZADDSTD=' + sAddStd;
    cwf_OpenIdesiaBrowserDialog(id, url, cwf_ReceptIdesiaLexicons);
}

//Return the lexicons selected width the idesia browser
function receptIdesiaSearchLexicons(id, returnValues) {
    var i,
    j;
    var lexiconId;
    var lexiconFullId;
	var returnCount = returnValues.length;
	
    if (returnCount > 0) {
        if (g_lNbIdesiaLexicons > 1) {
            for (i = 0; i < returnValues.length; i++) {
                //Lorsqu'on re??oit des donn?es provenant de l'idesiaBrowseBox, les liens des termes sont complets (IDESIA://BASE#...)
                //alors que sur une recherche, seuls les identifiants des termes nous interessent
                lexiconFullId = returnValues[i][0];
                lexiconId = lexiconFullId.substring(lexiconFullId.lastIndexOf('#') + 1);
                AddLexiconToSelection(lexiconId, returnValues[i][1]);
            }
        } else {
            AddLexiconToSelection(objItem.getAttribute("LEXICONID"), objItem.getAttribute("LABEL"));
        }
    }
}

//Callback function when the idesia browser external window is closed
function IdesiaBrowserCallBack(value) {
    if (g_cwf_currentIdesiaDialogCallbackFunction !== null) {
        g_cwf_currentIdesiaDialogCallbackFunction(g_cwf_currentIdesiaBoxEditing, value);
    } else {
        cwf_ReceptIdesiaLexicons(g_cwf_currentIdesiaBoxEditing, value);
	}
}

function UpdateRadicalIndex(strCode, objChk) {
    if (objChk.checked) {
        getElementById('txtINDEX_' + strCode).name = 'txtINDEX_' + strCode + '_RADICAL';
        getElementById('cboOpeBool' + strCode).name = 'cboOpeBool' + strCode + '_RADICAL';
        getElementById('cboIndexFormat' + strCode).name = 'cboIndexFormat' + strCode + '_RADICAL';

    } else {
        getElementById('txtINDEX_' + strCode).name = 'txtINDEX_' + strCode;
    }
    alert(getElementById('txtINDEX_' + strCode).name);
    alert(getElementById('cboOpeBool' + strCode).name);
    alert(getElementById('cboIndexFormat' + strCode).name);	
}


// *******************************************
// ALA-20090401 : Javascript inclus via plugin BOOKLINE_FORMULAIRE (#2)
// *******************************************

var DYM_KEYBOARD_TIMEOUT=1500;
var DYM_INDEX_PREFIX='txtINDEX_';
var AJAX_DIV_PREFIX='AJAX_DIV_';
var DYM_Timers=new Array();
var DYM_DivContents=new Array();

function showDiv(){
	this.innerHTML=DYM_DivContents[this.id];  
}

function DYM_Div_Exists(InputID){
	return (document.getElementById(AJAX_DIV_PREFIX+InputID)!== null);  
}

function changeState(InputID, State){
	if (!DYM_Div_Exists(InputID)) {
	  return;
	}

	var objDiv=document.getElementById(AJAX_DIV_PREFIX+InputID);
	objDiv.onclick=null;
	objDiv.innerHTML='';
	objDiv.title='';

	switch(State){
	  case 'NONE':
		objDiv.className='DYM_ICON_NONE';
		break;
	  case 'PROCESSING':
		objDiv.className='DYM_ICON_PROCESSING';
		objDiv.title= wml_PROCESSING ;
		break;
	  case 'SUCCEEDED':
		objDiv.className='DYM_ICON_SUCCEEDED';
		objDiv.title= wml_SUCCEEDED ;
		break;
	  case 'FAILED':
		objDiv.className='DYM_ICON_FAILED';
		objDiv.title= wml_FAILED ;
		break;
	  case 'PROCESSING_ERROR':
		objDiv.className='DYM_ICON_ERROR';
		objDiv.title= wml_PROCESSING_ERROR ;
		break;
	  case 'TIME_OUT':
		objDiv.className='DYM_ICON_TIMEOUT';
		objDiv.title= wml_TIME_OUT ;
		break;                     
	}
}

function DYM_Process(InputID){
	// Test si on est en multi-index
	//alert('avant:' + InputID);
	//alert(InputID.substr(DYM_INDEX_PREFIX.length));     // 9 pour 'txt_INDEX'

	var DICO_ID;      // Identifiant du dico interrog?.
	DICO_ID=InputID.substr(DYM_INDEX_PREFIX.length);

	var objSelectMultiIndex=document.getElementById('INDEX_MAPPING_' + InputID.substr(DYM_INDEX_PREFIX.length));
	//alert(objSelectMultiIndex);
	if(objSelectMultiIndex) {
		DICO_ID=objSelectMultiIndex.value;
	}
  
	//alert('Input ID:' + InputID);
	//alert('Dico ID:' + DICO_ID);

	// Est-on bien en pr?sence d'un champ DidYouMean (a-t-on le div associ? ?)
	if(!DYM_Div_Exists(InputID)) {
	  return;
	}

	var objInput=document.getElementsByName(InputID)[0];
	
	if(objInput.value.length<=2) {
	  return;
	}
	  
	changeState(InputID,'PROCESSING');

	DictionaryService.BestMatches(i_strInstance,DICO_ID,objInput.value, function(retValue) {
	  changeState(InputID,'NONE');
	  var dv = document.getElementById(AJAX_DIV_PREFIX + InputID);
	  
	  if(retValue.indexOf(']')>0) {
		var SuggestedString=retValue;
		var DisplayedString=retValue;
		
		var regExp1=/\[/gi;
		DisplayedString=retValue.replace(regExp1,'<span class="DYM_SuggestedWord">');
		SuggestedString=retValue.replace(regExp1,'');
		
		var regExp2=/\]/gi;
		DisplayedString=DisplayedString.replace(regExp2,'</span>');
		SuggestedString=SuggestedString.replace(regExp2,'');

		DYM_DivContents[AJAX_DIV_PREFIX+InputID]='<div class="DYM_AJAX_DIV"><a href="#" onclick="setValue(\'' + InputID + '\', \'' + escape(SuggestedString) + '\')">' + DisplayedString + '</a><div class="CLOSE" onclick="changeState(\'' + InputID + '\', \'NONE\')" title="Fermer">' + wml_FERMER + '</div></div>';

		changeState(InputID,'FAILED');
		dv.onclick=showDiv;
	  } else {
		//dv.className='DYM_ICON_SUCCEEDED';
		changeState(InputID,'SUCCEEDED');
	  }
	},
		function(e){
			if(e._timedOut) {
			  changeState(InputID,'TIME_OUT');
			} else {
			  var dv = document.getElementById(AJAX_DIV_PREFIX + InputID);
			  DYM_DivContents[AJAX_DIV_PREFIX+InputID]='<div class="DYM_AJAX_DIV">' + e._message + '</div>';
			  changeState(InputID,'PROCESSING_ERROR');
			  dv.onclick=showDiv;
			}
		}
	);
}

function DYM_KeyPressed(){
	var IndexID=this.id;
	changeState(IndexID,'NONE');

	if(DYM_Timers[IndexID]!== null) {
		window.clearTimeout(DYM_Timers[IndexID]);
	}

	DYM_Timers[IndexID]=window.setTimeout(function () {
		DYM_Process(IndexID);
		}, DYM_KEYBOARD_TIMEOUT
	);
}

function DYM_onFailure(e){
	alert(e._message);
}

function setValue(InputID, Value){
	var objInput=document.getElementsByName(InputID)[0];
	objInput.value=unescape(Value);
	changeState(InputID,'SUCCEEDED');
}


// Cette fonction permet de cocher ou d?cocher des checkbox ayant un name identique
function SetCheckBox(InputName, checked) {
	$("input[name='" + InputName + "']").attr('checked', checked);
}


// [EOF] for file bklformulaire.js

// file: bklrepartition.js

function dynamicComplete() {						
	alert('searchStopped');			
}

function dynamicError(code,desc,param) {						
	alert('searchStoppedError : ' + code  + ' - ' + desc);
}

var m_nbResultsSelected=0;

function ValiderFormulaireRepartition(lQuota) {
		
	if (m_nbResultsSelected !== 0 && (lQuota === -1 || lQuota >= m_nbResultsSelected)) {
		// On va sp?cifier que la recherche en cours doit s'arr?ter
		//		var ifrm = document.getElementById('w_action');
		//		ifrm.src = "common/sources/StopRepartitionSearch.asp";
		//						requestBroker.run("common/sources/StopRepartitionSearch.asp",null, dynamicComplete, dynamicError, 10000, 10000);
		// Validation du formulaire
		document.FORMULAIRE_DISPATCH.submit();
	} else if (m_nbResultsSelected === 0) {
		alert(sNoSelection);
	} else if (m_nbResultsSelected > lQuota) {
		alert(sTooMuchSelected + '\n ' + sNbSelected + m_nbResultsSelected + '\n ' + sNbMax + lQuota);
	}
}



function RefreshNbResulsSelected() {
	m_nbResultsSelected=0;
	var oElems = document.FORMULAIRE_DISPATCH.elements;

	m_nbResultsSelected = 0;
	var CountElems = oElems.length;
	
	for (var i=0;i<CountElems;i++) {
	
		var Elt = oElems[i];
		
		if (Elt.type === 'checkbox' && Elt.name.substr(0,11) === 'chkDispatch' && ! Elt.disabled ) {
			if (Elt.checked) {		
				m_nbResultsSelected = m_nbResultsSelected + parseInt(document.FORMULAIRE_DISPATCH.elements['hid' + Elt.name.substr(3)].value, 10);
			}
		}
	}
	
	var NbRes = getElementById('NbResultsSelected');
	
	if (NbRes !== null) {
		NbRes.innerHTML = m_nbResultsSelected.toString();
	}
}

function CheckNumberOfResultsSelected(objChk,lQuota) {	
	if (objChk.checked) {		
		// Slection
			m_nbResultsSelected = m_nbResultsSelected + parseInt(document.FORMULAIRE_DISPATCH.elements['hid' + objChk.name.substr(3)].value, 10);
			if (getElementById('NbResultsSelected') !== null) {
				getElementById('NbResultsSelected').innerHTML = m_nbResultsSelected.toString();
			}
	} else {
		// D?selection
		m_nbResultsSelected = m_nbResultsSelected - parseInt(document.FORMULAIRE_DISPATCH.elements['hid' + objChk.name.substr(3)].value, 10);
		if (getElementById('NbResultsSelected') !== null) {
			getElementById('NbResultsSelected').innerHTML = m_nbResultsSelected.toString();
		}
	}
}

function CheckAll(oChk) {
	var oElems = document.FORMULAIRE_DISPATCH.elements;

	m_nbResultsSelected = 0;
	
	var CountElems = oElems.length;
	
	for (var i=0;i<CountElems;i++) {
	
		var Elt = oElems[i];
		
		if (Elt.type === 'checkbox' && Elt.name.substr(0,11) === 'chkDispatch' && ! Elt.disabled ) {
			if (oChk.checked) {
				if (oElems['rep' + Elt.name.substr(3)] == null) {
					oElems[i].checked = true; 
					if (oElems['hid' + Elt.name.substr(3)].value !== '') {
						m_nbResultsSelected = m_nbResultsSelected + parseInt(oElems['hid' + Elt.name.substr(3)].value, 10);
					}
				}
			} else {
				Elt.checked = false;
			}
		}
	}
	
	var NbresDiv = getElementById('NbResultsSelected');
	
	if (NbresDiv !== null) {
		NbresDiv.innerHTML = m_nbResultsSelected.toString();
	}
}	

function MajStatus(sId,sValue) {
	var oElem = getElementById(sId);
	oElem.innerHTML = sValue;		
}			

function dispatchOnClick(strChk,lQuota) {
	var objChk = document.FORMULAIRE_DISPATCH.elements[strChk];
	if (parseInt(document.FORMULAIRE_DISPATCH.elements['hid' + objChk.name.substr(3)].value, 10)>0 && parseInt(document.FORMULAIRE_DISPATCH.elements['hid' + objChk.name.substr(3)].value, 10)<=lQuota) {
		objChk.checked = ! objChk.checked;
		CheckNumberOfResultsSelected(objChk,lQuota);
	}
}

function dispatchOnDblClick(strChk,lQuota) {
	var objChk = document.FORMULAIRE_DISPATCH.elements[strChk];
	var bValidate = false;
	if (parseInt(document.FORMULAIRE_DISPATCH.elements['hid' + objChk.name.substr(3)].value, 10)>0 && parseInt(document.FORMULAIRE_DISPATCH.elements['hid' + objChk.name.substr(3)].value, 10)<=lQuota) {
		var oElems = document.FORMULAIRE_DISPATCH.elements;
		var i;
		for (i=0;i<oElems.length;i++) {
			if (oElems[i].type === 'checkbox' && oElems[i].name.substr(0,11) === 'chkDispatch' && ! oElems[i].disabled ) {
				if (oElems[i].name !== strChk) {
					oElems[i].checked=false;
				} else {
					oElems[i].checked=true;
					if (getElementById('NbResultsSelected') !== null) {
						getElementById('NbResultsSelected').innerHTML = oElems['hid' + oElems[i].name.substr(3)].value;
						m_nbResultsSelected = parseInt(oElems['hid' + oElems[i].name.substr(3)].value, 10);
					}
					bValidate = true; 
				}
			}
		}
		if (bValidate) {
			objChk.checked=true;ValiderFormulaireRepartition(lQuota);
		}
	} else {
		objChk.checked=false;
	}
}
/*
FONCTIONS EN DOUBLON (DEJA dans bookline.js)
function PutSearchIntoBasket() {
	//VP:on catche le libelle vide
	if (document.getElementById("LIBELLE_SEARCH").value === '') {
		alert(nosearchlabel);
	} else 	{		
		sBackUrl = thisurl;
		sUrl='common/sources/AddEltsIntoBasket.asp?INSTANCE='+sInstance;
		var ifrm = document.getElementById('w_action');
		ifrm.src = sUrl + '&SEARCH=TRUE&LIBELLE_SEARCH=' + escapeU(document.getElementById("LIBELLE_SEARCH").value);
	}
}
*/

// [EOF] for file bklrepartition.js

// file: bklshortnotice.js

function ValiderFormulaireShortNotice( sUrl, bAll ) {
	var sName, bConfirm;
	sUrl = sUrl;
	if(document.FORM_NOTICES_COURTES!==null){
		
		var CountNotices = document.FORM_NOTICES_COURTES.elements.length;
			
		for (var i=0; i<CountNotices; i++) {
		
			var Elt = document.FORM_NOTICES_COURTES.elements[i];
			
			if (Elt.type === "checkbox") {
				sName = Elt.name;
				if (Elt.checked) {
					sUrl = sUrl + "&chk" + sName.substring(3) + "=on";
				} else {
					sUrl = sUrl + "&chk" + sName.substring(3) + "=off";
				}
			}
		}
	}
	window.location.href = sUrl + '&DISPLAYMENU='+displaymenu+'&'+sParamsTezo ;
}

function SelectOneNotice( iNotice, ldebut) {
	if (! bValiderFormulaire) {
		bValiderFormulaire = true;
		bDblClick = true;
		document.FORM_NOTICES_COURTES.elements['chk' + iNotice].checked = true;
		ValiderFormulaireShortNotice( 'NoticesDetaillees.asp?INSTANCE=' + sInstance + '&iNotice=' + iNotice + '&ldebut=' + lDebut);
	}
}

function ChangeRepartitionKey( objSelect ) {						
	var objSelect = document.FORM_NOTICES_COURTES.cboRepartitionKey;
	ValiderFormulaireShortNotice( url + '?STAXON=' + sTaxon + '&LTAXON=' + lTaxon  + '&REPARTITION=' + objSelect.options[objSelect.selectedIndex].value, false );
}
function ChangeSortKey( objSelect ) {						
	var objSelect = getElementById('cboSortKey');
	ValiderFormulaireShortNotice( url + '?STAXON=' + sTaxon + '&LTAXON=' + lTaxon  + '&INSTANCE=' + sInstance + '&TRI=' + objSelect.value, false );
}
function ChangeSortDirection( sDir ) {
	var objSelect = document.FORM_NOTICES_COURTES.cboSortKey;
	ValiderFormulaireShortNotice( url + '?STAXON=' + sTaxon + '&LTAXON=' + lTaxon + '&rdoSortDirection='+sDir+'&TRI=' + objSelect.options[objSelect.selectedIndex].value, false );
}
function DisplayToolHelp( sDiv, sText ) {
	var oDiv=document.getElementById(sDiv);
	oDiv.innerHTML = sText;
}

function HideToolHelp(sDiv) {
	var oDiv=document.getElementById(sDiv);
	oDiv.innerHTML = '';
}

function ClickOneTypedNotice( iNotice, lDebut, lexicon) {
	if (! bDblClick) {
		if (document.FORM_NOTICES_COURTES.elements['chk' + iNotice].checked === false) {
			if (sNavigator.toLowerCase() !== 'netscape') {
			}
			document.FORM_NOTICES_COURTES.elements['chk' + iNotice].checked = true;
		} else {
			if (sNavigator.toLowerCase() !== 'netscape') {
			}
			document.FORM_NOTICES_COURTES.elements['chk' + iNotice].checked = false;
		}
	} else {
		if (! bValiderFormulaire) {
			bValiderFormulaire = true;
			ValiderFormulaireShortNotice( 'NoticesDetaillees.asp?STAXON=' + lexicon + '&LTAXON=' + lTaxon + '&IDCAT=' + lexicon + '&ldebut=' + lDebut +'&INSTANCE=' + sInstance);
		}
	}
}

function ClickOneNotice( iNotice, lDebut ) {
	ClickOneTypedNotice( iNotice, lDebut, sTaxon);
}

function Navigate( lDebut ) {
	document.FORM_NOTICES_COURTES.action = 'NoticesCourtes.asp';
	document.FORM_NOTICES_COURTES.ldebut.value = lDebut;
	ValiderFormulaireShortNotice( 'NoticesCourtes.asp?STAXON=' + sTaxon + '&LTAXON=' + lTaxon + '&IDCAT=' + lIdCat + '&INSTANCE=' + sInstance + '&lDebut=' + lDebut);
}

function NavigateProgress( lDebut ) {
	document.FORM_NOTICES_COURTES.action = 'executerRechercheProgress.asp';
	document.FORM_NOTICES_COURTES.ldebut.value = lDebut;
	ValiderFormulaireShortNotice( 'executerRechercheProgress.asp?PORTAL_ID=' + sPortalId + '&STAXON=' + sTaxon + '&LTAXON=' + lTaxon + '&IDCAT=' + lIdCat + '&INSTANCE=' + sInstance + '&lDebut=' + lDebut);
}

function PutIntoBasket(sID) {

    /*JD correction mise en panier ... */
	/*
	if (sBasketMode == 'SQLMULTIPLE' && !bIsAnonymous) {
        AddIntoBasket();
    }
    else
	*/
	/*... JD */
    {
        var sName, bConfirm, sBackUrl;
        var nbAdded = 0;
        sBackUrl = thisurl;
        sUrl = 'common/sources/AddEltsIntoBasket.asp?INSTANCE=' + sInstance;
        for (var i = 0; i < document.FORM_NOTICES_COURTES.elements.length; i++) {
            if (document.FORM_NOTICES_COURTES.elements[i].type === "checkbox") {
                sName = document.FORM_NOTICES_COURTES.elements[i].name;
                if (document.FORM_NOTICES_COURTES.elements[i].checked) {
                    sUrl = sUrl + "&chk" + sName.substring(3) + "=on";
                    nbAdded++;
                } else {
                    sUrl = sUrl + "&chk" + sName.substring(3) + "=off";
                    nbAdded++;
                }
            }
        }
        var ifrm = document.getElementById('w_action');
        ifrm.src = sUrl + '&ID=' + sID;
    }
}

function AddIntoBasket() {
    var sList = '';

    for (var i = 0; i < document.FORM_NOTICES_COURTES.elements.length; i++) {
        if (document.FORM_NOTICES_COURTES.elements[i].type === "checkbox") {
            var sName = document.FORM_NOTICES_COURTES.elements[i].name;
            if (document.FORM_NOTICES_COURTES.elements[i].checked) {
                if (sName.substring(0, 3) == 'chk') {
                    if (sList != '') sList += ';';
                    sList += sName.substring(3);
                }
            }
        }
    }
    popups.get('popupBasket').putPropertyValue("title", "Ajouter au panier");
    popups.get('popupBasket').putPropertyValue("src", String.format("/clientBookline/recherche/common/sources/baskets/formAddBasket.asp?INSTANCE={0}&items={1}", sInstance, sList));
    popups.show('popupBasket', callbackAddIntoBasket);
}

function callbackAddIntoBasket(id, value) {
    if (value) {
    }
}

function Refresh() {
	window.location.replace('ExecuterRechercheProgress.asp?REFRESH=1&lDebut='+lDebut);
}	

function CheckAllItem(chk) {
	var oElems = document.FORM_NOTICES_COURTES.elements;
	var i;
	var CountElts = oElems.length;
	
	for (i=0;i<CountElts;i++) {
		if (oElems[i].type === 'checkbox'){
			oElems[i].checked = chk.checked;
		}							
	}
}

//////////////////////////////////////////////////////////////////////////
// GJ-20090116 : G?n?ration PDF (nouvelle mouture, via popup JSE)
function exportPdf() {
	var sType=$("input[name='pdf_rdoExport']:checked").val();	

	var nbAdded=0;
	sUrl='common/sources/exportNotices.asp?INSTANCE='+sInstance+'&d=1';
	
	var Formulaire = document.FORM_NOTICES_COURTES.elements;
	
	// Notices s?lectionn?es dans cette page
	for (i=0; i<Formulaire.length; i++) {
		if (Formulaire[i].type === "checkbox") {
			sName = Formulaire[i].name;
			if (Formulaire[i].checked) {
				if (nbAdded>=1) { 
					sUrl+='&';
				}
				
				sUrl = sUrl + "chk" + sName.substring(3) + "=on";
				nbAdded++;
			} else {
				if (nbAdded>=1) {
					sUrl+='&';
				}
				sUrl = sUrl + "chk" + sName.substring(3) + "=off";
				nbAdded++;
			}
		}
	}
	sUrl+="&TYPEEXPORT=6&SELECTION=" + sType;
	
	document.location.href=sUrl;
}
// GJ-20081203 : G?n?ration PDF
//////////////////////////////////////////////////////////////////////////

				
//////////////////////////////////////////////////////////////////////////
// GJ-20081218 : GESTION DES SELECTIONS SUR PLUSIEURS NOTICES A LA FOIS

function manageSelectionsRange(){
	// S?lection des checkboxes coch?es
	var range=$("form#FORM_NOTICES_COURTES input[rscuid]:checkbox:checked");
	
	if(range.length === 0) {
		$("form#FORM_NOTICES_COURTES input[rscuid]:checkbox").attr('checked',true);
		range=$("form#FORM_NOTICES_COURTES input[rscuid]:checkbox:checked");
	}
	
	var arrUids=[];
	
	range.each(function(i){
		arrUids[arrUids.length]=$(this).attr("rscuid");
	});
	
	var uids=arrUids.join(",");

	popups.get('popupSelections').putPropertyValue("title","Selections...");
	popups.get('popupSelections').putPropertyValue("src",String.format("/medias/selections.aspx?INSTANCE={0}&RSC_UID={1}", sInstance, uids));
	popups.show('popupSelections',callbackSelections);
}

// GJ-20081218 : GESTION DES SELECTIONS SUR PLUSIEURS NOTICES A LA FOIS
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// Ajout pour la version 2.6 

// Action d?doublonner
function Dedoublonner() {
	window.location.href='executerRecherche.asp?IDCAT=' + lIdCat + '&DEDOUBLONNER=TRUE&INSTANCE=' + sInstance+ '&STAXON='+sTaxon+ '&LTAXON='+lTaxon;
}

function SaveMDSISubscription() {
	document.BKL_MDSI_FORM.submit();
}

// [EOF] for file bklshortnotice.js

// file: bookline.js

function PutSearchIntoBasket() {

	var sUrl;

	//VP:on catche le libelle vide
	if (document.getElementById("LIBELLE_SEARCH").value === '') {
		alert(nosearchlabel);
	} else {		
		sBackUrl = thisurl;
		sUrl='/clientbookline/recherche/common/sources/AddEltsIntoBasket.asp?INSTANCE='+sInstance;
		var ifrm = document.getElementById('w_action');
		ifrm.src = sUrl + '&SEARCH=TRUE&LIBELLE_SEARCH=' + escapeU(document.getElementById("LIBELLE_SEARCH").value);
	}
}

function SelectAll(sBackUrl) {		
	window.location.href = 'common/sources/selection.asp?ACT=SELECT&BACKURL=' + escape(sBackUrl);
}

function DeselectAll(sBackUrl) {
	window.location.href = 'common/sources/selection.asp?ACT=DESELECT&BACKURL=' + escape(sBackUrl);
}

function ShowHideOptions(oRdo, strIdOp) {
	var myOps = document.getElementById(strIdOp);		
	var myOpButton = document.getElementById('OPTIONS_VALIDER');		
	if (currentOps !== '') {
		currentOps.style.display = "none";
		myOpButton.style.display = "none";
	}
	myOpButton.style.display = "";
	if (strIdOp !== '') {
		if (oRdo.checked) {
			myOps.style.display = "";
			currentOps = myOps;
		}
	}
}

function actionAddSubscription() {
}

function actionAddPublicSubscription() {
}

function AddSubscription() {
	popups.get('addSubscription').putPropertyValue('src',"../mdsi/addSubscription.asp?INSTANCE="+sInstance);
	popups.show('addSubscription',actionAddSubscription);
}

function AddPublicSubscription() {
	popups.get('addPublicSubscription').putPropertyValue('src',"../mdsi/addPublicSubscription.asp?INSTANCE="+sInstance);
	popups.show('addPublicSubscription',actionAddPublicSubscription);
}

function manageSelections(sRscUid) {
	popups.get('popupSelections').putPropertyValue('title','Selections...');
	popups.get('popupSelections').putPropertyValue('src','/medias/selections.aspx?INSTANCE=' + sInstance + '&RSC_UID=' + sRscUid);
	popups.show('popupSelections',callbackSelections);
}

function callbackSelections(id,value) {
}

// Deplier/replier une boite deployable
function BKLDeployBox(strId) {
	var obj = document.getElementById(strId);

	var img2 = document.getElementById("img_repliable_" + strId);
	if (obj.style.display === '' || obj.style.display === 'inline') {
		obj.style.display = 'none';
		img2.src = '/clientBookline/images/content/deplier.gif';		
		img2.title = 'D?plier';
	} else {
		obj.style.display = '';
		img2.src = '/clientBookline/images/content/replier.gif';		
		img2.title = 'Replier';
	}
}
// Ouvrir un popup
function OpenPopup_backup(oRdo,strIdOp) {
alert(top.document.body.clientHeight);

	var oDiv = getElementById(strIdOp);


	//GJ-20070129 : MAJ pour pb affichage des popups
	//document.body.insertBefore(oDiv,document.body.lastChild);

	if(!oDiv.first)	{
		oDiv.first = true;
		document.body.insertBefore(oDiv,document.body.lastChild);
	}

	oDiv.style.display="inline";
	if (typeof(oRdo) === 'string') {
		oDiv.style.left=window.event.clientX-oDiv.clientWidth;
		oDiv.style.top=window.event.clientY;
	} else {
		
		oDiv.style.left=(document.body.clientWidth-oDiv.clientWidth)/2;
		oDiv.style.top=(document.body.clientHeight-oDiv.clientHeight)/2;
	}
}

// Ouvrir un popup
function OpenPopup(oRdo,strIdOp) {

	var oDiv = getElementById(strIdOp);
	
	if(!oDiv.first)	{
		oDiv.first = true;
		document.body.insertBefore(oDiv,document.body.lastChild);
	}

	oDiv.style.display="inline";
	
	// Patch : le centrage ne fonctionne pas dans une iFrame. On utilise alors de valeurs statiques (100 pixels)
	if(top.document!=document){
		oDiv.style.left="100px";
		oDiv.style.top="100px";
		
		return;
	}
	
	
	if (typeof(oRdo) === 'string') {
		oDiv.style.left=window.event.clientX-oDiv.clientWidth;
		oDiv.style.top=window.event.clientY;
	} else {
		
		oDiv.style.left=(document.body.clientWidth-oDiv.clientWidth)/2;
		oDiv.style.top=(document.body.clientHeight-oDiv.clientHeight)/2;
	}
}


function actionAfter(id,value)
{
	if(value) {
		alert('OK');
	}
}
// Fermer un popup
function ClosePopup(strIdOp) {
	var oDiv = getElementById(strIdOp);
	oDiv.style.display="none";
}
// Affichage du libell? associ? ? un bouton
function HighlightButtonLabel( sLabel, sIdLabel ) {
	var oSpan = document.getElementById(sIdLabel);
	oSpan.innerHTML = sLabel;
}
// Effacement du libell? associ? ? un bouton
function HideButtonLabel( sIdLabel ) {
	var oSpan = document.getElementById(sIdLabel);
	oSpan.innerHTML = '';
}


// [EOF] for file bookline.js

// file: vubis.js


//20090630-CODE SPECIFIQUE VUBIS : D?but
			
// Cette fonction permet de g?rer la recherche par autorit? VUBIS
function searchAuth(startPage) {   


	// Si aucune valeur n'a ?t? saisie
	if (document.FORMULAIRE.authorityTextBox.value === '') {
		alert('Veuillez saisir un terme de recherche');
		return;
	}
	
	// gif recherche en cours
	var contentDiv;
	if (startPage > 1) {
		contentDiv = '<div id="zoneAffichageLoading">';
		contentDiv += '<span style="font-weight: bold;margin-right:0px">Recherche en cours ... <img src="../../../Skins/Exploitation/images/integration/vubis/loading.gif" alt="Recherche en cours"/>';
		contentDiv += '</div>';
		contentDiv += document.getElementById('AuthBox').innerHTML;
	}
	else {
		contentDiv = '<div style="position:absolute;z-index:1;left:400px;">';
		contentDiv += '<span style="font-weight: bold;left:400px">Recherche en cours ... <img src="../../../Skins/Exploitation/images/integration/vubis/loading.gif" alt="Recherche en cours"/></span>';
		contentDiv += '</div>';
	}
	
	document.getElementById('AuthBox').innerHTML = contentDiv;
	document.getElementById('AuthBox').style.height='600px';         

	// Instancie une XMLHTTPRequest compatible multi navigateur
	
	var xhrVubis = null;
	
  if(window.XMLHttpRequest) // Firefox et autres
	xhrVubis = new XMLHttpRequest();
  else if(window.ActiveXObject){ // Internet Explorer
	try {
	  xhrVubis = new ActiveXObject("Msxml2.XMLHTTP");
	  } catch (e) {
		xhrVubis = new ActiveXObject("Microsoft.XMLHTTP");
	  }
	}
	else { // XMLHttpRequest non support? par le navigateur
	  alert("Votre navigateur ne supporte pas les objets XMLHTTPRequest...");
	  xhrVubis = false;
  }
	
	
	
	// Lorsque la requete est finie, faire ceci
	xhrVubis.onreadystatechange = function() {
		if(xhrVubis.readyState == 4) {
				var xmlString = xhrVubis.responseText;
				var xmlDoc;
				var IsIE = true;
				if (window.ActiveXObject) { // Internet Explorer
					xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
					xmlDoc.async = "false";
					xmlDoc.loadXML(xmlString);
				} 
				else { // Firefox
					IsIE = false;
					xmlDoc = new DOMParser().parseFromString(xmlString,"text/xml");
					// d?finit les m?thodes selectSingleNode et selectNodes
					XMLDocument.prototype.selectSingleNode = function(sXPath) {                                   
						var xPathResult = this.evaluate(sXPath, this,this.createNSResolver(this.documentElement), 9, null);
						if (xPathResult.singleNodeValue){  
							return xPathResult.singleNodeValue;
						}
						return (new DOMParser()).parseFromString("<empty/>","text/xml").documentElement;
					}
						
					XMLDocument.prototype.selectNodes = function(xpath) {
						var doc = this;
						if (doc.nodeType != 9) {
							doc = doc.ownerDocument;
						}
						if (doc.nsResolver === null) {
							doc.nsResolver = function(prefix) { return(null); };
						}
						var result = doc.evaluate(xpath, this, doc.nsResolver, XPathResult.ANY_TYPE, null);
						var nodes = [], i;
						while(i = result.iterateNext()) {
							nodes.push(i);
						}
						return(nodes);
					}
					
					Element.prototype.selectSingleNode = function(sXPath) {
						var xmlDoc = (new DOMParser()).parseFromString("<root>" + this.xml+ "</root>", 'text/xml');
						var xPathResult = xmlDoc.evaluate(sXPath, xmlDoc,xmlDoc.createNSResolver(xmlDoc.documentElement), 9, null);
						if (xPathResult.singleNodeValue) {
							return xPathResult.singleNodeValue;
						}
						return (new DOMParser()).parseFromString("<empty/>","text/xml").documentElement;
					}
				}

				var node;
				// si IE
				if (IsIE) {
					node = xmlDoc.selectSingleNode('/searchRetrieveResponse/numberOfRecords');
				}
				else { // si Firefox
					node = xmlDoc.selectSingleNode('/*[local-name()=\'searchRetrieveResponse\' and namespace-uri()=\'http://www.loc.gov/zing/srw/\']/*[local-name()=\'numberOfRecords\' and namespace-uri()=\'http://www.loc.gov/zing/srw/\']');                                  
				}

				var nbres = node.firstChild.nodeValue;

				if (nbres === 0) {
					var contentDivLoading = '<span>Il n\'y a pas de r&eacute;f&eacute;rence correspondant ? votre recherche.</span>';
					document.getElementById('AuthBox').innerHTML = contentDivLoading;
					document.getElementById('AuthBox').style.display='block';
				}
				else {
					var ResultList;
					// si IE
					if (IsIE) {
						ResultList = xmlDoc.selectNodes('searchRetrieveResponse/records/record/recordData/Entry');
					}
					else { // Firefox
						ResultList = xmlDoc.selectNodes('/*[local-name()=\'searchRetrieveResponse\' and namespace-uri()=\'http://www.loc.gov/zing/srw/\']/*[local-name()=\'records\' and namespace-uri()=\'http://www.loc.gov/zing/srw/\']/*[local-name()=\'record\' and namespace-uri()=\'http://www.loc.gov/zing/srw/\']/*[local-name()=\'recordData\' and namespace-uri()=\'http://www.loc.gov/zing/srw/\']/Entry');
					}
					var contentDivLoad;

					// **************************************************************
					// *****			Affichage nomre de r?sultats			*****
					// **************************************************************
					contentDivLoad = '<div id="zoneAffichageResultat">';
					contentDivLoad += '<p>' + nbres + ' r?sultat(s) correspondent ? votre recherche.</p><br/>';
					
					// ******************************************************
					// ******			Gestion pagination				*****
					// ******************************************************
					contentDivLoad += '<table>';
					contentDivLoad += '<tr>';
					contentDivLoad += '<td align="left">';
					contentDivLoad += '<td>';
					contentDivLoad += '<img onClick="LoadPreviousPage('+startPage+', ' + nbres + ')" alt="Page pr?cedente" border="0" src="../../../Skins/Exploitation/images/general/icons-action/previous-off.gif" align="absmiddle"/> ';
					contentDivLoad += '</td>';
					contentDivLoad += '<td class="PAGINATIONBOX">';
					contentDivLoad += '<span class="FIELDLABEL">Page </span>';
					var nombreDePage = 1;
					if (nbres > 10) {
						nombreDePage = (nbres/10)|0;
						if ((nombreDePage*10) < (nbres)){
							nombreDePage ++;
						}
					}
					contentDivLoad += '<span class="FIELDLABEL">'+startPage+'/'+nombreDePage+'</span>';
					contentDivLoad += '</td>';
					contentDivLoad += '<td>';
					contentDivLoad += '<img onClick="LoadNextPage('+startPage+', ' + nbres + ')" alt="Page Suivante" border="0" src="../../../Skins/Exploitation/images/general/icons-action/next.gif" align="absmiddle"/>';
					contentDivLoad += '</td>';
					contentDivLoad += '</td>';
					contentDivLoad += '</tr>';
					contentDivLoad += '</table>';
						 
					// **************************************************
					// *****			Tableau de r?sultats		*****
					// **************************************************
					contentDivLoad += '<table id="authorityTable">';      
					contentDivLoad += '<tr><th colspan="2" id="authorityTitre">R?sultats</th></tr>';
					for (var i= 0; i < ResultList.length ; i++) {                    
						var authority = '&#160;';
						autority=' ';
						var authoritydb = '&#160;';
						var authorityrecord = '&#160;';      
						var formesretenues= '';
						var formesrejetees= '';
						var formesorientation='';
						// il faut parcourir les nodes
						for (var j = 0 ; j < ResultList[i].childNodes.length ; j++) {
							if (ResultList[i].childNodes[j].tagName !== null) {
								if (ResultList[i].childNodes[j].tagName == "Authority") {                                                               
									if (ResultList[i].childNodes[j].firstChild !== null) {
										authority = ResultList[i].childNodes[j].firstChild.nodeValue;
									}
								}     
								else if (ResultList[i].childNodes[j].tagName == "AuthorityDb") {
									if (ResultList[i].childNodes[j].firstChild !== null) {
										authoritydb = ResultList[i].childNodes[j].firstChild.nodeValue;
									}
								}
								else if (ResultList[i].childNodes[j].tagName == "AuthorityRecord") {
									if (ResultList[i].childNodes[j].firstChild !== null) {
										authorityrecord = ResultList[i].childNodes[j].firstChild.nodeValue;
									}
								}
								else if (ResultList[i].childNodes[j].tagName == "SeeEntry") {
										if (ResultList[i].childNodes[j].firstChild !== null) {
										var SeeEntryReference='';
										var SeeEntryuthorityFromDb='';
										var SeeEntryAuthorityFromRecord='';
										for (var n = 0 ; n < ResultList[i].childNodes[j].childNodes.length ; n++) {
											if (ResultList[i].childNodes[j].childNodes[n].tagName == 'Reference') {
												if (ResultList[i].childNodes[j].childNodes[n].firstChild !== null) {
													SeeEntryReference = ResultList[i].childNodes[j].childNodes[n].firstChild.nodeValue;
												}
											}     
											else if (ResultList[i].childNodes[j].childNodes[n].tagName == 'AuthorityFromDb') {
												if (ResultList[i].childNodes[j].childNodes[n].firstChild !== null) {
													SeeEntryAuthorityFromDb = ResultList[i].childNodes[j].childNodes[n].firstChild.nodeValue;
												}
											}
											else if (ResultList[i].childNodes[j].childNodes[n].tagName == 'AuthorityFromRecord') {
												if (ResultList[i].childNodes[j].childNodes[n].firstChild !== null) {
													sSeeEntryAuthorityFromRecord = ResultList[i].childNodes[j].childNodes[n].firstChild.nodeValue;
												}
											}				
											//authorityrecord = ResultList[i].childNodes[j].firstChild.nodeValue;
										}
										formesretenues += '<tr class="ligne_auth" title="'+labelLaunchSearch+'" alt="'+labelLaunchSearch+'" onClick="searchIt('+SeeEntryAuthorityFromDb+', '+sSeeEntryAuthorityFromRecord+')">';
										formesretenues += '<td width="98%"><a href="#">' + labelseethe + ' ' + SeeEntryReference + '</a></td>';
										formesretenues += '</tr>';
									}
								}
								else if (ResultList[i].childNodes[j].tagName == "SeeAlsoEntry") {
									if (ResultList[i].childNodes[j].firstChild !== null) {
										var seealsoReference='';
										var seealsoAuthorityFromDb='';
										var seealsoAuthorityFromRecord='';
										for (var n = 0 ; n < ResultList[i].childNodes[j].childNodes.length ; n++) {
											if (ResultList[i].childNodes[j].childNodes[n].tagName == 'Reference') {
												if (ResultList[i].childNodes[j].childNodes[n].firstChild !== null) {
													seealsoReference = ResultList[i].childNodes[j].childNodes[n].firstChild.nodeValue;
												}
											}     
											else if (ResultList[i].childNodes[j].childNodes[n].tagName == 'AuthorityFromDb') {
												if (ResultList[i].childNodes[j].childNodes[n].firstChild !== null) {
													seealsoAuthorityFromDb = ResultList[i].childNodes[j].childNodes[n].firstChild.nodeValue;
												}
											}
											else if (ResultList[i].childNodes[j].childNodes[n].tagName == 'AuthorityFromRecord') {
												if (ResultList[i].childNodes[j].childNodes[n].firstChild !== null) {
														seealsoAuthorityFromRecord = ResultList[i].childNodes[j].childNodes[n].firstChild.nodeValue;
												}
											}				
											//authorityrecord = ResultList[i].childNodes[j].firstChild.nodeValue;
										}
										formesorientation += '<tr class="ligne_auth" title="'+labelLaunchSearch+'" alt="'+labelLaunchSearch+'" onClick="searchIt('+seealsoAuthorityFromDb+', '+seealsoAuthorityFromRecord+')">';
										formesorientation += '<td width="98%"><a href="#">' + labelseealso + ' ' + seealsoReference + '</a></td>';
										formesorientation += '</tr>';
										//alert(formesorientation);
									}
								}
								else if (isAdmin==true && ResultList[i].childNodes[j].tagName == "SeeFromEntry") {
									if (ResultList[i].childNodes[j].firstChild !== null) {
										var seeFromReference='';
										var seeFromAuthorityFromDb='';
										var seeFromAuthorityFromRecord='';
										
										for (var n = 0 ; n < ResultList[i].childNodes[j].childNodes.length ; n++) {
											if (ResultList[i].childNodes[j].childNodes[n].tagName == 'Reference') {
												if (ResultList[i].childNodes[j].childNodes[n].firstChild !== null) {
													seeFromReference = ResultList[i].childNodes[j].childNodes[n].firstChild.nodeValue;
												}
											}     
											else if (ResultList[i].childNodes[j].childNodes[n].tagName == 'AuthorityFromDb') {
												if (ResultList[i].childNodes[j].childNodes[n].firstChild !== null) {
														seeFromAuthorityFromDb = ResultList[i].childNodes[j].childNodes[n].firstChild.nodeValue;
												}
											}
											else if (ResultList[i].childNodes[j].childNodes[n].tagName == 'AuthorityFromRecord') {
												if (ResultList[i].childNodes[j].childNodes[n].firstChild !== null) {
														seeFromAuthorityFromRecord = ResultList[i].childNodes[j].childNodes[n].firstChild.nodeValue;
												}
											}				
											//authorityrecord = ResultList[i].childNodes[j].firstChild.nodeValue;
										}
										formesorientation += '<tr class="ligne_auth" title="'+labelLaunchSearch+'" alt="'+labelLaunchSearch+'" onClick="searchIt('+seeFromAuthorityFromDb+', '+seeFromAuthorityFromRecord+')">';
										formesorientation += '<td width="98%"><a href="#">' + labelseefrom +' '+ seeFromReference + '</a></td>';
										formesorientation += '</tr>';
										//alert(formesorientation);
									}
								}
							}
						}
						contentDivLoad += '<tr>';
						contentDivLoad += '<td id="ligneAuth">';
						contentDivLoad += '<table id="ligneTable">';
						// S'il y a des formes retenues, alors l'autorit? n'est pas cliquable
						if (formesretenues == '') {
							contentDivLoad += '<tr class="ligne_auth" title="'+labelLaunchSearch+'" alt="'+labelLaunchSearch+'" id="auth' + i + '" onClick="searchIt('+authoritydb+', '+authorityrecord+')"><td id="ligneAuth"><a href="#">';
						}
						else {
							contentDivLoad += '<tr class="ligneRejetee"><td> ';                
						}
						contentDivLoad += '<img src="../../../Skins/Exploitation/images/integration/vubis/arrow_auth_vubis.GIF" alt="Voir les r?sultats correspondants"/>';                                            
						//if ((authority === null) || (authority.trim() === "")) {
						if ((authority === null) || (authority === "") || (authority === " ")) {
							authority = '&#160;';
						}
						contentDivLoad += authority;
						if (formesretenues == '') {
							contentDivLoad += '</a></td>';
						}
						else
						{
							contentDivLoad += '</td>';				
						}         
						//contentDivLoad += '<td><img src="../../../Skins/Exploitation/images/integration/vubis/arrow_auth_vubis.GIF" alt="Voir les r?sultats correspondants"/></td>';
						//contentDivLoad += '</td>';
						contentDivLoad += '</tr>';
						if (formesretenues !== '') {
							contentDivLoad += '<tr><td colspan="2"><table>' + formesretenues + '</table></td></tr>';
						}
						if (formesrejetees !== '') {
							contentDivLoad += '<tr><td colspan="2"><table>' + formesrejetees + '</table></td></tr>';
						}
						contentDivLoad += '<tr><td colspan="2"><table>' +formesorientation + '</table></td></tr>';
						contentDivLoad += '</table>';
					}
					contentDivLoad += '</table>';
					contentDivLoad += '<br/>';
					contentDivLoad += '<p>Cliquez sur l\'un des r&eacute;sultats pour afficher les notices correspondantes</p>';
					contentDivLoad += '</div>';
					document.getElementById('AuthBox').innerHTML = contentDivLoad;
					document.getElementById('AuthBox').style.height='600px';
					//document.getElementById('AuthBox').style.display='block';
				}
			}
		}
		if (document.FORMULAIRE.authorityTextBox.value !== '') {
			var startRecord = (startPage-1) * 10 + 1;
			var authorityTextBox = document.FORMULAIRE.authorityTextBox.value;
			var index = document.FORMULAIRE.authindex.value;
			var baseName = document.FORMULAIRE.authbase.value;
			xhrVubis.open("GET","/VubisAuth/sara.srwu?operation=searchRetrieve&version=1.1&query="+index+"+%3d+%22"+escapeU(authorityTextBox)+"%22+and+base+%3d+"+baseName+"&recordSchema=DC&recordPacking=xml&maximumRecords=10&startRecord="+startRecord+"&resultSetTTL=100", true); 
			xhrVubis.send(null);
		}
	}

// Cette fonction permet de paginer vers l avant dans l affichage des autorit?s VUBIS
function LoadNextPage(pageEnCours, nbres) {
	// On r?cup?re la page en cours
	var isThereOtherResult = null;
	if ((pageEnCours * 10) < nbres) {
		 isThereOtherResult = true;
	}
	else {
		 isThereOtherResult = false;
	}
	if (isThereOtherResult) {
		 searchAuth(pageEnCours+1);
	}
	else {

		alert('Il n\'y a plus de r?sultats');
	}
}

// Cette fonction permet de paginer vers l arri?re dans l affichage des autorit?s VUBIS
function LoadPreviousPage(pageEnCours, nbres) {
	// On r?cup?re la page en cours
	var isThereOtherResult = null;
	if (pageEnCours == 1) {
		 isThereOtherResult = false;
	}
	else {
		 isThereOtherResult = true;
	}
	if (isThereOtherResult) {
		 searchAuth(pageEnCours-1);
	}
	else {
		alert('Il n\'y a plus de r?sultats');
	}
}


// Cette fonction permet de lancer la recherche classique depuis une liste d autorit?s VUBIS
function searchIt(authoritydb, authorityrecord) {                                  
	if ((authoritydb !== "") && (authorityrecord !== ""))
	{         
		document.FORMULAIRE.txtINDEX_BASE.value = document.FORMULAIRE.authbase.value;
		document.FORMULAIRE.txtINDEX_AUTHORITYDB.value = authoritydb;
		document.FORMULAIRE.txtINDEX_AUTHORITYRECORD.value = authorityrecord;
		document.FORMULAIRE.action='/ClientBookline/toolkit/p_requests/ProcessSearch.asp';
		 Valider("");
	}
	else
	{
		// alert('Il manque des infos');
	}
}
//20090630-CODE SPECIFIQUE VUBIS : Fin

// [EOF] for file vubis.js

// file: bklStats.js

String.prototype.beginsWith = function(t, i) { 
	if (i==false) { return(t == this.substring(0, t.length)); } 
	else { return (t.toLowerCase() == this.substring(0, t.length).toLowerCase()); } 
}

String.prototype.endsWith = function(t, i) { 
	if (i==false) { return (t == this.substring(this.length - t.length)); } 
	else { return (t.toLowerCase() == this.substring(this.length - t.length).toLowerCase()); } 
} 

// Appel la page de stats BKL
function AddActionStats(s_CodeBase, s_DocId, s_Operation, s_Title, s_Creator, s_DocType, s_OpenFindRscUid)
{
	$.post(
		"/clientbookline/recherche/actionStats.asp", 
		{
			s_codebase 	: s_CodeBase, 
			s_docid 		: s_DocId, 
			s_operation : s_Operation, 
			s_title 		: s_Title, 
			s_creator 	: s_Creator, 
			s_doctype 	: s_DocType,
			s_rsc_uid 	: s_OpenFindRscUid
		}
	);
}

$(document).ready(function() {
	$('a.stsbkl', $('div#ZoneNotice')).click(function() {
		var array = $(this).attr('class').split(' ');
		
		$.each(array, function(item, val) {
			if (val.beginsWith('stsbkl_'))
			{
				AddActionStats(sCodeBase, sDocId, val.substr(7), sTitle, sCreator, sDocType, sRscUid)
				return;
			}
		});
	});	
});

// [EOF] for file bklStats.js

// file: holdings.js

function safeJSPortal_resize(){
	try{
		JSPortal_resize(null);
	}
	catch(e)
	{
		//Nothing
	}
}
	
$(window).load(function(){
	// R?servation depuis l'affichage des exemplaires
	var links=$("table.holdings a.holdingResaLink");
	links.click(function(){
		var ifdUrl=$(this).attr("name");
		var originElement=$(this);
		
		$.getJSON(ifdUrl, function(data, textStatus){
			ajaxHoldinsCallback(data, textStatus, originElement);
		});
		
		return false;
	});
	
	// Annulation de r?servation ajax (pour infodoc)
	links=$("div.dossierlecteur_box a.dossierlecteur_cancel_holding.infodoc");
	links.unbind("click");
	links.click(function(){
		var ifdUrl=$(this).attr("name");
		var originElement=$(this);
		
		$.getJSON(ifdUrl, function(data, textStatus){
			if(!data.success){
				var myPopup=popups.get("error");
				myPopup.putPropertyValue("height", "50px");
				myPopup.putPropertyValue("message",sWmlBOOKING_REMOVAL_FAILED + ".<p/><p/><em>" + data.errors[0].msg + "</em>");
				popups.show("error");
			}
			else{
				originElement.parents("div.dossierlecteur_box").slideUp(200, function(){$(this).remove();});
			}
		});

		return false;
	});
	
	// prolongation de pr?t ajax (pour infodoc)
	links=$("div.dossierlecteur_box a.dossierlecteur_renew_loan.infodoc");
	links.unbind("click");
	links.click(function(){
		var ifdUrl=$(this).attr("name");
		var originElement=$(this);
		
		$.getJSON(ifdUrl, function(data, textStatus){
			if(!data.success){
				var myPopup=popups.get("error");
				myPopup.putPropertyValue("height", "50px");
				myPopup.putPropertyValue("message",sWmlRENEW_FAILED + ".<p/><p/><em>" + data.errors[0].msg + "</em>");
				popups.show("error");
			}
			else{
				window.location.reload(true);
			}
		});

		return false;		
	});
	
	//D?ploiement des notes
	links=$("a.infodoc_holdings_show_note");
	links.unbind("click");
	links.click(function(){
		$("div.infodoc_holdings_notes_div", "table.holdings").slideToggle(200, function(){safeJSPortal_resize();});
		return false;		
	});	
	
	$("a.infodoc_holdings_notes_toggle", "table.holdings").click(function(){
		$("a.infodoc_holdings_notes_toggle").toggle();
		$(this).parents("tr").next("tr").find("div.infodoc_holdings_notes_div").slideToggle(100, function(){safeJSPortal_resize();});
		return false;
	});
});

function ajaxHoldinsCallback(data, textStatus, originElement){
	if(data.success){
		var myPopup=popups.get("done");
		myPopup.putPropertyValue("height", "50px");
		myPopup.putPropertyValue("message",sWmlBOOKING_SUCCEEDED);
		popups.show("done");

		originElement.removeAttr("href");
		originElement.unbind("click");
		originElement.fadeTo(100, 0.5);
	}
	else{
		var myPopup=popups.get("error");
		myPopup.putPropertyValue("height", "50px");
		myPopup.putPropertyValue("message",sWmlBOOKING_FAILED + "<p/><p/><em>" + data.errors[0].msg + "</em>");
		popups.show("error");
	}
	
};

// [EOF] for file holdings.js

//package loaded!
packages.complete('BOOKLINE_ALL');

// Served in 676 ms