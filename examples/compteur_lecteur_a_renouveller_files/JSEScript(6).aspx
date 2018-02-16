// Package DOMCORE / Copyright 2018 Archimed SA / JSE

//loading package...
packages.acknowledge('DOMCORE');

// file: TOOLS.js

// DOMCore - Tools - v1.1.3 - mailto:c.chevalier@archimed.fr - Copyright (c) 2000-2003 Archimed SA
// (voir le fichier CHANGELOG pour l'historique)

function Implements(a,b) 
{ 
	for(var meth in b.prototype) 
		a.prototype[meth] = b.prototype[meth];
	if (a.prototype.Implements==null) 
		a.prototype.Implements=objecttypename(b);
	else 
		a.prototype.Implements+=','+objecttypename(b);
}
function Includes(a,b) { 
	var prefix = b.prototype.prefix; 
	for(var meth in b.prototype) { 
		if (typeof(b.prototype[meth])=='function')
		{
			a.prototype['ui_'+prefix+'_'+meth]=b.prototype[meth];
		}
	}
}
function objecttypename(obj) { var t=obj.toString(); return t.substring(t.indexOf(' ')+1,t.indexOf('('));}
function objecttype(obj) { if (!obj) return 'null'; if (typeof(obj)=='object') { var t=obj.constructor.toString(); return t.substring(t.indexOf(' ')+1,t.indexOf('('));} else return typeof(obj); }
function objectvalue(obj)
{
	if (obj==null) return 'null';
	if (typeof(obj)=='function') return '[*]';
	if (typeof(obj)=='object') return obj.toString();
	if (typeof(obj)=='string') return '"'+obj+'"';
	return ''+obj; 
}
function objectprototype(obj)
{
	var s='Object '+objecttypename(obj)+' implements '+obj.prototype.Implements+' {\n';
	for(var meth in obj.prototype)
	{
		if (typeof(obj.prototype[meth])=='function')
			s+='  '+meth+'\n';
	}
	return s+'}';
}
function dumpObject(obj)
{
	var s='';
	for(var prop in obj)
	{
			var o = obj[prop];
			if (typeof(o)=='number')	s+=prop+'('+o+'), ';
	}
	return s+'\n}';
}

function RuntimeError(objSrc,code,msg,desc,objErr)
{
	alert('Error '+code+': '+msg+'\nDesc: '+desc+'\nObjet Src: '+((objSrc!=null)?objSrc.toString():null)+'\nObjet Err: '+((objErr!=null)?objErr.toString():'null'));
}

// Hashtable
function Hashtable() {}
with(Hashtable)
{
	prototype.keys = null;
	prototype.length=0;	

	// retourne la idxi?me valeur de la map
	prototype.item = function(idx)
	{
		return this['v_'+this.keys[idx]]; //eval('this.v_'+this.keys[idx]);
	}

	// ajoute une paire dans la map
	prototype.insert = function(id,value)
	{
		if (!this.keys) this.keys=new Array();
		this.keys[this.keys.length]=id;
		this.length++;
		return this['v_'+id]=value; //;eval('this.v_'+id+' = value;');
	}
	// modifie une paire dans la map (deja existante)
	prototype.put = function(id,value)
	{
		return this['v_'+id]=value; //eval('this.v_'+id+' = value;');
	}
	// retourne la valeur d'une paire
	prototype.get = function(id)
	{
		return this['v_'+id]; //eval('this.v_'+id);
	}
	// retourne une ?numeration des keys de la map
	prototype._enumKeys = function()
	{
		if (!this.keys) return null;
		return new Enumeration(this.keys);
	}
	// indique l'existance d'une cl? (-1: none, sinon idx)
	prototype.exists = function(id)
	{
		if (!this.keys) return -1;
		// y a pas de 'contains' rapide dans les array! :(
		for(var i=0;i<this.keys.length;i++)
			if (this.keys[i]==id) return i;
		return -1;
	}
	// indique l'existance d'une valeur (-1: none, sinon idx)
	prototype.contains = function(value)
	{
		if (!this.keys) return -1;
		// c'est relativement lent
		for(var i=0;i<this.keys.length;i++)
			if (this['v_'+this.keys[i]]==value) return i;
		return -1;
	}	
}


function BenchObject(a)
{
	for(var meth in a.prototype)
	{
		if (typeof(a.prototype[meth])=='function')
		{
			if (meth.toString().substring(0,7)!='_bench_')
			{
				// map old function
				BenchFunction(a,meth);
			}
		}
	}
}

function BenchFunction(a,meth)
{
	var obj=a.toString();
	obj = obj.substring(obj.indexOf(' ')+1,obj.indexOf('('));

	a.prototype['_bench_'+meth] = a.prototype[meth];
	// create handler
	a.prototype['_bench_results_count_'+meth]=0;
	a.prototype['_bench_results_time_'+meth]=0;
	var fct = 'function() { var _bench_n='+obj+'.prototype._bench_results_count_'+meth+'++;var prm;for(var i=0,prm=\'\';i<arguments.length;i++) prm+=\',arguments[\'+i+\']\';var _bench_t=new Date(); var ret=eval(\'this._bench_'+meth+'(\'+prm.substring(1)+\')\'); var tp=(new Date()-_bench_t); '+obj+'.prototype._bench_results_time_'+meth+'+=tp; return ret; }';
	eval('a.prototype.'+meth+' = '+fct);
}
function ExtractBenchResults(a)
{
	var res=[];
	for(var meth in a.prototype)
	{
		if (meth.charAt(0)!='_')
		if (typeof(a.prototype[meth])=='function')
		{
			res[res.length]=[meth,a.prototype['_bench_results_count_'+meth],a.prototype['_bench_results_time_'+meth]];
		}	
	}
	return res;
}


function DebugObject(a)
{
	for(var meth in a.prototype)
	{
		if (typeof(a.prototype[meth])=='function')
		{
			if (meth.toString().substring(0,7)!='_debug_')
			{
				// map old function
				DebugFunction(a,meth);
			}
		}
	}
}
function DebugFunction(a,meth)
{
	var obj=a.toString();
	obj = obj.substring(obj.indexOf(' ')+1,obj.indexOf('('));

	a.prototype['_debug_'+meth] = a.prototype[meth];
	// create handler
	var fct = 'function() { TraceStart(\''+obj+'\',\''+meth+'\',this,arguments);var prm;for(var i=0,prm=\'\';i<arguments.length;i++) prm+=\',arguments[\'+i+\']\'; var ret=eval(\'this._debug_'+meth+'(\'+prm.substring(1)+\')\'); TraceStop(\''+obj+'\',\''+meth+'\',this,ret); return ret; }';
	eval('a.prototype.'+meth+' = '+fct);
}

var traceLogCurrent=0;
var traceLog = new Array(100);
var traceLogSize=100;
var traceLogHasChanged=false;
var traceLogStackDepth=-1;
var traceLogStack = new Array(100);

function TraceLog(msg,color)
{
	InitTraceConsole();
	if (color==null) color='black';
	traceLog[traceLogCurrent++]=TraceDepth()+msg;
	if (traceLogCurrent>=traceLogSize)
	{ // resize log
		traceLogSize+=100;
		traceLog[traceLogSize-1]=null;
	}
	traceLogHasChanged=true;

	getElementById('traceConsole').style.display='';
	if (JSisIE)
	{
	getElementById('traceConsoleInside').insertAdjacentHTML('beforeend','<nobr style="color:'+color+'">'+traceLog[traceLogCurrent-1]+'</nobr><br>');
	getElementById('scrolleu').scrollIntoView();
	}
	else
		getElementById('traceConsoleInside').innerHTML+='<nobr style="color:'+color+'">'+traceLog[traceLogCurrent-1]+'</nobr><br>';
	
}

function InitTraceConsole()
{
    if(!getElementById('traceConsole'))
        document.write('<div id="traceConsole" style="z-index:666;display:none;position:absolute;overflow:scroll;bottom:0px;right:10px; width:600px;height:200; border:2px outset white;background-color:white;font-size:8pt;font-family: Courrier New"><div style="background-color:#f0f0f0;border:2px outset white">Debug Console: <a href="#" onClick="this.parentNode.parentNode.style.posHeight=200;return false;">small</a> <a href="#" onClick="this.parentNode.parentNode.style.posHeight=600;return false;">big</a> <a href="#" onClick="this.parentNode.parentNode.style.display=\'none\';return false;">fermer</a></div><div id="traceConsoleInside"></div><a id="scrolleu" name="scrolleu">&#160;</a></div>');
}

function TraceStart(obj,meth,zis,args)
{
	traceLogStackDepth++;
	traceLogStack[traceLogStackDepth]=zis;
	TraceLog('DEB '+obj+'.'+meth+'('+TraceArgs(args)+') on '+zis.toString(),'blue');
}
function TraceStop(obj,meth,zis,ret)
{
	TraceLog('FIN return '+objectvalue(ret)+' ['+objecttype(ret)+']','green');
	traceLogStack[traceLogStackDepth]=null;
	traceLogStackDepth--;
}
function TraceError(msg) { TraceLog(msg,'red'); }

function TraceArgs(args)
{
	if (args.length==0) return '';
	var ret='';
	for(var i=0;i<args.length;i++) ret+=','+objectvalue(args[i]);
	return ret.substring(1);
}

function TraceDepth()
{
	var s='';
	for(var i=0;i<traceLogStackDepth;i++) s+='&#160;&#160;'
	return s;
}


function JSCookieManager() { }
JSCookieManager.prototype.items = null;
JSCookieManager.prototype.init = function()
{
	this.items=new Hashtable();
	var ar = document.cookie.split('; ');
	for(var i=0;i<ar.length;i++)
	{
		var crumb=ar[i].split('=');
		this.items.insert( unescape(crumb[0]), unescape(crumb[1]) );
	}
}
JSCookieManager.prototype.get = function(name)
{
	if (!this.items) this.init();
	return this.items.get(name);
}
JSCookieManager.prototype.set = function(name,value,expires)
{
	if (!this.items) this.init();
	var argv = arguments ;
	var argc = arguments.length ;
	var expires = (argc > 2) ? argv[2] : null ;
	var path = (argc > 3) ? argv[3] : null ;
	var domain = (argc > 4) ? argv[4] : null ;
	var secure = (argc > 5) ? argv[5] : false ;
	document.cookie = name + "=" + escape (value) +((expires == null) ? "" : ("; expires=" + expires.toGMTString())) +((path == null) ? "" : ("; path=" + path)) +((domain == null) ? "" : ("; domain=" + domain)) +((secure == true) ? "; secure" : "") ;	
}
JSCookieManager.prototype.toString = function()
{
	if (!this.items) this.init();
	var s='';
	for(var i=0;i<this.items.keys.length;i++)
		s+=this.items.keys[i]+' = '+this.get(this.items.keys[i])+'\n';
	return s;
}

var cookies = new JSCookieManager();

// [EOF] for file TOOLS.js

// file: XML.js

//====================================
// KXML v0.08 - Javascript XML Parser
//====================================

//  Author: C.Chevalier
//    Date: 2002-11-06
// Version: 0.08
// - HTMLEncode ajout? dans DOMText.xml() et DOMAttribute.xml()


// -------------------------------------------------------------------------------------------------------
// | Constantes & Enum?rations |
// -----------------------------


var NODE_DOCUMENT = 9;
var NODE_ELEMENT = 1;
var NODE_ATTRIBUTE = 2;
var NODE_TEXT = 3;

function JSHolder() {}
JSHolder.prototype.add = function(id,data) { return this[id]=data; }
JSHolder.prototype.get = function(id) { return this[id]; }

var xml = new JSHolder();
var xsl = new JSHolder();

// regexp pour l'HTMLEncodage
var xml_rinf = /</ig;
var xml_rsup = />/ig;
var xml_ramp = /\&/ig;

// -------------------------------------------------------------------------------------------------------
// | DOMNode |
// -----------

function DOMNode() { }
with(DOMNode)
{
	prototype.attributes=null;
	prototype.baseName='';
	prototype.childNodes=null;
	prototype.dataType='';
	prototype.firstChild=null;
	prototype.hasChildren=false;
	prototype.lastChild=null;
	prototype.nextSibling=null;
	prototype.nodeName='';
	prototype.nodeType=NODE_ELEMENT;
	prototype.nodeTypeString='element';
	prototype.nodeValue=null;
	prototype.ownerDocument=null;
	prototype.parentNode=null;
	prototype.namespaceURI='';
	prototype.prefix='';
	prototype.previousSibling=null;	
	prototype.text='';
	prototype.level=0;
	prototype.dirty=true;
	prototype.appendChild = function(newChild)
	{
		//Trace(this,'appendChild '+newChild.nodeType+','+newChild.nodeName,newChild);
		newChild.parentNode = this;
		newChild.ownerDocument = this.ownerDocument;
		newChild.id='ID'+this.ownerDocument._counter++;
		
		if (newChild.nodeType==NODE_ATTRIBUTE)
		{
			//Trace(this,'ajout d\'un attribut',newChild);
			if (!this.attributes) this.attributes = new DOMAttributeList();
			this.attributes.addNamedItem(newChild);	
		}
		else
		{		
			//Trace(this,'ajout d\'un element',newChild);
			if (!this.hasChildren) { this.childNodes=new Array(); this.hasChildren=true; this.firstChild=newChild; }
			newChild.level = this.level+1;
			newChild.childNumber=this.childNodes.length;
			if(this.lastChild && this.lastChild.last) this.lastChild.last=false;
			this.childNodes[this.childNodes.length]=newChild;
			this.lastChild=newChild;
		}
		return newChild;
	}
	prototype.cloneNode = function(deep) { return null; }
	prototype.hasChildNodes = function() { return this.hasChildren; }
	prototype.insertBefore = function(newChild, refChild) { }
	prototype.removeChild = function(childNode)
	{
		if (this.hasChildren)
		{
			for(var i=0;i<this.childNodes.length;i++)
			{
				if (this.childNodes[i]==childNode)
				{
					this.childNodes = this.childNodes.slice(0,i).concat(this.childNodes.slice(i+1));
					childNode.parentNode=null;
					childNode.level=0;
					if(this.childNodes.length==0) this.hasChildren=false; else this.lastChild=this.childNodes[this.childNodes.length];
					
				}
			}
		}
	}
	prototype.replaceChild = function(newChild, oldChild) { }
	prototype.xml=function()
	{
		var b=false;
		var s;
		var nb=3+(this.attributes?this.attributes.length:0)+(this.hasChildren?this.childNodes.length:0);
		var ar=new Array(nb);
		var i=0;
		ar[i++]='<'+this.nodeName;
		if (this.attributes)
		if (this.attributes.length>0)
		{
			for(var j=0;j<this.attributes.length;j++)
			{
				ar[i++]=' '+(s=this.attributes.item(j).xml());
				if (s.length) b=true;
			}
		}
		if (this.hasChildren)
		{
			ar[i++]='>';
			for(var j=0;j<this.childNodes.length;j++)
			{
				s=ar[i++]=this.childNodes[j].xml();
				if (s.length) b=true;
			}
			if (!b) if (this.ownerDocument.ommitEmptyNodes) return '';
			ar[i++]='</'+this.nodeName+'>';
		}
		else
		{
			if (!b) if (this.ownerDocument.ommitEmptyNodes) return '';
			ar[i++]='/>';
		}
		if (this.ownerDocument.ommitEmptyNodes)
		{
		}
		return ar.join('');
	}
	prototype.exportData = function()
	{
		var attrs=null;
		var txt=null;
		var chld=null;
		
		if (this.attributes)
		if (this.attributes.length)
		{
			attrs=new Array(this.attributes.length);
			for(var i=0;i<this.attributes.length;i++) attrs[i]=[this.attributes.item(i).nodeName,this.attributes.item(i).nodeValue];
		}
		
		if (this.childNodes)
		if (this.childNodes.length)
		{
			var bTxt=false;
			var bChld=false;
			txt='';
			chld=new Array();
			for(var i=0;i<this.childNodes.length;i++)
			{
				var node = this.childNodes[i];
				if (node.nodeType==NODE_TEXT)
				{
					txt+=node.text;
					bTxt=true;
				}
				else
				{
					chld[chld.length]=node.exportData();
					bChld=true;
				}
			}
			if (!bTxt) txt=null;
			if (!bChld) chld=null;
		}
		return [1,this.nodeName,txt,attrs,chld];
	}
	prototype.text=function()
	{
		var cns=this.childNodes;
		if (!cns) return '';
		if (cns.length==0) return '';
		if (cns.length==1)
		{ // speedup
			var node = cns[0];
			if (node.nodeType==NODE_TEXT)
				return node.text;
			else
				return node.text();			
		}

		var s=new Array(cns.length);
		for(var i=0;i<cns.length;i++)
		{
			var node = cns[i];
			if (node.nodeType==NODE_TEXT)
				s[i]=node.text;
			else
				s[i]=node.text();
		}
		return s.join('');
	}
	prototype.setText=function(text)
	{
		var tnode=null;
		
		if (!this.childNodes)
		{
			tnode = this.ownerDocument.createTextNode(text);
			return this.appendChild(tnode);
		}
		if (this.childNodes.length==1)
		if (this.childNodes[0].nodeName=='#text')
		{
			this.childNodes[0].setValue(text);
			return this.childNodes[0];
		}
		// delete childNodes
		for(var i=this.childNodes.length-1;i;i--)
		{
			this.removeChild(this.childNodes[i]);
		}
		this.childNodes = new Array();
		tnode = this.ownerDocument.createTextNode(text);
		return this.appendChild(tnode);
		
	}
	prototype.killNodes=function()
	{
			if (this.hasChildren)
			{
				// destroy
				for(var i=0;i<this.childNodes.length;i++)
			    { 
				    var node = this.childNodes[i];	
				    if (node.attributes)
				    {
					    for(var j=0;j<node.attributes.length;j++)
					    { 
						    var attr = node.attributes.item(j);				
						    attr.parentNode=null;
						    attr.ownerDocument=null;		
					    }			
				    }			
					node.parentNode=null;
					node.ownerDocument=null;
					delete this.childNodes[i];
				}
			}
			delete this.childNodes;	
			this.hasChildren=false;
			delete this.data;
			this.data=null;
	}
	prototype.loadData=function(data)
	{
		if (!data) { RuntimeError(this,666,"Null argument","data cannot be null",null); return false; }

		if ((this.data!=null)||(this.childNodes)||(this.attributes)) this.killNodes();

		this.data = data;

		// attributes
		var attrs=data[3];
		if (attrs)
		{
			for(var i=0;i<attrs.length;i++)
			{
				this.setAttribute(attrs[i][0],attrs[i][1]);
			}
		}
		// childnodes
		var nodes=data[4];
		if (nodes)
		{
			
			for(var i=0;i<nodes.length;i++)
			{
				var child;
				switch(nodes[i][0])
				{
					case NODE_ELEMENT:
						child=this.ownerDocument.createElement(nodes[i][1]);
						this.appendChild(child);
						child.loadData(nodes[i]);
						break;
					case NODE_TEXT:
						child=this.ownerDocument.createTextNode(nodes[i][2]);
						this.appendChild(child);
						break;
					default:
						RuntimeError(this,666,"Invalid node type","Don't know what is type "&nodes[i][0],nodes[i]);
						return;
						break;
				}	
			}
		}
		if (data[2]!=null)
		{
			child=this.ownerDocument.createTextNode(data[2]);
			this.appendChild(child);
		}
		return true;


	}
	prototype._nodeFromID = function(id)
	{
		if (this.nodeType!=NODE_ELEMENT) return null;
		if (this.getAttribute('ID')==id) return this;
		if (!this.childNodes) return null;
		var n;
		for (var i=0;i<this.childNodes.length;i++)
		{
			if ((n=this.childNodes[i]._nodeFromID(id))) return n;
		}
		return null;
	}
	prototype.selectSingleNode = function(path)
	{
		var a=path.split('/');
		if (a.length==0) return null;	
		var nodeList = new DOMNodeList();
		if (a[0]=='')
			if (this.nodeType==NODE_DOCUMENT)
				b=this._findNodes(a,1,nodeList,true);
			else
				return this.ownerDocument.selectSingleNode(path);
		else
			b=this._findNodes(a,0,nodeList,true);
	
		if (b) return nodeList.item(0); else return null;
	}
	prototype.selectNodes = function(path)
	{
		var a=path.split('/');
		var nodeList = new DOMNodeList();
		if (a.length==0) return nodeList;	
		if (a[0]=='')
			if (this.nodeType==NODE_DOCUMENT)
				this._findNodes(a,1,nodeList,false);
			else
				return this.ownerDocument.selectNodes(path);
		else
			this._findNodes(a,0,nodeList,false);
	
		return nodeList;
	}

	prototype.findChildWithAttribute = function(tagName,attName,attValue)
	{
		if (!this.childNodes) return null;
		for(var i=0;i<this.childNodes.length;i++)
		{
			var child = this.childNodes[i];
			if (child.nodeName==tagName)
				if (child.attributes)
					if (child.getAttribute(attName)==attValue)
						return child;
		}
		return null;
	}
	prototype.getChildByName = function(tagName)
	{
		if (!this.childNodes) return null;
		for(var i=0;i<this.childNodes.length;i++)
		{
			var child = this.childNodes[i];
			if (child.nodeName==tagName)
				return child;
		}
		return null;
	}

	prototype._findNodes = function(array,idx,nodeList,bHighlander)
	{
		//Trace(this,"_findNodes(["+array.join(',')+"],"+idx+")",this);
		if (idx>=array.length)
		{ // c'est celui la
			nodeList.add(this);
			return true;
		}
		var name=array[idx];
		var nb=-1;
		var p=name.indexOf('[');
		if (p>0)
		{ 
			var q=name.indexOf(']');
			nb=parseInt(name.substring(p+1,q));
			name=name.substring(0,p);
		}
		if (name.charAt(0)=='@')
		{
			var attr= this.attributes.get(name.substring(1));
			if (attr!=null) nodeList.add(attr);
			return true; // il ne peut y avoir qu'un attribut avec ce nom, et il n'a pas de fils
		}
		// recherche le nbi?me node name en dessous de moi
		b=false;
		if (this.childNodes)
		for(var i=0;i<this.childNodes.length;i++)
		{
			var child=this.childNodes[i];
			if ((child.nodeName==name)||(name=='*'))
			{
				if (nb==-1)
				{ // on les prend tous
					if (child._findNodes(array,idx+1,nodeList,bHighlander))
					{
						if (bHighlander) return true; else b=true;
					}
				}
				else if (nb==0) 
				{ // on ne voulait que celui la
					return child._findNodes(array,idx+1,nodeList,bHighlander);
				}
				else
				{ 
					nb--; // peut etre le prochain
				} 
			}
		}
		return b;
	}	
	prototype.toString = function()
	{
		return 'XML['+this.nodeType+','+this.nodeName+']';
	}
	prototype.destroy = function()
	{			
		if (this.childNodes)
		{
			for(var i=0;i<this.childNodes.length;i++)
			{
				this.childNodes[i].destroy();
				delete this.childNodes[i];
			}
			this.childNodes=null;
		}
		if(this.attributes)
		{
			for(var i=0;i<this.attributes.length;i++)
			{				
				this.attributes.item(i).destroy();				
			}
			this.attributes=null;
		}
		if(this.type) this.type.destroy();				
		this.firstChild=null;	
		this.lastChild=null;
		this.nextSibling=null;	
		this.nodeValue=null;		
		this.previousSibling=null;		
		this.parentNode=null;
		this.ownerDocument=null;
	}
}


// -------------------------------------------------------------------------------------------------------
// | DOMElement |
// --------------

function DOMElement()
{
}
Implements(DOMElement,DOMNode);
with(DOMElement)
{
	prototype.getAttribute = function(name) { 		
		if (!this.attributes) return null;
		var attr=this.attributes.get(name);
		if (attr==null) return null;
		return attr.nodeValue;
	}
	//prototype.getAttributeNode = function(name) { }
	prototype.setAttribute = function(name,value) {
		if (!this.attributes) { this.attributes=new Hashtable(); }
		this.dirty=true;
		var attr=this.attributes.get(name);
		if (attr==null)
		{	
			attr=this.ownerDocument.createAttribute(name);
			attr.setValue(value);
			this.attributes.insert(name,attr);
			attr.parentNode=this;
			attr.ownerDocument=this.ownerDocument;
		}
		else
			attr.setValue(value);
	}
	//prototype.setAttributeNode = function(node) { }
	prototype.removeAttribute = function(name) { }
	//prototype.removeAttributeNode = function(node) { }
}

// -------------------------------------------------------------------------------------------------------
// | DOMDocument |
// ---------------

function DOMDocument() { }
Implements(DOMDocument,DOMNode);
with(DOMDocument)
{
	prototype.async=false; // *CAUTION*
	prototype.nodeName=prototype.tagName=prototype.baseName='#document';
	prototype.nodeType=NODE_DOCUMENT;
	prototype.nodeTypeString='document';
	prototype.documentElement=null;
	prototype.parseError=null;
	prototype._counter=1;
	prototype.nodeElementConstructor='DOMElement';
	prototype.nodeAttributeConstructor='DOMAttribute';
	prototype.nodeTextConstructor='DOMText';
	prototype.ommitEmptyNodes=false;
	prototype.abort = function() { }
	prototype.toString = function() { return '[DOMDocument]'; }
	prototype.appendChild = function(newChild)
	{
		if (newChild.nodeType!=NODE_ELEMENT) { RuntimeError(this,666,"invalid node type ("+newChild.nodeType+")","only an ELEMENT child can be appended to a DOMDocument",newChild); return null; }
		this.documentElement = newChild;
		if (!this.hasChildren) { this.childNodes=new Array(); this.hasChildren=true; }
		this.childNodes[0]=newChild;
		newChild.ownerDocument=this;
		newChild.parentNode=this;
		newChild.level = 0;
		newChild.id='ID'+this._counter++;
		return newChild;
	}
	prototype.createAttribute = function(name) { return this.createNode(NODE_ATTRIBUTE,name,''); }
	prototype.createElement = function(tagName) { return this.createNode(NODE_ELEMENT,tagName,''); }
	prototype.createTextNode = function(data) { var n=this.createNode(NODE_TEXT,'#text',''); n.setValue(data); return n; }
	prototype._getConstructorFromTag = function(tagName) { return this.nodeElementConstructor; }
	prototype.createNode = function(type,baseName,namespaceURI)
	{
		var newNode;
		switch(type)
		{
			case NODE_ELEMENT:
				newNode=eval('new '+this._getConstructorFromTag(baseName)+'();');
				newNode.namespaceURI=(namespaceURI==null)?'':namespaceURI;
				newNode.prefix=newNode.namespaceURI;
				break;
			case NODE_ATTRIBUTE:
				newNode=eval('new '+this.nodeAttributeConstructor+'();');
				break;
			case NODE_TEXT:
				newNode=eval('new '+this.nodeTextConstructor+'();');
				break;
		}
		newNode.baseName=baseName;
		newNode.nodeName=(newNode.namespaceURI=='')?baseName:(newNode.namespaceURI+':'+baseName);
		newNode.tagName=newNode.nodeName;
		newNode.ownerDocument=this;	
		return newNode;
	}
	prototype.xml = function() { return this.documentElement.xml(); }
	
	prototype.nodeFromID = function(id)
	{
		return this.documentElement._nodeFromID(id)
	}
	
	prototype.loadData = function(data)
	{
		if (!data) { RuntimeError(this,667,"Invalid Argument","data cannot be null",data); return false; }
		if (data[0]!=NODE_ELEMENT) { RuntimeError(this,666,"Invalid root node ("+data[0]+")","Only a NODE_ELEMENT can be a root node",data); return false; }

		this.data = data;

		var root = this.createElement(data[1]);
		this.appendChild(root);
		
		// attributes
		var attrs=data[3];
		if (attrs)
		{
			for(var i=0;i<attrs.length;i++)
			{
				root.setAttribute(attrs[i][0],attrs[i][1]);
			}
		}
		// childnodes
		var nodes=data[4];
		if (nodes)
		{
			
			for(var i=0;i<nodes.length;i++)
			{
				var child;
				switch(nodes[i][0])
				{
					case NODE_ELEMENT:
						child=this.createElement(nodes[i][1]);
						root.appendChild(child);
						child.loadData(nodes[i]);
						break;
					case NODE_TEXT:
						child=this.createTextNode(nodes[i][2]);
						root.appendChild(child);
						break;
					default:
						RuntimeError(this,666,"Invalid node type","Don't know what is type "&nodes[i][0],nodes[i]);
						return;
						break;
				}	
			}
		}

		return true;
	}	
}


// -------------------------------------------------------------------------------------------------------
// | DOMNodeList |
// ---------------

function DOMNodeList() {}
with(DOMNodeList)
{
	prototype.nodes = new Array();
	prototype.length=0;
	prototype.cursor=-1;
	prototype.item = function(i) { return (this.cursor>=this.length-1)?null:this.nodes[++this.cursor]; }
	prototype.nextNode = function() { return ((i<0)||(i>=this.length))?null:this.nodes[i]; }
	prototype.reset = function() { this.cursor=-1; }
	prototype.add = function(item) { this.nodes[this.length++]=item; }
	prototype.iter = function(fct) { for(var i=0;i<this.length;i++) fct(this.nodes[i]); }
}

function DOMAttribute() { }
Implements(DOMAttribute, DOMNode);
with(DOMAttribute)
{
	prototype.nodeType=NODE_ATTRIBUTE;
	prototype.nodeTypeString='attribute';	
	prototype.xml = function()
	{
		if (this.nodeValue.length==0) if (this.ownerDocument.ommitEmptyNodes) return '';
		var s=(''+this.nodeValue).replace(xml_ramp,'&amp;').replace(xml_rsup,'&gt;').replace(xml_rinf,'&lt;');
		return this.nodeName+'="'+s+'"'; 
	}	
	prototype.setValue = function(value) { this.dirty=true; this.nodeValue=this.text=value; }
	prototype.toString = function() { return '@'+this.nodeName+'="'+this.nodeValue+'"'; }
}


function DOMText() { }
Implements(DOMText, DOMNode);
with(DOMText)
{	
	prototype.nodeType=NODE_TEXT;
	prototype.length=0;
	prototype.setValue = function(v) { this.dirty=true; this.text=this.nodeValue=v; this.length=v.length; /*Trace(this,"SetTextValue: "+v,v);*/ }
	prototype.splitText = function(offset) { }
	prototype.substringData = function(offset,count) { return this.nodeValue.substring(offset,count); }
	prototype.xml = function() { 
		if (!this.nodeValue) return '';
		return (''+this.nodeValue).replace(xml_ramp,'&amp;').replace(xml_rsup,'&gt;').replace(xml_rinf,'&lt;');
	}
}

// -------------------------------------------------------------------------------------------------------
// | DOMAttributeList |
// --------------------

function DOMAttributeList() { }

Implements(DOMAttributeList,Hashtable);
with(DOMAttributeList)
{
	prototype.addNamedItem=function(newAttribute)
	{
		if (this.exists(newAttribute.nodeName))
			this.put(newAttribute.nodeName,newAttribute);
		else
			this.insert(newAttribute.nodeName,newAttribute);
			
		return newAttribute;
	}	
}

// [EOF] for file XML.js

// file: DOMCore.js

// JSE DOM level 1 / JSE 0.6.2 / Krzys / (c) Archimed 2001

// REVISIONS :
// Auteur	: Christophe Hallard
// Date		: 01/12/2002
// Ajout de 4 properties: titlebar, titlebarIcon, closeButton, defaultButtons
// Ajout de 3 m?thodes dans JSEUIObject: show, hide, getValue

// Auteur	: Bleuse Emmanuel
// Date		: 22/02/2005
// Comment  : Ajout de 4 properties: iconDraw, iconDrawSize, iconDrawBackgroundColor, iconDrawBorderColor

//----------------------------------------------------------------------------------------

var PROPERTY_NAME=0,PROPERTY_PARENT=1,PROPERTY_DEFAULT=2,PROPERTY_TYPE=3;
var dataMapProperties = [ 
					  ['closed',,false,'boolean'],
					  ['theme',,'explorer','string'],
					  ['width',,0,'number'],
					  ['height',,0,'number'],
					  ['title',,,'string'],
					  ['selectable',,false,'boolean'],
					  ['animated',,false,'boolean'],
					  ['buttons',,'','string'],
					  ['onClick',,,'event'],
					  ['onOpen',,,'event'],
					  ['onClose',,,'event'],
					  ['onMouseOver',,,'event'],
					  ['onMouseOut',,,'event'],
					  ['onShow',,,'event'],
					  ['onHide',,,'event'],
					  ['onSelectionChange',,,'event'],
					  ['onContextMenu',,,'event'],
					  ['iconDraw',,false,'boolean'],
					  ['iconDrawSize',,null,'string'],
					  ['iconDrawBackgroundColor',,null,'string'],
					  ['iconDrawBorderColor',,null,'string'],
					  ['icon',,'JSE/JSTree_vide.gif','image'],
					  ['iconOpened','icon',,'image'],
					  ['iconOpenedOver','iconOpened',,'image'],
					  ['iconOpenedDown','iconOpened',,'image'],
					  ['iconClosed','icon',,'image'],
					  ['iconClosedOver','iconClosed',,'image'],
					  ['iconClosedDown','iconClosed',,'image'],
					  ['iconSelected','icon',,'image'],
					  ['iconSelectedOpened','iconOpened',,'image'],
					  ['iconSelectedOpenedOver','iconOpenedOver',,'image'],
					  ['iconSelectedClosed','iconClosed',,'image'],
					  ['iconSelectedClosedOver','iconClosedOver',,'image'],
					  ['iconSelectedOver','iconSelected',,'image'],
					  ['iconSelectedDown','iconSelected',,'image'],
					  ['puceClosed',,'JSE/JSTree_plus.gif','image'],
					  ['puceClosedLast',,'JSE/JSTree_plusL.gif','image'],
					  ['puceOpened',,'JSE/JSTree_moins.gif','image'],
					  ['puceOpenedLast',,'JSE/JSTree_moinsL.gif','image'],
					  ['puceLeaf',,'JSE/JSTree_intersec.gif','image'],
					  ['puceLeafLast',,'JSE/JSTree_last.gif','image'],
					  ['pucePlus',,'JSE/JSTree_pplus.gif','image'],
					  ['puceMinus',,'JSE/JSTree_minus.gif','image'],					  
					  ['puce18Closed',,'JSE/JSTree18_plus.gif','image'],
					  ['puce18ClosedLast',,'JSE/JSTree18_plusL.gif','image'],
					  ['puce18Opened',,'JSE/JSTree18_moins.gif','image'],
					  ['puce18OpenedLast',,'JSE/JSTree18_moinsL.gif','image'],
					  ['puce18Leaf',,'JSE/JSTree18_intersec.gif','image'],
					  ['puce18LeafLast',,'JSE/JSTree18_last.gif','image'],
					  ['puce18Plus',,'JSE/JSTree18_pplus.gif','image'],
					  ['puce18Minus',,'JSE/JSTree18_minus.gif','image'],
					  ['puce20Plus',,'JSE/JSTree20_pplus.gif','image'],
					  ['puce20Minus',,'JSE/JSTree20_minus.gif','image'],					  
					  ['class',,'DYNTREE_NOTSELECTED','string'],
					  ['classOpened','class',,'string'],
					  ['classOpenedOver','classOpened',,'string'],
					  ['classClosed','class',,'string'],
					  ['classClosedOver','classClosed',,'string'],
					  ['classSelected','class',,'string'],
					  ['classSelectedOver','classSelected',,'string'],
					  ['classSelectedOpened','classSelected',,'string'],
					  ['classSelectedOpenedOver','classSelectedOpened',,'string'],
					  ['classSelectedClosed','classSelected',,'string'],
					  ['classSelectedClosedOver','classSelectedClosed',,'string'],					  					  
					  ['disableRollOver',,false,'boolean'],
					  ['selectionMultiple',,false,'boolean'],
					  ['visible',,true,'boolean'],
					  ['collapseBrothers',,false,'boolean'],
					  ['expandChildren',,false,'boolean'],
					  ['reloadOnTop',,false,'boolean'],
					  ['date',,,'date'],
					  ['lang',,'FR','string'],
					  ['depth',,'0', 'number'],
					  ['dotLine',, true, 'boolean'],
					  ['selected',, false, 'boolean'],
					  ['titlebar',, true, 'boolean'],    // pour g?rer l'affichage de la barre de titre d'une popup
					  ['closeButton',, true, 'boolean'], // pour g?rer l'affichage du bouton close de la barre de titre d'une popup
					  ['titlebarIcon',, true, 'boolean'],  // pour g?rer l'affichage de l'icone ? la droite du titre dans la barre de titre d'une popup 
					  ['defaultButtons',, true, 'boolean'], // pour g?rer l'affichage des boutons par d?faut pour les popups du type warning, prompt, confirm
					  ['move',, false, 'boolean'], // pour g?rer la mobilit? d'une fenetre		
					  ['left',,, 'number'], // pour pr?ciser le "top" d'une popup, ne pas d?finir de valeur par d?faut
					  ['top',,, 'number'], // pour pr?ciser le "left" d'une popup, ne pas d?finir de valeur par d?faut
					  ['contextMenu',,'','string'], // pour pr?ciser un menu contextuel
					  ['modal',, true, 'boolean'] // pour g?rer la modalit? d'un popup
					];
var mapProperties = new Hashtable();
for(var i=0;i<dataMapProperties.length;i++) mapProperties.insert(dataMapProperties[i][0],dataMapProperties[i]);

function cbool(value) { return (value==null)?false:((typeof(value)=='string')?('||FALSE|NO|OFF|NONE|0|NON|FAUX|'.indexOf('|'+value.toUpperCase()+'|')<0):value); }

function JSGetPropertyInfo(name)
{
	return mapProperties.get(name);
}

var JSEElement_defaultUIProperties='refresh|mouseOver|mouseOut|select|deselect|show|hide|toggle|getValue|destroy'.split('|');


function JSEElement() { }
Implements(JSEElement,DOMElement);
with(JSEElement)
{
	prototype.type=null;
	prototype.container=null;
	prototype.putPropertyValue = function (name,value)
	{
		this.setAttribute(name,value);
		/*eval('this._prop_'+name+'=value');*/
	}
	prototype.getPropertyValue = function (name)
	{
		// look in current node
		var value=this.getAttribute(name);
		
		if (!value)
		{ // look in type definition
			value=this.type.getAttribute(name);
			if (!value)
			{ // look for tree default values
				value = this.ownerDocument.documentElement.getAttribute(name);
			}
		}

		var prop=mapProperties.get(name);
		
		if (!value)
		{ // try 'parent' property
			if (!prop) { alert('unkown property '+name+' does not exist!'); return null; }
			var pname=prop[PROPERTY_PARENT];
			if (pname) { value=this.getPropertyValue(pname); /*eval('this._prop_'+name+'=value');*/ return value; }
			value=prop[PROPERTY_DEFAULT];
		}
		
		if (prop)
		switch(prop[PROPERTY_TYPE])
		{
			case 'image':
				value=skinCache.getImage(value);
				break;
			case 'boolean':
				value=cbool(value);
				break;
			case 'number':
				value=parseInt(value);
				break;
			case 'date':
				value=value;
		}
		return value;
	}

	prototype.write = function()
	{
		this.refresh();
	}

	prototype.setUIHandler = function (handler)
	{		
		for(var method in JSEElement_defaultUIProperties)
		{	
			this['ui_'+JSEElement_defaultUIProperties[method]] = this['ui_'+handler+'_'+JSEElement_defaultUIProperties[method]];
		}
	}
	prototype.fireEvent = function(name)
	{
		var evt = this.getPropertyValue(name);
		if (evt) eval(evt);
	}

	prototype.toString = function()
	{
		return 'ELT['+this.nodeName+','+this.id+']';
	}

}

function JSTypeLibrary(){}
Implements(JSTypeLibrary,DOMDocument);
with(JSTypeLibrary)
{
	prototype.getType = function(id)
	{
		if (id==null) id='DEFAULT';
		return this.documentElement.findChildWithAttribute('TYPE','id',id);	
	}
}
var typeLibrary = new JSTypeLibrary();

//-------------------------------------------------------------------------------------

function skinCache() {}
skinCache.getImage = function(img)
{
	return JSPath2Images+img;
}

//--------------------------------------------------------------------------------------


function JSEUIObject(){}
with(JSEUIObject)
{
	prototype.prefix = 'generic';
	prototype.container = null;
	prototype.mouseOver = function() { }
	prototype.mouseOut = function() { }
	prototype.refresh = function() { }
	prototype.select = function() {	}
	prototype.deselect = function() { }
	prototype.toggle = function() { }
	prototype.show = function() { }
	prototype.hide = function() { }
	prototype.getValue = function() { return null;}
	prototype.destroy = function()
	{				
		if (this.container)
		{	
			this.container.innerHTML='Switching off...';
			this.container.element=null;
			this.container.obj=null;
			this.container=null;
		}		
		if(this.childNodes)
		{
			for(var i=0;i<this.childNodes.length;i++)
			{
				this.childNodes[i].destroy();
				delete this.childNodes[i];
			}
			this.childNodes=null;
		}
		if(this.attributes)
		{
			for(var i=0;i<this.attributes.length;i++)
			{				
				this.attributes.item(i).destroy();								
			}
			this.attributes=null;
		}
		if(this.type) this.type.destroy();				
	}
}

//--------------------------------------------------------------------------------------

function JSETopLevelElement() {}
Implements(JSETopLevelElement,DOMDocument);
with(JSETopLevelElement)
{
	prototype.defaultType = 'DEFAULT';
	//prototype._getConstructorFromTag = function(tagName) { return this.nodeElementConstructor; }
	prototype.putPropertyValue = function(name,value) { return this.documentElement.putPropertyValue(name,value); }
	prototype.getPropertyValue = function(name) { return this.documentElement.getPropertyValue(name); }
	prototype.fireEvent = function(evt) { this.documentElement.fireEvent(evt); }
	prototype.getType = function(name)
	{ 
		if (!name) name=this.defaultType;
		return typeLibrary.getType(name);
	}
	prototype.toString = function()
	{
		return 'TOP['+this.nodeName+','+this.id+']';
	}
}

//--------------------------------------------------------------------------------------

function JSESelection() { }
with(JSESelection)
{
	prototype.selection=null;
	prototype.multiSelection=null;
	prototype._selectionIsChanging=false;
	prototype._selectionTriggeredBy=null;
	prototype.getSelection = function() { return this.selection; }
	prototype.select = function(element,addToSelection,noEvent)
	{		
		var bTriggeredByMe = !this._selectionIsChanging;
		if (bTriggeredByMe) { this._selectionIsChanging=true; this._selectionTriggerdBy='TOPSELECT'; }

		if (this.multiSelection==null) { this.multiSelection=this.getPropertyValue('selectionMultiple'); }
		if (addToSelection==null)
		{
			addToSelection=this.multiSelection;			
		}

		if (this.selection)
		{
			if (!addToSelection || (!this.multiSelection))	{ this.deselect(); }
		}
		
		if (this.selection==null) this.selection=new Array();

		// si il ?tait deja selectionn? => deselect
		if (this.selectionContains(element))
		{
			this.deselect(element);
		}
		else
		{
			this.selection[this.selection.length]=element;
			if (bTriggeredByMe)
			{
				element.select();
				this.fireEvent('onSelectionChange');
			}
		}
		if (bTriggeredByMe)
		{
			this._selectionIsChanging=false;
			this._selectionTriggerdBy=null;
		}
		return;
	}
	
	prototype.selectionContains=function(element)
	{
		if (!this.selection) return false;
		for(var i=0;i<this.selection.length;i++)
			if (this.selection[i]==element) return true;
		return false;
	}
	
	prototype.deselect = function(element)
	{
		var bTriggeredByMe = !this._selectionIsChanging;
		if (bTriggeredByMe) { this._selectionIsChanging=true; this._selectionTriggeredBy='TOPDESELECT'; }
		var bCanDeselectChildren = (bTriggeredByMe || (this._selectionTriggeredBy=='TOPSELECT') || (this._selectionTriggeredBy=='SELECT'));

		var bRet=false;
	
		if (element)
		{	// remove this element from selection			
			
			if (!this.selection || !element.selected) return false;			
			var nbElt = this.selection.length;
			for(var i=0;i<nbElt;i++)
			{		
				if(this.selection)		
				{
					if (this.selection[i]==element)
					{					
						if (bCanDeselectChildren) element.deselect();
						this.selection=this.selection.slice(0,i).concat(this.selection.slice(i+1));
						if (bTriggeredByMe) this.fireEvent('onSelectionChange');
						bRet = true;
					}	 
				}
			}			
			if (bTriggeredByMe) 
			{					
				this._selectionIsChanging=false;
				this._selectionTriggerdBy=null;
			}			
			if (this.selection.length==0) delete this.selection;			
			return bRet;
		}
		
		if (this.selection)
		{ // clear the selection
					
			if (bCanDeselectChildren) 
				for(var i=0;i<this.selection.length;i++)
				{
					this.selection[i].deselect(true);
					this.selection[i]=null;
				}
			delete this.selection;
			
			if (bTriggeredByMe) this.fireEvent('onSelectionChange');
			bRet=true;
		}
		if (bTriggeredByMe) 
		{
			this._selectionIsChanging=false;
			this._selectionTriggerdBy=null;
		}
		return bRet;
	}
	
	prototype.selectAll = function()
	{
		var bTriggeredByMe = !this._selectionIsChanging;
		if (bTriggeredByMe) { this._selectionIsChanging=true; this._selectionTriggeredBy='TOPSELECT'; }

		if (this.selection) this.deselect();

		var ar=new Array(this.documentElement.childNodes.length);
		for(var i=0;i<this.documentElement.childNodes.length;i++)
		{
			ar[i].select();
			ar[i]=this.documentElement.childNodes[i];
		}
		this.selection = ar;
		if (bTriggeredByMe)
		{
			this.fireEvent('onSelectionChange');
			this._selectionIsChanging=false;
			this._selectionTriggerdBy=null;
		}
		return true;
	}
}
//DebugObject(JSESelection);

function JSESelector() { }
with(JSESelector)
{
	prototype.select = function()
	{
		var bTriggeredByMe = !this.ownerDocument._selectionIsChanging;
		if (bTriggeredByMe) { this.ownerDocument._selectionIsChanging=true; this.ownerDocument._selectionTriggeredBy='SELECT'; }
		
		if (bTriggeredByMe) this.ownerDocument.select(this);
		
		if (this.ownerDocument.selectionContains(this))
		{
			this.selected=true;
			this.ui_select();
		}
		
		if (bTriggeredByMe)
		{
			this.ownerDocument.fireEvent('onSelectionChange');
			this.ownerDocument._selectionIsChanging=false;
			this.ownerDocument._selectionTriggeredBy=null;
		}
	}
	
	prototype.deselect = function(noBackFire)
	{
		var bTriggeredByMe = !this.ownerDocument._selectionIsChanging;
		if (bTriggeredByMe) { this.ownerDocument._selectionIsChanging=true; this.ownerDocument._selectionTriggeredBy='DESELECT'; }

		if (this.selected)
		{
			this.selected=false;
			this.ui_deselect();
		}
		
		if (bTriggeredByMe)
		{	
			this.ownerDocument.deselect(this,true);
			this.ownerDocument.fireEvent('onSelectionChange');
			this.ownerDocument._selectionIsChanging=false;
			this.ownerDocument._selectionTriggeredBy=null;
		}
	}
}

// [EOF] for file DOMCore.js

// file: RB.js

// Request

// code d'erreurs
var RB_SUCCESS              = 0;
var RB_ERROR_SERVERTIMEOUT  = 1;	// le serveur n'a pas r?pondu dans le temps imparti
var RB_ERROR_REQUESTTIMEOUT = 2;	// le serveur a r?pondu mais la requ?te a exc?d? le temps impartis.
var RB_ERROR_SYSTEMERROR    = 3;	// erreur syst?me, composants mal install?s, hardware failure...
var RB_ERROR_FAILED			= 4;	// la requ?te a provoqu? une erreur "logique"
var RB_ERROR_INVALIDARG     = 5;	// Param?tres incorrects
var RB_ERROR_ACCESSDENIED   = 6;	// Acc?s refus?s
var RB_ERROR_LOGINREQUIRED  = 7;	// Login n?cessaire


function JSRequestBroker() {}
with(JSRequestBroker)
{
	prototype.ready=false;
	prototype.list = new Array();
	prototype.counter = 0;
	prototype.holder = null;
	prototype.debugMode=false;

	prototype.init = function()
	{
		if (!this.ready)
		{
			this.holder = getElementById('JSRequestBrokerDIV');
			if (!this.holder)
			{
				var div = document.createElement('div');
				div.id='JSRequestBrokerDIV';
				div.className='JSRB_CONTAINER';
				div.style.position='absolute';
				div.style.display='none';
				div.style.visibility='hidden';				
				document.body.appendChild(div);
				this.holder = div;				
				if (!this.holder) { alert('JSRequestBroker init failed!'); return; }
			}
			this.ready=true;
		}
	}
	
	prototype.post = function(url,data,prm,callback,errorHandler,srvTimeout,rqTimeout)
	{
		if (!this.ready) this.init();
		if (!this.ready) { errorHandler(RB_ERROR_SYSTEMERROR,'RequestBroker unavailable'); return; }
		var cpt=this.counter++;
			
		if (url.indexOf('?')<0) url+='?RID='+cpt; else url+='&RID='+cpt;

		var t=new Array(7);
		t[0]=cpt;
		t[1]=url;
		t[2]=callback;
		t[3]=errorHandler;
		t[4]=false;
		t[5]=prm;
		t[6]=rqTimeout;
		this.list[this.list.length]=t;

		// cr?e le formulaire
		var frm;
		var ifr;
		if (JSisMZ)
		{
			frm=document.createElement("form");
			frm.action=url;
			frm.target='ifr_req_'+cpt;
			frm.method='POST';
			frm.id='frm_req_'+cpt;
			frm.name='frm_req_'+cpt;
			var ta=document.createElement("textarea");
			ta.name='DATA';
			ta.value = data;
			frm.appendChild(ta);
			this.holder.appendChild(frm);
			
			ifr=document.createElement("iframe");
			ifr.id="ifr_req_"+cpt;
			ifr.name="ifr_req_"+cpt;
			ifr.innerHTML='<!--'+cpt+'-->';
			this.holder.appendChild(ifr);		
			//ifr.src=url;
			
			frm.submit();
		}
		else
		{
			this.holder.insertAdjacentHTML('beforeEnd','<form action="'+url+'" target="ifr_req_'+cpt+'" method="POST" name="frm_req_'+cpt+'"><textarea name="DATA"></textarea></form>');
			frm = document.forms['frm_req_'+cpt];
			frm.DATA.value = data;
			
			this.holder.insertAdjacentHTML('beforeEnd','<iframe name="ifr_req_'+cpt+'" id="ifr_req_'+cpt+'"><!--'+cpt+'--></iframe>');
			var ifr=document.getElementById('ifr_req_'+cpt);
			
			frm.submit();
		}
		window.setTimeout('requestBroker.timeOut('+cpt+')',srvTimeout);	

	}
	
	prototype.run = function(url,prm,callback,errorHandler,srvTimeout,rqTimeout)
	{
		if (!this.ready) this.init();
		if (!this.ready) { errorHandler(RB_ERROR_SYSTEMERROR,'RequestBroker unavailable'); return; }
		var cpt=this.counter++;
	
		if (url.indexOf('?')<0) url+='?RID='+cpt; else url+='&RID='+cpt;
	
		var t=new Array(7);
		t[0]=cpt;
		t[1]=url;
		t[2]=callback;
		t[3]=errorHandler;
		t[4]=false;
		t[5]=prm;
		t[6]=rqTimeout;
		this.list[this.list.length]=t;
	
		var ifr;
		if (JSisMZ)
		{
			ifr=document.createElement("iframe");
			ifr.id="ifr_req_"+cpt;
			this.holder.appendChild(ifr);		
			ifr.src=url;
		}
		else
		{
			this.holder.insertAdjacentHTML('beforeEnd','<iframe id="ifr_req_'+cpt+'"><!--'+cpt+'--></iframe>');
			var ifr=document.getElementById('ifr_req_'+cpt);
			ifr.src=url;
		}
		window.setTimeout('requestBroker.timeOut('+cpt+')',srvTimeout);	
	}

	prototype.find = function(id) {
		for(var i=0;i<this.list.length;i++)
			if (this.list[i][0]==id) return this.list[i];
		return null;	
	}
	prototype.remove = function(id) {
		
		for(var i=0;i<this.list.length;i++)
		{
			if (this.list[i][0]==id)
			{					
				if(!this.debugMode)
				{ 
					var ifr=getElementById('ifr_req_'+id);
					if (ifr) window.setTimeout("JSDeleteElement(getElementById('ifr_req_"+id+"'));",10);

					var frm=getElementById('frm_req_'+id);
					if (frm) window.setTimeout("JSDeleteElement(getElementById('frm_req_"+id+"'));",10);

					this.list=this.list.slice(0,i).concat(this.list.slice(i+1));
				}
				else						
				{					
					this.holder.style.display='';	
					this.holder.style.visibility='visible';		
					getElementById('JSRequestBrokerDIV').style.display = '';
										
				}
				return true;
			}
		}
		return false;
	}
	prototype.timeOut = function(id) {
		var rq=this.find(id);
		if (rq==null) return; // already done
		if (rq[4]) return; // la requ?te a d?marr?
		//window.status = 'Request '+id+' ('+rq[1]+') has timeouted!!!';
		this.remove(id);
		rq[3](RB_ERROR_SERVERTIMEOUT, 'Server Timeout', rq[5]);
	}
	prototype.requestTimeOut = function(id) {
		var rq=this.find(id);
		if (rq==null) return; // already done
		//window.status = 'Request '+id+' ('+rq[1]+') has timeouted!!!';
		this.remove(id);
		rq[3](RB_ERROR_REQUESTTIMEOUT, 'Request Timeout', rq[5]);
	}
	prototype.notifyStart = function(id) {
		var rq=this.find(id);
		if (rq==null) return false; // already done!
		//window.status='Starting executing '+id;
		rq[4]=true;
		window.setTimeout('requestBroker.requestTimeOut('+id+')',rq[6]);
		return true;
	}
	prototype.notifyDone = function(id,prm) {
		var rq=this.find(id);
		if (rq==null) return false; // already done!
		//window.status='Request '+id+' done!';
		this.remove(id);
		rq[2](prm,rq[5]);
	}
	prototype.notifyError = function(id, code, desc) {
		var rq=this.find(id);
		if (rq==null) return false; // already done!?
		//window.status='Request '+id+' error: '+code+', '+desc;		
		this.remove(id);		
		rq[3](code,desc,rq[5]);
	}	
}

function JSDeleteElement(obj)
{	
	if (obj) obj.parentNode.removeChild(obj);	
}

var requestBroker = new JSRequestBroker();


// [EOF] for file RB.js

//package loaded!
packages.complete('DOMCORE');

// Served in 351 ms