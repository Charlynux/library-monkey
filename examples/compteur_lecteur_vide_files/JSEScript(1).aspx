// Package BAM_JQUERY_ALL / Copyright 2018 Archimed SA / JSE

//loading package...
packages.acknowledge('BAM_JQUERY_ALL');

// file: jquery-1.3.2.min.js

/*
 * jQuery JavaScript Library v1.3.2
 * http://jquery.com/
 *
 * Copyright (c) 2009 John Resig
 * Dual licensed under the MIT and GPL licenses.
 * http://docs.jquery.com/License
 *
 * Date: 2009-02-19 17:34:21 -0500 (Thu, 19 Feb 2009)
 * Revision: 6246
 */
(function(){var l=this,g,y=l.jQuery,p=l.$,o=l.jQuery=l.$=function(E,F){return new o.fn.init(E,F)},D=/^[^<]*(<(.|\s)+>)[^>]*$|^#([\w-]+)$/,f=/^.[^:#\[\.,]*$/;o.fn=o.prototype={init:function(E,H){E=E||document;if(E.nodeType){this[0]=E;this.length=1;this.context=E;return this}if(typeof E==="string"){var G=D.exec(E);if(G&&(G[1]||!H)){if(G[1]){E=o.clean([G[1]],H)}else{var I=document.getElementById(G[3]);if(I&&I.id!=G[3]){return o().find(E)}var F=o(I||[]);F.context=document;F.selector=E;return F}}else{return o(H).find(E)}}else{if(o.isFunction(E)){return o(document).ready(E)}}if(E.selector&&E.context){this.selector=E.selector;this.context=E.context}return this.setArray(o.isArray(E)?E:o.makeArray(E))},selector:"",jquery:"1.3.2",size:function(){return this.length},get:function(E){return E===g?Array.prototype.slice.call(this):this[E]},pushStack:function(F,H,E){var G=o(F);G.prevObject=this;G.context=this.context;if(H==="find"){G.selector=this.selector+(this.selector?" ":"")+E}else{if(H){G.selector=this.selector+"."+H+"("+E+")"}}return G},setArray:function(E){this.length=0;Array.prototype.push.apply(this,E);return this},each:function(F,E){return o.each(this,F,E)},index:function(E){return o.inArray(E&&E.jquery?E[0]:E,this)},attr:function(F,H,G){var E=F;if(typeof F==="string"){if(H===g){return this[0]&&o[G||"attr"](this[0],F)}else{E={};E[F]=H}}return this.each(function(I){for(F in E){o.attr(G?this.style:this,F,o.prop(this,E[F],G,I,F))}})},css:function(E,F){if((E=="width"||E=="height")&&parseFloat(F)<0){F=g}return this.attr(E,F,"curCSS")},text:function(F){if(typeof F!=="object"&&F!=null){return this.empty().append((this[0]&&this[0].ownerDocument||document).createTextNode(F))}var E="";o.each(F||this,function(){o.each(this.childNodes,function(){if(this.nodeType!=8){E+=this.nodeType!=1?this.nodeValue:o.fn.text([this])}})});return E},wrapAll:function(E){if(this[0]){var F=o(E,this[0].ownerDocument).clone();if(this[0].parentNode){F.insertBefore(this[0])}F.map(function(){var G=this;while(G.firstChild){G=G.firstChild}return G}).append(this)}return this},wrapInner:function(E){return this.each(function(){o(this).contents().wrapAll(E)})},wrap:function(E){return this.each(function(){o(this).wrapAll(E)})},append:function(){return this.domManip(arguments,true,function(E){if(this.nodeType==1){this.appendChild(E)}})},prepend:function(){return this.domManip(arguments,true,function(E){if(this.nodeType==1){this.insertBefore(E,this.firstChild)}})},before:function(){return this.domManip(arguments,false,function(E){this.parentNode.insertBefore(E,this)})},after:function(){return this.domManip(arguments,false,function(E){this.parentNode.insertBefore(E,this.nextSibling)})},end:function(){return this.prevObject||o([])},push:[].push,sort:[].sort,splice:[].splice,find:function(E){if(this.length===1){var F=this.pushStack([],"find",E);F.length=0;o.find(E,this[0],F);return F}else{return this.pushStack(o.unique(o.map(this,function(G){return o.find(E,G)})),"find",E)}},clone:function(G){var E=this.map(function(){if(!o.support.noCloneEvent&&!o.isXMLDoc(this)){var I=this.outerHTML;if(!I){var J=this.ownerDocument.createElement("div");J.appendChild(this.cloneNode(true));I=J.innerHTML}return o.clean([I.replace(/ jQuery\d+="(?:\d+|null)"/g,"").replace(/^\s*/,"")])[0]}else{return this.cloneNode(true)}});if(G===true){var H=this.find("*").andSelf(),F=0;E.find("*").andSelf().each(function(){if(this.nodeName!==H[F].nodeName){return}var I=o.data(H[F],"events");for(var K in I){for(var J in I[K]){o.event.add(this,K,I[K][J],I[K][J].data)}}F++})}return E},filter:function(E){return this.pushStack(o.isFunction(E)&&o.grep(this,function(G,F){return E.call(G,F)})||o.multiFilter(E,o.grep(this,function(F){return F.nodeType===1})),"filter",E)},closest:function(E){var G=o.expr.match.POS.test(E)?o(E):null,F=0;return this.map(function(){var H=this;while(H&&H.ownerDocument){if(G?G.index(H)>-1:o(H).is(E)){o.data(H,"closest",F);return H}H=H.parentNode;F++}})},not:function(E){if(typeof E==="string"){if(f.test(E)){return this.pushStack(o.multiFilter(E,this,true),"not",E)}else{E=o.multiFilter(E,this)}}var F=E.length&&E[E.length-1]!==g&&!E.nodeType;return this.filter(function(){return F?o.inArray(this,E)<0:this!=E})},add:function(E){return this.pushStack(o.unique(o.merge(this.get(),typeof E==="string"?o(E):o.makeArray(E))))},is:function(E){return !!E&&o.multiFilter(E,this).length>0},hasClass:function(E){return !!E&&this.is("."+E)},val:function(K){if(K===g){var E=this[0];if(E){if(o.nodeName(E,"option")){return(E.attributes.value||{}).specified?E.value:E.text}if(o.nodeName(E,"select")){var I=E.selectedIndex,L=[],M=E.options,H=E.type=="select-one";if(I<0){return null}for(var F=H?I:0,J=H?I+1:M.length;F<J;F++){var G=M[F];if(G.selected){K=o(G).val();if(H){return K}L.push(K)}}return L}return(E.value||"").replace(/\r/g,"")}return g}if(typeof K==="number"){K+=""}return this.each(function(){if(this.nodeType!=1){return}if(o.isArray(K)&&/radio|checkbox/.test(this.type)){this.checked=(o.inArray(this.value,K)>=0||o.inArray(this.name,K)>=0)}else{if(o.nodeName(this,"select")){var N=o.makeArray(K);o("option",this).each(function(){this.selected=(o.inArray(this.value,N)>=0||o.inArray(this.text,N)>=0)});if(!N.length){this.selectedIndex=-1}}else{this.value=K}}})},html:function(E){return E===g?(this[0]?this[0].innerHTML.replace(/ jQuery\d+="(?:\d+|null)"/g,""):null):this.empty().append(E)},replaceWith:function(E){return this.after(E).remove()},eq:function(E){return this.slice(E,+E+1)},slice:function(){return this.pushStack(Array.prototype.slice.apply(this,arguments),"slice",Array.prototype.slice.call(arguments).join(","))},map:function(E){return this.pushStack(o.map(this,function(G,F){return E.call(G,F,G)}))},andSelf:function(){return this.add(this.prevObject)},domManip:function(J,M,L){if(this[0]){var I=(this[0].ownerDocument||this[0]).createDocumentFragment(),F=o.clean(J,(this[0].ownerDocument||this[0]),I),H=I.firstChild;if(H){for(var G=0,E=this.length;G<E;G++){L.call(K(this[G],H),this.length>1||G>0?I.cloneNode(true):I)}}if(F){o.each(F,z)}}return this;function K(N,O){return M&&o.nodeName(N,"table")&&o.nodeName(O,"tr")?(N.getElementsByTagName("tbody")[0]||N.appendChild(N.ownerDocument.createElement("tbody"))):N}}};o.fn.init.prototype=o.fn;function z(E,F){if(F.src){o.ajax({url:F.src,async:false,dataType:"script"})}else{o.globalEval(F.text||F.textContent||F.innerHTML||"")}if(F.parentNode){F.parentNode.removeChild(F)}}function e(){return +new Date}o.extend=o.fn.extend=function(){var J=arguments[0]||{},H=1,I=arguments.length,E=false,G;if(typeof J==="boolean"){E=J;J=arguments[1]||{};H=2}if(typeof J!=="object"&&!o.isFunction(J)){J={}}if(I==H){J=this;--H}for(;H<I;H++){if((G=arguments[H])!=null){for(var F in G){var K=J[F],L=G[F];if(J===L){continue}if(E&&L&&typeof L==="object"&&!L.nodeType){J[F]=o.extend(E,K||(L.length!=null?[]:{}),L)}else{if(L!==g){J[F]=L}}}}}return J};var b=/z-?index|font-?weight|opacity|zoom|line-?height/i,q=document.defaultView||{},s=Object.prototype.toString;o.extend({noConflict:function(E){l.$=p;if(E){l.jQuery=y}return o},isFunction:function(E){return s.call(E)==="[object Function]"},isArray:function(E){return s.call(E)==="[object Array]"},isXMLDoc:function(E){return E.nodeType===9&&E.documentElement.nodeName!=="HTML"||!!E.ownerDocument&&o.isXMLDoc(E.ownerDocument)},globalEval:function(G){if(G&&/\S/.test(G)){var F=document.getElementsByTagName("head")[0]||document.documentElement,E=document.createElement("script");E.type="text/javascript";if(o.support.scriptEval){E.appendChild(document.createTextNode(G))}else{E.text=G}F.insertBefore(E,F.firstChild);F.removeChild(E)}},nodeName:function(F,E){return F.nodeName&&F.nodeName.toUpperCase()==E.toUpperCase()},each:function(G,K,F){var E,H=0,I=G.length;if(F){if(I===g){for(E in G){if(K.apply(G[E],F)===false){break}}}else{for(;H<I;){if(K.apply(G[H++],F)===false){break}}}}else{if(I===g){for(E in G){if(K.call(G[E],E,G[E])===false){break}}}else{for(var J=G[0];H<I&&K.call(J,H,J)!==false;J=G[++H]){}}}return G},prop:function(H,I,G,F,E){if(o.isFunction(I)){I=I.call(H,F)}return typeof I==="number"&&G=="curCSS"&&!b.test(E)?I+"px":I},className:{add:function(E,F){o.each((F||"").split(/\s+/),function(G,H){if(E.nodeType==1&&!o.className.has(E.className,H)){E.className+=(E.className?" ":"")+H}})},remove:function(E,F){if(E.nodeType==1){E.className=F!==g?o.grep(E.className.split(/\s+/),function(G){return !o.className.has(F,G)}).join(" "):""}},has:function(F,E){return F&&o.inArray(E,(F.className||F).toString().split(/\s+/))>-1}},swap:function(H,G,I){var E={};for(var F in G){E[F]=H.style[F];H.style[F]=G[F]}I.call(H);for(var F in G){H.style[F]=E[F]}},css:function(H,F,J,E){if(F=="width"||F=="height"){var L,G={position:"absolute",visibility:"hidden",display:"block"},K=F=="width"?["Left","Right"]:["Top","Bottom"];function I(){L=F=="width"?H.offsetWidth:H.offsetHeight;if(E==="border"){return}o.each(K,function(){if(!E){L-=parseFloat(o.curCSS(H,"padding"+this,true))||0}if(E==="margin"){L+=parseFloat(o.curCSS(H,"margin"+this,true))||0}else{L-=parseFloat(o.curCSS(H,"border"+this+"Width",true))||0}})}if(H.offsetWidth!==0){I()}else{o.swap(H,G,I)}return Math.max(0,Math.round(L))}return o.curCSS(H,F,J)},curCSS:function(I,F,G){var L,E=I.style;if(F=="opacity"&&!o.support.opacity){L=o.attr(E,"opacity");return L==""?"1":L}if(F.match(/float/i)){F=w}if(!G&&E&&E[F]){L=E[F]}else{if(q.getComputedStyle){if(F.match(/float/i)){F="float"}F=F.replace(/([A-Z])/g,"-$1").toLowerCase();var M=q.getComputedStyle(I,null);if(M){L=M.getPropertyValue(F)}if(F=="opacity"&&L==""){L="1"}}else{if(I.currentStyle){var J=F.replace(/\-(\w)/g,function(N,O){return O.toUpperCase()});L=I.currentStyle[F]||I.currentStyle[J];if(!/^\d+(px)?$/i.test(L)&&/^\d/.test(L)){var H=E.left,K=I.runtimeStyle.left;I.runtimeStyle.left=I.currentStyle.left;E.left=L||0;L=E.pixelLeft+"px";E.left=H;I.runtimeStyle.left=K}}}}return L},clean:function(F,K,I){K=K||document;if(typeof K.createElement==="undefined"){K=K.ownerDocument||K[0]&&K[0].ownerDocument||document}if(!I&&F.length===1&&typeof F[0]==="string"){var H=/^<(\w+)\s*\/?>$/.exec(F[0]);if(H){return[K.createElement(H[1])]}}var G=[],E=[],L=K.createElement("div");o.each(F,function(P,S){if(typeof S==="number"){S+=""}if(!S){return}if(typeof S==="string"){S=S.replace(/(<(\w+)[^>]*?)\/>/g,function(U,V,T){return T.match(/^(abbr|br|col|img|input|link|meta|param|hr|area|embed)$/i)?U:V+"></"+T+">"});var O=S.replace(/^\s+/,"").substring(0,10).toLowerCase();var Q=!O.indexOf("<opt")&&[1,"<select multiple='multiple'>","</select>"]||!O.indexOf("<leg")&&[1,"<fieldset>","</fieldset>"]||O.match(/^<(thead|tbody|tfoot|colg|cap)/)&&[1,"<table>","</table>"]||!O.indexOf("<tr")&&[2,"<table><tbody>","</tbody></table>"]||(!O.indexOf("<td")||!O.indexOf("<th"))&&[3,"<table><tbody><tr>","</tr></tbody></table>"]||!O.indexOf("<col")&&[2,"<table><tbody></tbody><colgroup>","</colgroup></table>"]||!o.support.htmlSerialize&&[1,"div<div>","</div>"]||[0,"",""];L.innerHTML=Q[1]+S+Q[2];while(Q[0]--){L=L.lastChild}if(!o.support.tbody){var R=/<tbody/i.test(S),N=!O.indexOf("<table")&&!R?L.firstChild&&L.firstChild.childNodes:Q[1]=="<table>"&&!R?L.childNodes:[];for(var M=N.length-1;M>=0;--M){if(o.nodeName(N[M],"tbody")&&!N[M].childNodes.length){N[M].parentNode.removeChild(N[M])}}}if(!o.support.leadingWhitespace&&/^\s/.test(S)){L.insertBefore(K.createTextNode(S.match(/^\s*/)[0]),L.firstChild)}S=o.makeArray(L.childNodes)}if(S.nodeType){G.push(S)}else{G=o.merge(G,S)}});if(I){for(var J=0;G[J];J++){if(o.nodeName(G[J],"script")&&(!G[J].type||G[J].type.toLowerCase()==="text/javascript")){E.push(G[J].parentNode?G[J].parentNode.removeChild(G[J]):G[J])}else{if(G[J].nodeType===1){G.splice.apply(G,[J+1,0].concat(o.makeArray(G[J].getElementsByTagName("script"))))}I.appendChild(G[J])}}return E}return G},attr:function(J,G,K){if(!J||J.nodeType==3||J.nodeType==8){return g}var H=!o.isXMLDoc(J),L=K!==g;G=H&&o.props[G]||G;if(J.tagName){var F=/href|src|style/.test(G);if(G=="selected"&&J.parentNode){J.parentNode.selectedIndex}if(G in J&&H&&!F){if(L){if(G=="type"&&o.nodeName(J,"input")&&J.parentNode){throw"type property can't be changed"}J[G]=K}if(o.nodeName(J,"form")&&J.getAttributeNode(G)){return J.getAttributeNode(G).nodeValue}if(G=="tabIndex"){var I=J.getAttributeNode("tabIndex");return I&&I.specified?I.value:J.nodeName.match(/(button|input|object|select|textarea)/i)?0:J.nodeName.match(/^(a|area)$/i)&&J.href?0:g}return J[G]}if(!o.support.style&&H&&G=="style"){return o.attr(J.style,"cssText",K)}if(L){J.setAttribute(G,""+K)}var E=!o.support.hrefNormalized&&H&&F?J.getAttribute(G,2):J.getAttribute(G);return E===null?g:E}if(!o.support.opacity&&G=="opacity"){if(L){J.zoom=1;J.filter=(J.filter||"").replace(/alpha\([^)]*\)/,"")+(parseInt(K)+""=="NaN"?"":"alpha(opacity="+K*100+")")}return J.filter&&J.filter.indexOf("opacity=")>=0?(parseFloat(J.filter.match(/opacity=([^)]*)/)[1])/100)+"":""}G=G.replace(/-([a-z])/ig,function(M,N){return N.toUpperCase()});if(L){J[G]=K}return J[G]},trim:function(E){return(E||"").replace(/^\s+|\s+$/g,"")},makeArray:function(G){var E=[];if(G!=null){var F=G.length;if(F==null||typeof G==="string"||o.isFunction(G)||G.setInterval){E[0]=G}else{while(F){E[--F]=G[F]}}}return E},inArray:function(G,H){for(var E=0,F=H.length;E<F;E++){if(H[E]===G){return E}}return -1},merge:function(H,E){var F=0,G,I=H.length;if(!o.support.getAll){while((G=E[F++])!=null){if(G.nodeType!=8){H[I++]=G}}}else{while((G=E[F++])!=null){H[I++]=G}}return H},unique:function(K){var F=[],E={};try{for(var G=0,H=K.length;G<H;G++){var J=o.data(K[G]);if(!E[J]){E[J]=true;F.push(K[G])}}}catch(I){F=K}return F},grep:function(F,J,E){var G=[];for(var H=0,I=F.length;H<I;H++){if(!E!=!J(F[H],H)){G.push(F[H])}}return G},map:function(E,J){var F=[];for(var G=0,H=E.length;G<H;G++){var I=J(E[G],G);if(I!=null){F[F.length]=I}}return F.concat.apply([],F)}});var C=navigator.userAgent.toLowerCase();o.browser={version:(C.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/)||[0,"0"])[1],safari:/webkit/.test(C),opera:/opera/.test(C),msie:/msie/.test(C)&&!/opera/.test(C),mozilla:/mozilla/.test(C)&&!/(compatible|webkit)/.test(C)};o.each({parent:function(E){return E.parentNode},parents:function(E){return o.dir(E,"parentNode")},next:function(E){return o.nth(E,2,"nextSibling")},prev:function(E){return o.nth(E,2,"previousSibling")},nextAll:function(E){return o.dir(E,"nextSibling")},prevAll:function(E){return o.dir(E,"previousSibling")},siblings:function(E){return o.sibling(E.parentNode.firstChild,E)},children:function(E){return o.sibling(E.firstChild)},contents:function(E){return o.nodeName(E,"iframe")?E.contentDocument||E.contentWindow.document:o.makeArray(E.childNodes)}},function(E,F){o.fn[E]=function(G){var H=o.map(this,F);if(G&&typeof G=="string"){H=o.multiFilter(G,H)}return this.pushStack(o.unique(H),E,G)}});o.each({appendTo:"append",prependTo:"prepend",insertBefore:"before",insertAfter:"after",replaceAll:"replaceWith"},function(E,F){o.fn[E]=function(G){var J=[],L=o(G);for(var K=0,H=L.length;K<H;K++){var I=(K>0?this.clone(true):this).get();o.fn[F].apply(o(L[K]),I);J=J.concat(I)}return this.pushStack(J,E,G)}});o.each({removeAttr:function(E){o.attr(this,E,"");if(this.nodeType==1){this.removeAttribute(E)}},addClass:function(E){o.className.add(this,E)},removeClass:function(E){o.className.remove(this,E)},toggleClass:function(F,E){if(typeof E!=="boolean"){E=!o.className.has(this,F)}o.className[E?"add":"remove"](this,F)},remove:function(E){if(!E||o.filter(E,[this]).length){o("*",this).add([this]).each(function(){o.event.remove(this);o.removeData(this)});if(this.parentNode){this.parentNode.removeChild(this)}}},empty:function(){o(this).children().remove();while(this.firstChild){this.removeChild(this.firstChild)}}},function(E,F){o.fn[E]=function(){return this.each(F,arguments)}});function j(E,F){return E[0]&&parseInt(o.curCSS(E[0],F,true),10)||0}var h="jQuery"+e(),v=0,A={};o.extend({cache:{},data:function(F,E,G){F=F==l?A:F;var H=F[h];if(!H){H=F[h]=++v}if(E&&!o.cache[H]){o.cache[H]={}}if(G!==g){o.cache[H][E]=G}return E?o.cache[H][E]:H},removeData:function(F,E){F=F==l?A:F;var H=F[h];if(E){if(o.cache[H]){delete o.cache[H][E];E="";for(E in o.cache[H]){break}if(!E){o.removeData(F)}}}else{try{delete F[h]}catch(G){if(F.removeAttribute){F.removeAttribute(h)}}delete o.cache[H]}},queue:function(F,E,H){if(F){E=(E||"fx")+"queue";var G=o.data(F,E);if(!G||o.isArray(H)){G=o.data(F,E,o.makeArray(H))}else{if(H){G.push(H)}}}return G},dequeue:function(H,G){var E=o.queue(H,G),F=E.shift();if(!G||G==="fx"){F=E[0]}if(F!==g){F.call(H)}}});o.fn.extend({data:function(E,G){var H=E.split(".");H[1]=H[1]?"."+H[1]:"";if(G===g){var F=this.triggerHandler("getData"+H[1]+"!",[H[0]]);if(F===g&&this.length){F=o.data(this[0],E)}return F===g&&H[1]?this.data(H[0]):F}else{return this.trigger("setData"+H[1]+"!",[H[0],G]).each(function(){o.data(this,E,G)})}},removeData:function(E){return this.each(function(){o.removeData(this,E)})},queue:function(E,F){if(typeof E!=="string"){F=E;E="fx"}if(F===g){return o.queue(this[0],E)}return this.each(function(){var G=o.queue(this,E,F);if(E=="fx"&&G.length==1){G[0].call(this)}})},dequeue:function(E){return this.each(function(){o.dequeue(this,E)})}});
/*
 * Sizzle CSS Selector Engine - v0.9.3
 *  Copyright 2009, The Dojo Foundation
 *  Released under the MIT, BSD, and GPL Licenses.
 *  More information: http://sizzlejs.com/
 */
(function(){var R=/((?:\((?:\([^()]+\)|[^()]+)+\)|\[(?:\[[^[\]]*\]|['"][^'"]*['"]|[^[\]'"]+)+\]|\\.|[^ >+~,(\[\\]+)+|[>+~])(\s*,\s*)?/g,L=0,H=Object.prototype.toString;var F=function(Y,U,ab,ac){ab=ab||[];U=U||document;if(U.nodeType!==1&&U.nodeType!==9){return[]}if(!Y||typeof Y!=="string"){return ab}var Z=[],W,af,ai,T,ad,V,X=true;R.lastIndex=0;while((W=R.exec(Y))!==null){Z.push(W[1]);if(W[2]){V=RegExp.rightContext;break}}if(Z.length>1&&M.exec(Y)){if(Z.length===2&&I.relative[Z[0]]){af=J(Z[0]+Z[1],U)}else{af=I.relative[Z[0]]?[U]:F(Z.shift(),U);while(Z.length){Y=Z.shift();if(I.relative[Y]){Y+=Z.shift()}af=J(Y,af)}}}else{var ae=ac?{expr:Z.pop(),set:E(ac)}:F.find(Z.pop(),Z.length===1&&U.parentNode?U.parentNode:U,Q(U));af=F.filter(ae.expr,ae.set);if(Z.length>0){ai=E(af)}else{X=false}while(Z.length){var ah=Z.pop(),ag=ah;if(!I.relative[ah]){ah=""}else{ag=Z.pop()}if(ag==null){ag=U}I.relative[ah](ai,ag,Q(U))}}if(!ai){ai=af}if(!ai){throw"Syntax error, unrecognized expression: "+(ah||Y)}if(H.call(ai)==="[object Array]"){if(!X){ab.push.apply(ab,ai)}else{if(U.nodeType===1){for(var aa=0;ai[aa]!=null;aa++){if(ai[aa]&&(ai[aa]===true||ai[aa].nodeType===1&&K(U,ai[aa]))){ab.push(af[aa])}}}else{for(var aa=0;ai[aa]!=null;aa++){if(ai[aa]&&ai[aa].nodeType===1){ab.push(af[aa])}}}}}else{E(ai,ab)}if(V){F(V,U,ab,ac);if(G){hasDuplicate=false;ab.sort(G);if(hasDuplicate){for(var aa=1;aa<ab.length;aa++){if(ab[aa]===ab[aa-1]){ab.splice(aa--,1)}}}}}return ab};F.matches=function(T,U){return F(T,null,null,U)};F.find=function(aa,T,ab){var Z,X;if(!aa){return[]}for(var W=0,V=I.order.length;W<V;W++){var Y=I.order[W],X;if((X=I.match[Y].exec(aa))){var U=RegExp.leftContext;if(U.substr(U.length-1)!=="\\"){X[1]=(X[1]||"").replace(/\\/g,"");Z=I.find[Y](X,T,ab);if(Z!=null){aa=aa.replace(I.match[Y],"");break}}}}if(!Z){Z=T.getElementsByTagName("*")}return{set:Z,expr:aa}};F.filter=function(ad,ac,ag,W){var V=ad,ai=[],aa=ac,Y,T,Z=ac&&ac[0]&&Q(ac[0]);while(ad&&ac.length){for(var ab in I.filter){if((Y=I.match[ab].exec(ad))!=null){var U=I.filter[ab],ah,af;T=false;if(aa==ai){ai=[]}if(I.preFilter[ab]){Y=I.preFilter[ab](Y,aa,ag,ai,W,Z);if(!Y){T=ah=true}else{if(Y===true){continue}}}if(Y){for(var X=0;(af=aa[X])!=null;X++){if(af){ah=U(af,Y,X,aa);var ae=W^!!ah;if(ag&&ah!=null){if(ae){T=true}else{aa[X]=false}}else{if(ae){ai.push(af);T=true}}}}}if(ah!==g){if(!ag){aa=ai}ad=ad.replace(I.match[ab],"");if(!T){return[]}break}}}if(ad==V){if(T==null){throw"Syntax error, unrecognized expression: "+ad}else{break}}V=ad}return aa};var I=F.selectors={order:["ID","NAME","TAG"],match:{ID:/#((?:[\w\u00c0-\uFFFF_-]|\\.)+)/,CLASS:/\.((?:[\w\u00c0-\uFFFF_-]|\\.)+)/,NAME:/\[name=['"]*((?:[\w\u00c0-\uFFFF_-]|\\.)+)['"]*\]/,ATTR:/\[\s*((?:[\w\u00c0-\uFFFF_-]|\\.)+)\s*(?:(\S?=)\s*(['"]*)(.*?)\3|)\s*\]/,TAG:/^((?:[\w\u00c0-\uFFFF\*_-]|\\.)+)/,CHILD:/:(only|nth|last|first)-child(?:\((even|odd|[\dn+-]*)\))?/,POS:/:(nth|eq|gt|lt|first|last|even|odd)(?:\((\d*)\))?(?=[^-]|$)/,PSEUDO:/:((?:[\w\u00c0-\uFFFF_-]|\\.)+)(?:\((['"]*)((?:\([^\)]+\)|[^\2\(\)]*)+)\2\))?/},attrMap:{"class":"className","for":"htmlFor"},attrHandle:{href:function(T){return T.getAttribute("href")}},relative:{"+":function(aa,T,Z){var X=typeof T==="string",ab=X&&!/\W/.test(T),Y=X&&!ab;if(ab&&!Z){T=T.toUpperCase()}for(var W=0,V=aa.length,U;W<V;W++){if((U=aa[W])){while((U=U.previousSibling)&&U.nodeType!==1){}aa[W]=Y||U&&U.nodeName===T?U||false:U===T}}if(Y){F.filter(T,aa,true)}},">":function(Z,U,aa){var X=typeof U==="string";if(X&&!/\W/.test(U)){U=aa?U:U.toUpperCase();for(var V=0,T=Z.length;V<T;V++){var Y=Z[V];if(Y){var W=Y.parentNode;Z[V]=W.nodeName===U?W:false}}}else{for(var V=0,T=Z.length;V<T;V++){var Y=Z[V];if(Y){Z[V]=X?Y.parentNode:Y.parentNode===U}}if(X){F.filter(U,Z,true)}}},"":function(W,U,Y){var V=L++,T=S;if(!U.match(/\W/)){var X=U=Y?U:U.toUpperCase();T=P}T("parentNode",U,V,W,X,Y)},"~":function(W,U,Y){var V=L++,T=S;if(typeof U==="string"&&!U.match(/\W/)){var X=U=Y?U:U.toUpperCase();T=P}T("previousSibling",U,V,W,X,Y)}},find:{ID:function(U,V,W){if(typeof V.getElementById!=="undefined"&&!W){var T=V.getElementById(U[1]);return T?[T]:[]}},NAME:function(V,Y,Z){if(typeof Y.getElementsByName!=="undefined"){var U=[],X=Y.getElementsByName(V[1]);for(var W=0,T=X.length;W<T;W++){if(X[W].getAttribute("name")===V[1]){U.push(X[W])}}return U.length===0?null:U}},TAG:function(T,U){return U.getElementsByTagName(T[1])}},preFilter:{CLASS:function(W,U,V,T,Z,aa){W=" "+W[1].replace(/\\/g,"")+" ";if(aa){return W}for(var X=0,Y;(Y=U[X])!=null;X++){if(Y){if(Z^(Y.className&&(" "+Y.className+" ").indexOf(W)>=0)){if(!V){T.push(Y)}}else{if(V){U[X]=false}}}}return false},ID:function(T){return T[1].replace(/\\/g,"")},TAG:function(U,T){for(var V=0;T[V]===false;V++){}return T[V]&&Q(T[V])?U[1]:U[1].toUpperCase()},CHILD:function(T){if(T[1]=="nth"){var U=/(-?)(\d*)n((?:\+|-)?\d*)/.exec(T[2]=="even"&&"2n"||T[2]=="odd"&&"2n+1"||!/\D/.test(T[2])&&"0n+"+T[2]||T[2]);T[2]=(U[1]+(U[2]||1))-0;T[3]=U[3]-0}T[0]=L++;return T},ATTR:function(X,U,V,T,Y,Z){var W=X[1].replace(/\\/g,"");if(!Z&&I.attrMap[W]){X[1]=I.attrMap[W]}if(X[2]==="~="){X[4]=" "+X[4]+" "}return X},PSEUDO:function(X,U,V,T,Y){if(X[1]==="not"){if(X[3].match(R).length>1||/^\w/.test(X[3])){X[3]=F(X[3],null,null,U)}else{var W=F.filter(X[3],U,V,true^Y);if(!V){T.push.apply(T,W)}return false}}else{if(I.match.POS.test(X[0])||I.match.CHILD.test(X[0])){return true}}return X},POS:function(T){T.unshift(true);return T}},filters:{enabled:function(T){return T.disabled===false&&T.type!=="hidden"},disabled:function(T){return T.disabled===true},checked:function(T){return T.checked===true},selected:function(T){T.parentNode.selectedIndex;return T.selected===true},parent:function(T){return !!T.firstChild},empty:function(T){return !T.firstChild},has:function(V,U,T){return !!F(T[3],V).length},header:function(T){return/h\d/i.test(T.nodeName)},text:function(T){return"text"===T.type},radio:function(T){return"radio"===T.type},checkbox:function(T){return"checkbox"===T.type},file:function(T){return"file"===T.type},password:function(T){return"password"===T.type},submit:function(T){return"submit"===T.type},image:function(T){return"image"===T.type},reset:function(T){return"reset"===T.type},button:function(T){return"button"===T.type||T.nodeName.toUpperCase()==="BUTTON"},input:function(T){return/input|select|textarea|button/i.test(T.nodeName)}},setFilters:{first:function(U,T){return T===0},last:function(V,U,T,W){return U===W.length-1},even:function(U,T){return T%2===0},odd:function(U,T){return T%2===1},lt:function(V,U,T){return U<T[3]-0},gt:function(V,U,T){return U>T[3]-0},nth:function(V,U,T){return T[3]-0==U},eq:function(V,U,T){return T[3]-0==U}},filter:{PSEUDO:function(Z,V,W,aa){var U=V[1],X=I.filters[U];if(X){return X(Z,W,V,aa)}else{if(U==="contains"){return(Z.textContent||Z.innerText||"").indexOf(V[3])>=0}else{if(U==="not"){var Y=V[3];for(var W=0,T=Y.length;W<T;W++){if(Y[W]===Z){return false}}return true}}}},CHILD:function(T,W){var Z=W[1],U=T;switch(Z){case"only":case"first":while(U=U.previousSibling){if(U.nodeType===1){return false}}if(Z=="first"){return true}U=T;case"last":while(U=U.nextSibling){if(U.nodeType===1){return false}}return true;case"nth":var V=W[2],ac=W[3];if(V==1&&ac==0){return true}var Y=W[0],ab=T.parentNode;if(ab&&(ab.sizcache!==Y||!T.nodeIndex)){var X=0;for(U=ab.firstChild;U;U=U.nextSibling){if(U.nodeType===1){U.nodeIndex=++X}}ab.sizcache=Y}var aa=T.nodeIndex-ac;if(V==0){return aa==0}else{return(aa%V==0&&aa/V>=0)}}},ID:function(U,T){return U.nodeType===1&&U.getAttribute("id")===T},TAG:function(U,T){return(T==="*"&&U.nodeType===1)||U.nodeName===T},CLASS:function(U,T){return(" "+(U.className||U.getAttribute("class"))+" ").indexOf(T)>-1},ATTR:function(Y,W){var V=W[1],T=I.attrHandle[V]?I.attrHandle[V](Y):Y[V]!=null?Y[V]:Y.getAttribute(V),Z=T+"",X=W[2],U=W[4];return T==null?X==="!=":X==="="?Z===U:X==="*="?Z.indexOf(U)>=0:X==="~="?(" "+Z+" ").indexOf(U)>=0:!U?Z&&T!==false:X==="!="?Z!=U:X==="^="?Z.indexOf(U)===0:X==="$="?Z.substr(Z.length-U.length)===U:X==="|="?Z===U||Z.substr(0,U.length+1)===U+"-":false},POS:function(X,U,V,Y){var T=U[2],W=I.setFilters[T];if(W){return W(X,V,U,Y)}}}};var M=I.match.POS;for(var O in I.match){I.match[O]=RegExp(I.match[O].source+/(?![^\[]*\])(?![^\(]*\))/.source)}var E=function(U,T){U=Array.prototype.slice.call(U);if(T){T.push.apply(T,U);return T}return U};try{Array.prototype.slice.call(document.documentElement.childNodes)}catch(N){E=function(X,W){var U=W||[];if(H.call(X)==="[object Array]"){Array.prototype.push.apply(U,X)}else{if(typeof X.length==="number"){for(var V=0,T=X.length;V<T;V++){U.push(X[V])}}else{for(var V=0;X[V];V++){U.push(X[V])}}}return U}}var G;if(document.documentElement.compareDocumentPosition){G=function(U,T){var V=U.compareDocumentPosition(T)&4?-1:U===T?0:1;if(V===0){hasDuplicate=true}return V}}else{if("sourceIndex" in document.documentElement){G=function(U,T){var V=U.sourceIndex-T.sourceIndex;if(V===0){hasDuplicate=true}return V}}else{if(document.createRange){G=function(W,U){var V=W.ownerDocument.createRange(),T=U.ownerDocument.createRange();V.selectNode(W);V.collapse(true);T.selectNode(U);T.collapse(true);var X=V.compareBoundaryPoints(Range.START_TO_END,T);if(X===0){hasDuplicate=true}return X}}}}(function(){var U=document.createElement("form"),V="script"+(new Date).getTime();U.innerHTML="<input name='"+V+"'/>";var T=document.documentElement;T.insertBefore(U,T.firstChild);if(!!document.getElementById(V)){I.find.ID=function(X,Y,Z){if(typeof Y.getElementById!=="undefined"&&!Z){var W=Y.getElementById(X[1]);return W?W.id===X[1]||typeof W.getAttributeNode!=="undefined"&&W.getAttributeNode("id").nodeValue===X[1]?[W]:g:[]}};I.filter.ID=function(Y,W){var X=typeof Y.getAttributeNode!=="undefined"&&Y.getAttributeNode("id");return Y.nodeType===1&&X&&X.nodeValue===W}}T.removeChild(U)})();(function(){var T=document.createElement("div");T.appendChild(document.createComment(""));if(T.getElementsByTagName("*").length>0){I.find.TAG=function(U,Y){var X=Y.getElementsByTagName(U[1]);if(U[1]==="*"){var W=[];for(var V=0;X[V];V++){if(X[V].nodeType===1){W.push(X[V])}}X=W}return X}}T.innerHTML="<a href='#'></a>";if(T.firstChild&&typeof T.firstChild.getAttribute!=="undefined"&&T.firstChild.getAttribute("href")!=="#"){I.attrHandle.href=function(U){return U.getAttribute("href",2)}}})();if(document.querySelectorAll){(function(){var T=F,U=document.createElement("div");U.innerHTML="<p class='TEST'></p>";if(U.querySelectorAll&&U.querySelectorAll(".TEST").length===0){return}F=function(Y,X,V,W){X=X||document;if(!W&&X.nodeType===9&&!Q(X)){try{return E(X.querySelectorAll(Y),V)}catch(Z){}}return T(Y,X,V,W)};F.find=T.find;F.filter=T.filter;F.selectors=T.selectors;F.matches=T.matches})()}if(document.getElementsByClassName&&document.documentElement.getElementsByClassName){(function(){var T=document.createElement("div");T.innerHTML="<div class='test e'></div><div class='test'></div>";if(T.getElementsByClassName("e").length===0){return}T.lastChild.className="e";if(T.getElementsByClassName("e").length===1){return}I.order.splice(1,0,"CLASS");I.find.CLASS=function(U,V,W){if(typeof V.getElementsByClassName!=="undefined"&&!W){return V.getElementsByClassName(U[1])}}})()}function P(U,Z,Y,ad,aa,ac){var ab=U=="previousSibling"&&!ac;for(var W=0,V=ad.length;W<V;W++){var T=ad[W];if(T){if(ab&&T.nodeType===1){T.sizcache=Y;T.sizset=W}T=T[U];var X=false;while(T){if(T.sizcache===Y){X=ad[T.sizset];break}if(T.nodeType===1&&!ac){T.sizcache=Y;T.sizset=W}if(T.nodeName===Z){X=T;break}T=T[U]}ad[W]=X}}}function S(U,Z,Y,ad,aa,ac){var ab=U=="previousSibling"&&!ac;for(var W=0,V=ad.length;W<V;W++){var T=ad[W];if(T){if(ab&&T.nodeType===1){T.sizcache=Y;T.sizset=W}T=T[U];var X=false;while(T){if(T.sizcache===Y){X=ad[T.sizset];break}if(T.nodeType===1){if(!ac){T.sizcache=Y;T.sizset=W}if(typeof Z!=="string"){if(T===Z){X=true;break}}else{if(F.filter(Z,[T]).length>0){X=T;break}}}T=T[U]}ad[W]=X}}}var K=document.compareDocumentPosition?function(U,T){return U.compareDocumentPosition(T)&16}:function(U,T){return U!==T&&(U.contains?U.contains(T):true)};var Q=function(T){return T.nodeType===9&&T.documentElement.nodeName!=="HTML"||!!T.ownerDocument&&Q(T.ownerDocument)};var J=function(T,aa){var W=[],X="",Y,V=aa.nodeType?[aa]:aa;while((Y=I.match.PSEUDO.exec(T))){X+=Y[0];T=T.replace(I.match.PSEUDO,"")}T=I.relative[T]?T+"*":T;for(var Z=0,U=V.length;Z<U;Z++){F(T,V[Z],W)}return F.filter(X,W)};o.find=F;o.filter=F.filter;o.expr=F.selectors;o.expr[":"]=o.expr.filters;F.selectors.filters.hidden=function(T){return T.offsetWidth===0||T.offsetHeight===0};F.selectors.filters.visible=function(T){return T.offsetWidth>0||T.offsetHeight>0};F.selectors.filters.animated=function(T){return o.grep(o.timers,function(U){return T===U.elem}).length};o.multiFilter=function(V,T,U){if(U){V=":not("+V+")"}return F.matches(V,T)};o.dir=function(V,U){var T=[],W=V[U];while(W&&W!=document){if(W.nodeType==1){T.push(W)}W=W[U]}return T};o.nth=function(X,T,V,W){T=T||1;var U=0;for(;X;X=X[V]){if(X.nodeType==1&&++U==T){break}}return X};o.sibling=function(V,U){var T=[];for(;V;V=V.nextSibling){if(V.nodeType==1&&V!=U){T.push(V)}}return T};return;l.Sizzle=F})();o.event={add:function(I,F,H,K){if(I.nodeType==3||I.nodeType==8){return}if(I.setInterval&&I!=l){I=l}if(!H.guid){H.guid=this.guid++}if(K!==g){var G=H;H=this.proxy(G);H.data=K}var E=o.data(I,"events")||o.data(I,"events",{}),J=o.data(I,"handle")||o.data(I,"handle",function(){return typeof o!=="undefined"&&!o.event.triggered?o.event.handle.apply(arguments.callee.elem,arguments):g});J.elem=I;o.each(F.split(/\s+/),function(M,N){var O=N.split(".");N=O.shift();H.type=O.slice().sort().join(".");var L=E[N];if(o.event.specialAll[N]){o.event.specialAll[N].setup.call(I,K,O)}if(!L){L=E[N]={};if(!o.event.special[N]||o.event.special[N].setup.call(I,K,O)===false){if(I.addEventListener){I.addEventListener(N,J,false)}else{if(I.attachEvent){I.attachEvent("on"+N,J)}}}}L[H.guid]=H;o.event.global[N]=true});I=null},guid:1,global:{},remove:function(K,H,J){if(K.nodeType==3||K.nodeType==8){return}var G=o.data(K,"events"),F,E;if(G){if(H===g||(typeof H==="string"&&H.charAt(0)==".")){for(var I in G){this.remove(K,I+(H||""))}}else{if(H.type){J=H.handler;H=H.type}o.each(H.split(/\s+/),function(M,O){var Q=O.split(".");O=Q.shift();var N=RegExp("(^|\\.)"+Q.slice().sort().join(".*\\.")+"(\\.|$)");if(G[O]){if(J){delete G[O][J.guid]}else{for(var P in G[O]){if(N.test(G[O][P].type)){delete G[O][P]}}}if(o.event.specialAll[O]){o.event.specialAll[O].teardown.call(K,Q)}for(F in G[O]){break}if(!F){if(!o.event.special[O]||o.event.special[O].teardown.call(K,Q)===false){if(K.removeEventListener){K.removeEventListener(O,o.data(K,"handle"),false)}else{if(K.detachEvent){K.detachEvent("on"+O,o.data(K,"handle"))}}}F=null;delete G[O]}}})}for(F in G){break}if(!F){var L=o.data(K,"handle");if(L){L.elem=null}o.removeData(K,"events");o.removeData(K,"handle")}}},trigger:function(I,K,H,E){var G=I.type||I;if(!E){I=typeof I==="object"?I[h]?I:o.extend(o.Event(G),I):o.Event(G);if(G.indexOf("!")>=0){I.type=G=G.slice(0,-1);I.exclusive=true}if(!H){I.stopPropagation();if(this.global[G]){o.each(o.cache,function(){if(this.events&&this.events[G]){o.event.trigger(I,K,this.handle.elem)}})}}if(!H||H.nodeType==3||H.nodeType==8){return g}I.result=g;I.target=H;K=o.makeArray(K);K.unshift(I)}I.currentTarget=H;var J=o.data(H,"handle");if(J){J.apply(H,K)}if((!H[G]||(o.nodeName(H,"a")&&G=="click"))&&H["on"+G]&&H["on"+G].apply(H,K)===false){I.result=false}if(!E&&H[G]&&!I.isDefaultPrevented()&&!(o.nodeName(H,"a")&&G=="click")){this.triggered=true;try{H[G]()}catch(L){}}this.triggered=false;if(!I.isPropagationStopped()){var F=H.parentNode||H.ownerDocument;if(F){o.event.trigger(I,K,F,true)}}},handle:function(K){var J,E;K=arguments[0]=o.event.fix(K||l.event);K.currentTarget=this;var L=K.type.split(".");K.type=L.shift();J=!L.length&&!K.exclusive;var I=RegExp("(^|\\.)"+L.slice().sort().join(".*\\.")+"(\\.|$)");E=(o.data(this,"events")||{})[K.type];for(var G in E){var H=E[G];if(J||I.test(H.type)){K.handler=H;K.data=H.data;var F=H.apply(this,arguments);if(F!==g){K.result=F;if(F===false){K.preventDefault();K.stopPropagation()}}if(K.isImmediatePropagationStopped()){break}}}},props:"altKey attrChange attrName bubbles button cancelable charCode clientX clientY ctrlKey currentTarget data detail eventPhase fromElement handler keyCode metaKey newValue originalTarget pageX pageY prevValue relatedNode relatedTarget screenX screenY shiftKey srcElement target toElement view wheelDelta which".split(" "),fix:function(H){if(H[h]){return H}var F=H;H=o.Event(F);for(var G=this.props.length,J;G;){J=this.props[--G];H[J]=F[J]}if(!H.target){H.target=H.srcElement||document}if(H.target.nodeType==3){H.target=H.target.parentNode}if(!H.relatedTarget&&H.fromElement){H.relatedTarget=H.fromElement==H.target?H.toElement:H.fromElement}if(H.pageX==null&&H.clientX!=null){var I=document.documentElement,E=document.body;H.pageX=H.clientX+(I&&I.scrollLeft||E&&E.scrollLeft||0)-(I.clientLeft||0);H.pageY=H.clientY+(I&&I.scrollTop||E&&E.scrollTop||0)-(I.clientTop||0)}if(!H.which&&((H.charCode||H.charCode===0)?H.charCode:H.keyCode)){H.which=H.charCode||H.keyCode}if(!H.metaKey&&H.ctrlKey){H.metaKey=H.ctrlKey}if(!H.which&&H.button){H.which=(H.button&1?1:(H.button&2?3:(H.button&4?2:0)))}return H},proxy:function(F,E){E=E||function(){return F.apply(this,arguments)};E.guid=F.guid=F.guid||E.guid||this.guid++;return E},special:{ready:{setup:B,teardown:function(){}}},specialAll:{live:{setup:function(E,F){o.event.add(this,F[0],c)},teardown:function(G){if(G.length){var E=0,F=RegExp("(^|\\.)"+G[0]+"(\\.|$)");o.each((o.data(this,"events").live||{}),function(){if(F.test(this.type)){E++}});if(E<1){o.event.remove(this,G[0],c)}}}}}};o.Event=function(E){if(!this.preventDefault){return new o.Event(E)}if(E&&E.type){this.originalEvent=E;this.type=E.type}else{this.type=E}this.timeStamp=e();this[h]=true};function k(){return false}function u(){return true}o.Event.prototype={preventDefault:function(){this.isDefaultPrevented=u;var E=this.originalEvent;if(!E){return}if(E.preventDefault){E.preventDefault()}E.returnValue=false},stopPropagation:function(){this.isPropagationStopped=u;var E=this.originalEvent;if(!E){return}if(E.stopPropagation){E.stopPropagation()}E.cancelBubble=true},stopImmediatePropagation:function(){this.isImmediatePropagationStopped=u;this.stopPropagation()},isDefaultPrevented:k,isPropagationStopped:k,isImmediatePropagationStopped:k};var a=function(F){var E=F.relatedTarget;while(E&&E!=this){try{E=E.parentNode}catch(G){E=this}}if(E!=this){F.type=F.data;o.event.handle.apply(this,arguments)}};o.each({mouseover:"mouseenter",mouseout:"mouseleave"},function(F,E){o.event.special[E]={setup:function(){o.event.add(this,F,a,E)},teardown:function(){o.event.remove(this,F,a)}}});o.fn.extend({bind:function(F,G,E){return F=="unload"?this.one(F,G,E):this.each(function(){o.event.add(this,F,E||G,E&&G)})},one:function(G,H,F){var E=o.event.proxy(F||H,function(I){o(this).unbind(I,E);return(F||H).apply(this,arguments)});return this.each(function(){o.event.add(this,G,E,F&&H)})},unbind:function(F,E){return this.each(function(){o.event.remove(this,F,E)})},trigger:function(E,F){return this.each(function(){o.event.trigger(E,F,this)})},triggerHandler:function(E,G){if(this[0]){var F=o.Event(E);F.preventDefault();F.stopPropagation();o.event.trigger(F,G,this[0]);return F.result}},toggle:function(G){var E=arguments,F=1;while(F<E.length){o.event.proxy(G,E[F++])}return this.click(o.event.proxy(G,function(H){this.lastToggle=(this.lastToggle||0)%F;H.preventDefault();return E[this.lastToggle++].apply(this,arguments)||false}))},hover:function(E,F){return this.mouseenter(E).mouseleave(F)},ready:function(E){B();if(o.isReady){E.call(document,o)}else{o.readyList.push(E)}return this},live:function(G,F){var E=o.event.proxy(F);E.guid+=this.selector+G;o(document).bind(i(G,this.selector),this.selector,E);return this},die:function(F,E){o(document).unbind(i(F,this.selector),E?{guid:E.guid+this.selector+F}:null);return this}});function c(H){var E=RegExp("(^|\\.)"+H.type+"(\\.|$)"),G=true,F=[];o.each(o.data(this,"events").live||[],function(I,J){if(E.test(J.type)){var K=o(H.target).closest(J.data)[0];if(K){F.push({elem:K,fn:J})}}});F.sort(function(J,I){return o.data(J.elem,"closest")-o.data(I.elem,"closest")});o.each(F,function(){if(this.fn.call(this.elem,H,this.fn.data)===false){return(G=false)}});return G}function i(F,E){return["live",F,E.replace(/\./g,"`").replace(/ /g,"|")].join(".")}o.extend({isReady:false,readyList:[],ready:function(){if(!o.isReady){o.isReady=true;if(o.readyList){o.each(o.readyList,function(){this.call(document,o)});o.readyList=null}o(document).triggerHandler("ready")}}});var x=false;function B(){if(x){return}x=true;if(document.addEventListener){document.addEventListener("DOMContentLoaded",function(){document.removeEventListener("DOMContentLoaded",arguments.callee,false);o.ready()},false)}else{if(document.attachEvent){document.attachEvent("onreadystatechange",function(){if(document.readyState==="complete"){document.detachEvent("onreadystatechange",arguments.callee);o.ready()}});if(document.documentElement.doScroll&&l==l.top){(function(){if(o.isReady){return}try{document.documentElement.doScroll("left")}catch(E){setTimeout(arguments.callee,0);return}o.ready()})()}}}o.event.add(l,"load",o.ready)}o.each(("blur,focus,load,resize,scroll,unload,click,dblclick,mousedown,mouseup,mousemove,mouseover,mouseout,mouseenter,mouseleave,change,select,submit,keydown,keypress,keyup,error").split(","),function(F,E){o.fn[E]=function(G){return G?this.bind(E,G):this.trigger(E)}});o(l).bind("unload",function(){for(var E in o.cache){if(E!=1&&o.cache[E].handle){o.event.remove(o.cache[E].handle.elem)}}});(function(){o.support={};var F=document.documentElement,G=document.createElement("script"),K=document.createElement("div"),J="script"+(new Date).getTime();K.style.display="none";K.innerHTML='   <link/><table></table><a href="/a" style="color:red;float:left;opacity:.5;">a</a><select><option>text</option></select><object><param/></object>';var H=K.getElementsByTagName("*"),E=K.getElementsByTagName("a")[0];if(!H||!H.length||!E){return}o.support={leadingWhitespace:K.firstChild.nodeType==3,tbody:!K.getElementsByTagName("tbody").length,objectAll:!!K.getElementsByTagName("object")[0].getElementsByTagName("*").length,htmlSerialize:!!K.getElementsByTagName("link").length,style:/red/.test(E.getAttribute("style")),hrefNormalized:E.getAttribute("href")==="/a",opacity:E.style.opacity==="0.5",cssFloat:!!E.style.cssFloat,scriptEval:false,noCloneEvent:true,boxModel:null};G.type="text/javascript";try{G.appendChild(document.createTextNode("window."+J+"=1;"))}catch(I){}F.insertBefore(G,F.firstChild);if(l[J]){o.support.scriptEval=true;delete l[J]}F.removeChild(G);if(K.attachEvent&&K.fireEvent){K.attachEvent("onclick",function(){o.support.noCloneEvent=false;K.detachEvent("onclick",arguments.callee)});K.cloneNode(true).fireEvent("onclick")}o(function(){var L=document.createElement("div");L.style.width=L.style.paddingLeft="1px";document.body.appendChild(L);o.boxModel=o.support.boxModel=L.offsetWidth===2;document.body.removeChild(L).style.display="none"})})();var w=o.support.cssFloat?"cssFloat":"styleFloat";o.props={"for":"htmlFor","class":"className","float":w,cssFloat:w,styleFloat:w,readonly:"readOnly",maxlength:"maxLength",cellspacing:"cellSpacing",rowspan:"rowSpan",tabindex:"tabIndex"};o.fn.extend({_load:o.fn.load,load:function(G,J,K){if(typeof G!=="string"){return this._load(G)}var I=G.indexOf(" ");if(I>=0){var E=G.slice(I,G.length);G=G.slice(0,I)}var H="GET";if(J){if(o.isFunction(J)){K=J;J=null}else{if(typeof J==="object"){J=o.param(J);H="POST"}}}var F=this;o.ajax({url:G,type:H,dataType:"html",data:J,complete:function(M,L){if(L=="success"||L=="notmodified"){F.html(E?o("<div/>").append(M.responseText.replace(/<script(.|\s)*?\/script>/g,"")).find(E):M.responseText)}if(K){F.each(K,[M.responseText,L,M])}}});return this},serialize:function(){return o.param(this.serializeArray())},serializeArray:function(){return this.map(function(){return this.elements?o.makeArray(this.elements):this}).filter(function(){return this.name&&!this.disabled&&(this.checked||/select|textarea/i.test(this.nodeName)||/text|hidden|password|search/i.test(this.type))}).map(function(E,F){var G=o(this).val();return G==null?null:o.isArray(G)?o.map(G,function(I,H){return{name:F.name,value:I}}):{name:F.name,value:G}}).get()}});o.each("ajaxStart,ajaxStop,ajaxComplete,ajaxError,ajaxSuccess,ajaxSend".split(","),function(E,F){o.fn[F]=function(G){return this.bind(F,G)}});var r=e();o.extend({get:function(E,G,H,F){if(o.isFunction(G)){H=G;G=null}return o.ajax({type:"GET",url:E,data:G,success:H,dataType:F})},getScript:function(E,F){return o.get(E,null,F,"script")},getJSON:function(E,F,G){return o.get(E,F,G,"json")},post:function(E,G,H,F){if(o.isFunction(G)){H=G;G={}}return o.ajax({type:"POST",url:E,data:G,success:H,dataType:F})},ajaxSetup:function(E){o.extend(o.ajaxSettings,E)},ajaxSettings:{url:location.href,global:true,type:"GET",contentType:"application/x-www-form-urlencoded",processData:true,async:true,xhr:function(){return l.ActiveXObject?new ActiveXObject("Microsoft.XMLHTTP"):new XMLHttpRequest()},accepts:{xml:"application/xml, text/xml",html:"text/html",script:"text/javascript, application/javascript",json:"application/json, text/javascript",text:"text/plain",_default:"*/*"}},lastModified:{},ajax:function(M){M=o.extend(true,M,o.extend(true,{},o.ajaxSettings,M));var W,F=/=\?(&|$)/g,R,V,G=M.type.toUpperCase();if(M.data&&M.processData&&typeof M.data!=="string"){M.data=o.param(M.data)}if(M.dataType=="jsonp"){if(G=="GET"){if(!M.url.match(F)){M.url+=(M.url.match(/\?/)?"&":"?")+(M.jsonp||"callback")+"=?"}}else{if(!M.data||!M.data.match(F)){M.data=(M.data?M.data+"&":"")+(M.jsonp||"callback")+"=?"}}M.dataType="json"}if(M.dataType=="json"&&(M.data&&M.data.match(F)||M.url.match(F))){W="jsonp"+r++;if(M.data){M.data=(M.data+"").replace(F,"="+W+"$1")}M.url=M.url.replace(F,"="+W+"$1");M.dataType="script";l[W]=function(X){V=X;I();L();l[W]=g;try{delete l[W]}catch(Y){}if(H){H.removeChild(T)}}}if(M.dataType=="script"&&M.cache==null){M.cache=false}if(M.cache===false&&G=="GET"){var E=e();var U=M.url.replace(/(\?|&)_=.*?(&|$)/,"$1_="+E+"$2");M.url=U+((U==M.url)?(M.url.match(/\?/)?"&":"?")+"_="+E:"")}if(M.data&&G=="GET"){M.url+=(M.url.match(/\?/)?"&":"?")+M.data;M.data=null}if(M.global&&!o.active++){o.event.trigger("ajaxStart")}var Q=/^(\w+:)?\/\/([^\/?#]+)/.exec(M.url);if(M.dataType=="script"&&G=="GET"&&Q&&(Q[1]&&Q[1]!=location.protocol||Q[2]!=location.host)){var H=document.getElementsByTagName("head")[0];var T=document.createElement("script");T.src=M.url;if(M.scriptCharset){T.charset=M.scriptCharset}if(!W){var O=false;T.onload=T.onreadystatechange=function(){if(!O&&(!this.readyState||this.readyState=="loaded"||this.readyState=="complete")){O=true;I();L();T.onload=T.onreadystatechange=null;H.removeChild(T)}}}H.appendChild(T);return g}var K=false;var J=M.xhr();if(M.username){J.open(G,M.url,M.async,M.username,M.password)}else{J.open(G,M.url,M.async)}try{if(M.data){J.setRequestHeader("Content-Type",M.contentType)}if(M.ifModified){J.setRequestHeader("If-Modified-Since",o.lastModified[M.url]||"Thu, 01 Jan 1970 00:00:00 GMT")}J.setRequestHeader("X-Requested-With","XMLHttpRequest");J.setRequestHeader("Accept",M.dataType&&M.accepts[M.dataType]?M.accepts[M.dataType]+", */*":M.accepts._default)}catch(S){}if(M.beforeSend&&M.beforeSend(J,M)===false){if(M.global&&!--o.active){o.event.trigger("ajaxStop")}J.abort();return false}if(M.global){o.event.trigger("ajaxSend",[J,M])}var N=function(X){if(J.readyState==0){if(P){clearInterval(P);P=null;if(M.global&&!--o.active){o.event.trigger("ajaxStop")}}}else{if(!K&&J&&(J.readyState==4||X=="timeout")){K=true;if(P){clearInterval(P);P=null}R=X=="timeout"?"timeout":!o.httpSuccess(J)?"error":M.ifModified&&o.httpNotModified(J,M.url)?"notmodified":"success";if(R=="success"){try{V=o.httpData(J,M.dataType,M)}catch(Z){R="parsererror"}}if(R=="success"){var Y;try{Y=J.getResponseHeader("Last-Modified")}catch(Z){}if(M.ifModified&&Y){o.lastModified[M.url]=Y}if(!W){I()}}else{o.handleError(M,J,R)}L();if(X){J.abort()}if(M.async){J=null}}}};if(M.async){var P=setInterval(N,13);if(M.timeout>0){setTimeout(function(){if(J&&!K){N("timeout")}},M.timeout)}}try{J.send(M.data)}catch(S){o.handleError(M,J,null,S)}if(!M.async){N()}function I(){if(M.success){M.success(V,R)}if(M.global){o.event.trigger("ajaxSuccess",[J,M])}}function L(){if(M.complete){M.complete(J,R)}if(M.global){o.event.trigger("ajaxComplete",[J,M])}if(M.global&&!--o.active){o.event.trigger("ajaxStop")}}return J},handleError:function(F,H,E,G){if(F.error){F.error(H,E,G)}if(F.global){o.event.trigger("ajaxError",[H,F,G])}},active:0,httpSuccess:function(F){try{return !F.status&&location.protocol=="file:"||(F.status>=200&&F.status<300)||F.status==304||F.status==1223}catch(E){}return false},httpNotModified:function(G,E){try{var H=G.getResponseHeader("Last-Modified");return G.status==304||H==o.lastModified[E]}catch(F){}return false},httpData:function(J,H,G){var F=J.getResponseHeader("content-type"),E=H=="xml"||!H&&F&&F.indexOf("xml")>=0,I=E?J.responseXML:J.responseText;if(E&&I.documentElement.tagName=="parsererror"){throw"parsererror"}if(G&&G.dataFilter){I=G.dataFilter(I,H)}if(typeof I==="string"){if(H=="script"){o.globalEval(I)}if(H=="json"){I=l["eval"]("("+I+")")}}return I},param:function(E){var G=[];function H(I,J){G[G.length]=encodeURIComponent(I)+"="+encodeURIComponent(J)}if(o.isArray(E)||E.jquery){o.each(E,function(){H(this.name,this.value)})}else{for(var F in E){if(o.isArray(E[F])){o.each(E[F],function(){H(F,this)})}else{H(F,o.isFunction(E[F])?E[F]():E[F])}}}return G.join("&").replace(/%20/g,"+")}});var m={},n,d=[["height","marginTop","marginBottom","paddingTop","paddingBottom"],["width","marginLeft","marginRight","paddingLeft","paddingRight"],["opacity"]];function t(F,E){var G={};o.each(d.concat.apply([],d.slice(0,E)),function(){G[this]=F});return G}o.fn.extend({show:function(J,L){if(J){return this.animate(t("show",3),J,L)}else{for(var H=0,F=this.length;H<F;H++){var E=o.data(this[H],"olddisplay");this[H].style.display=E||"";if(o.css(this[H],"display")==="none"){var G=this[H].tagName,K;if(m[G]){K=m[G]}else{var I=o("<"+G+" />").appendTo("body");K=I.css("display");if(K==="none"){K="block"}I.remove();m[G]=K}o.data(this[H],"olddisplay",K)}}for(var H=0,F=this.length;H<F;H++){this[H].style.display=o.data(this[H],"olddisplay")||""}return this}},hide:function(H,I){if(H){return this.animate(t("hide",3),H,I)}else{for(var G=0,F=this.length;G<F;G++){var E=o.data(this[G],"olddisplay");if(!E&&E!=="none"){o.data(this[G],"olddisplay",o.css(this[G],"display"))}}for(var G=0,F=this.length;G<F;G++){this[G].style.display="none"}return this}},_toggle:o.fn.toggle,toggle:function(G,F){var E=typeof G==="boolean";return o.isFunction(G)&&o.isFunction(F)?this._toggle.apply(this,arguments):G==null||E?this.each(function(){var H=E?G:o(this).is(":hidden");o(this)[H?"show":"hide"]()}):this.animate(t("toggle",3),G,F)},fadeTo:function(E,G,F){return this.animate({opacity:G},E,F)},animate:function(I,F,H,G){var E=o.speed(F,H,G);return this[E.queue===false?"each":"queue"](function(){var K=o.extend({},E),M,L=this.nodeType==1&&o(this).is(":hidden"),J=this;for(M in I){if(I[M]=="hide"&&L||I[M]=="show"&&!L){return K.complete.call(this)}if((M=="height"||M=="width")&&this.style){K.display=o.css(this,"display");K.overflow=this.style.overflow}}if(K.overflow!=null){this.style.overflow="hidden"}K.curAnim=o.extend({},I);o.each(I,function(O,S){var R=new o.fx(J,K,O);if(/toggle|show|hide/.test(S)){R[S=="toggle"?L?"show":"hide":S](I)}else{var Q=S.toString().match(/^([+-]=)?([\d+-.]+)(.*)$/),T=R.cur(true)||0;if(Q){var N=parseFloat(Q[2]),P=Q[3]||"px";if(P!="px"){J.style[O]=(N||1)+P;T=((N||1)/R.cur(true))*T;J.style[O]=T+P}if(Q[1]){N=((Q[1]=="-="?-1:1)*N)+T}R.custom(T,N,P)}else{R.custom(T,S,"")}}});return true})},stop:function(F,E){var G=o.timers;if(F){this.queue([])}this.each(function(){for(var H=G.length-1;H>=0;H--){if(G[H].elem==this){if(E){G[H](true)}G.splice(H,1)}}});if(!E){this.dequeue()}return this}});o.each({slideDown:t("show",1),slideUp:t("hide",1),slideToggle:t("toggle",1),fadeIn:{opacity:"show"},fadeOut:{opacity:"hide"}},function(E,F){o.fn[E]=function(G,H){return this.animate(F,G,H)}});o.extend({speed:function(G,H,F){var E=typeof G==="object"?G:{complete:F||!F&&H||o.isFunction(G)&&G,duration:G,easing:F&&H||H&&!o.isFunction(H)&&H};E.duration=o.fx.off?0:typeof E.duration==="number"?E.duration:o.fx.speeds[E.duration]||o.fx.speeds._default;E.old=E.complete;E.complete=function(){if(E.queue!==false){o(this).dequeue()}if(o.isFunction(E.old)){E.old.call(this)}};return E},easing:{linear:function(G,H,E,F){return E+F*G},swing:function(G,H,E,F){return((-Math.cos(G*Math.PI)/2)+0.5)*F+E}},timers:[],fx:function(F,E,G){this.options=E;this.elem=F;this.prop=G;if(!E.orig){E.orig={}}}});o.fx.prototype={update:function(){if(this.options.step){this.options.step.call(this.elem,this.now,this)}(o.fx.step[this.prop]||o.fx.step._default)(this);if((this.prop=="height"||this.prop=="width")&&this.elem.style){this.elem.style.display="block"}},cur:function(F){if(this.elem[this.prop]!=null&&(!this.elem.style||this.elem.style[this.prop]==null)){return this.elem[this.prop]}var E=parseFloat(o.css(this.elem,this.prop,F));return E&&E>-10000?E:parseFloat(o.curCSS(this.elem,this.prop))||0},custom:function(I,H,G){this.startTime=e();this.start=I;this.end=H;this.unit=G||this.unit||"px";this.now=this.start;this.pos=this.state=0;var E=this;function F(J){return E.step(J)}F.elem=this.elem;if(F()&&o.timers.push(F)&&!n){n=setInterval(function(){var K=o.timers;for(var J=0;J<K.length;J++){if(!K[J]()){K.splice(J--,1)}}if(!K.length){clearInterval(n);n=g}},13)}},show:function(){this.options.orig[this.prop]=o.attr(this.elem.style,this.prop);this.options.show=true;this.custom(this.prop=="width"||this.prop=="height"?1:0,this.cur());o(this.elem).show()},hide:function(){this.options.orig[this.prop]=o.attr(this.elem.style,this.prop);this.options.hide=true;this.custom(this.cur(),0)},step:function(H){var G=e();if(H||G>=this.options.duration+this.startTime){this.now=this.end;this.pos=this.state=1;this.update();this.options.curAnim[this.prop]=true;var E=true;for(var F in this.options.curAnim){if(this.options.curAnim[F]!==true){E=false}}if(E){if(this.options.display!=null){this.elem.style.overflow=this.options.overflow;this.elem.style.display=this.options.display;if(o.css(this.elem,"display")=="none"){this.elem.style.display="block"}}if(this.options.hide){o(this.elem).hide()}if(this.options.hide||this.options.show){for(var I in this.options.curAnim){o.attr(this.elem.style,I,this.options.orig[I])}}this.options.complete.call(this.elem)}return false}else{var J=G-this.startTime;this.state=J/this.options.duration;this.pos=o.easing[this.options.easing||(o.easing.swing?"swing":"linear")](this.state,J,0,1,this.options.duration);this.now=this.start+((this.end-this.start)*this.pos);this.update()}return true}};o.extend(o.fx,{speeds:{slow:600,fast:200,_default:400},step:{opacity:function(E){o.attr(E.elem.style,"opacity",E.now)},_default:function(E){if(E.elem.style&&E.elem.style[E.prop]!=null){E.elem.style[E.prop]=E.now+E.unit}else{E.elem[E.prop]=E.now}}}});if(document.documentElement.getBoundingClientRect){o.fn.offset=function(){if(!this[0]){return{top:0,left:0}}if(this[0]===this[0].ownerDocument.body){return o.offset.bodyOffset(this[0])}var G=this[0].getBoundingClientRect(),J=this[0].ownerDocument,F=J.body,E=J.documentElement,L=E.clientTop||F.clientTop||0,K=E.clientLeft||F.clientLeft||0,I=G.top+(self.pageYOffset||o.boxModel&&E.scrollTop||F.scrollTop)-L,H=G.left+(self.pageXOffset||o.boxModel&&E.scrollLeft||F.scrollLeft)-K;return{top:I,left:H}}}else{o.fn.offset=function(){if(!this[0]){return{top:0,left:0}}if(this[0]===this[0].ownerDocument.body){return o.offset.bodyOffset(this[0])}o.offset.initialized||o.offset.initialize();var J=this[0],G=J.offsetParent,F=J,O=J.ownerDocument,M,H=O.documentElement,K=O.body,L=O.defaultView,E=L.getComputedStyle(J,null),N=J.offsetTop,I=J.offsetLeft;while((J=J.parentNode)&&J!==K&&J!==H){M=L.getComputedStyle(J,null);N-=J.scrollTop,I-=J.scrollLeft;if(J===G){N+=J.offsetTop,I+=J.offsetLeft;if(o.offset.doesNotAddBorder&&!(o.offset.doesAddBorderForTableAndCells&&/^t(able|d|h)$/i.test(J.tagName))){N+=parseInt(M.borderTopWidth,10)||0,I+=parseInt(M.borderLeftWidth,10)||0}F=G,G=J.offsetParent}if(o.offset.subtractsBorderForOverflowNotVisible&&M.overflow!=="visible"){N+=parseInt(M.borderTopWidth,10)||0,I+=parseInt(M.borderLeftWidth,10)||0}E=M}if(E.position==="relative"||E.position==="static"){N+=K.offsetTop,I+=K.offsetLeft}if(E.position==="fixed"){N+=Math.max(H.scrollTop,K.scrollTop),I+=Math.max(H.scrollLeft,K.scrollLeft)}return{top:N,left:I}}}o.offset={initialize:function(){if(this.initialized){return}var L=document.body,F=document.createElement("div"),H,G,N,I,M,E,J=L.style.marginTop,K='<div style="position:absolute;top:0;left:0;margin:0;border:5px solid #000;padding:0;width:1px;height:1px;"><div></div></div><table style="position:absolute;top:0;left:0;margin:0;border:5px solid #000;padding:0;width:1px;height:1px;" cellpadding="0" cellspacing="0"><tr><td></td></tr></table>';M={position:"absolute",top:0,left:0,margin:0,border:0,width:"1px",height:"1px",visibility:"hidden"};for(E in M){F.style[E]=M[E]}F.innerHTML=K;L.insertBefore(F,L.firstChild);H=F.firstChild,G=H.firstChild,I=H.nextSibling.firstChild.firstChild;this.doesNotAddBorder=(G.offsetTop!==5);this.doesAddBorderForTableAndCells=(I.offsetTop===5);H.style.overflow="hidden",H.style.position="relative";this.subtractsBorderForOverflowNotVisible=(G.offsetTop===-5);L.style.marginTop="1px";this.doesNotIncludeMarginInBodyOffset=(L.offsetTop===0);L.style.marginTop=J;L.removeChild(F);this.initialized=true},bodyOffset:function(E){o.offset.initialized||o.offset.initialize();var G=E.offsetTop,F=E.offsetLeft;if(o.offset.doesNotIncludeMarginInBodyOffset){G+=parseInt(o.curCSS(E,"marginTop",true),10)||0,F+=parseInt(o.curCSS(E,"marginLeft",true),10)||0}return{top:G,left:F}}};o.fn.extend({position:function(){var I=0,H=0,F;if(this[0]){var G=this.offsetParent(),J=this.offset(),E=/^body|html$/i.test(G[0].tagName)?{top:0,left:0}:G.offset();J.top-=j(this,"marginTop");J.left-=j(this,"marginLeft");E.top+=j(G,"borderTopWidth");E.left+=j(G,"borderLeftWidth");F={top:J.top-E.top,left:J.left-E.left}}return F},offsetParent:function(){var E=this[0].offsetParent||document.body;while(E&&(!/^body|html$/i.test(E.tagName)&&o.css(E,"position")=="static")){E=E.offsetParent}return o(E)}});o.each(["Left","Top"],function(F,E){var G="scroll"+E;o.fn[G]=function(H){if(!this[0]){return null}return H!==g?this.each(function(){this==l||this==document?l.scrollTo(!F?H:o(l).scrollLeft(),F?H:o(l).scrollTop()):this[G]=H}):this[0]==l||this[0]==document?self[F?"pageYOffset":"pageXOffset"]||o.boxModel&&document.documentElement[G]||document.body[G]:this[0][G]}});o.each(["Height","Width"],function(I,G){var E=I?"Left":"Top",H=I?"Right":"Bottom",F=G.toLowerCase();o.fn["inner"+G]=function(){return this[0]?o.css(this[0],F,false,"padding"):null};o.fn["outer"+G]=function(K){return this[0]?o.css(this[0],F,false,K?"margin":"border"):null};var J=G.toLowerCase();o.fn[J]=function(K){return this[0]==l?document.compatMode=="CSS1Compat"&&document.documentElement["client"+G]||document.body["client"+G]:this[0]==document?Math.max(document.documentElement["client"+G],document.body["scroll"+G],document.documentElement["scroll"+G],document.body["offset"+G],document.documentElement["offset"+G]):K===g?(this.length?o.css(this[0],J):null):this.css(J,typeof K==="string"?K:K+"px")}})})();

// [EOF] for file jquery-1.3.2.min.js

// file: carousel_behavior.js



(function($) { //create closure
    $.fn.agile_carousel = function(options) {
		
        agile_validated = 'fail';
        validate_carousel = function() {
            var p;
            for (p in options) {
                checkme = options[p];
                checkme = checkme.toString();
                checkme = checkme.replace(/<\S+>/g, '');
            }; // for
            agile_validated = 'pass';
        }
		
		var transType = "carousel";
		
		/* L'affichage lag en mode carousel via mozilla */
		if (jQuery.browser.mozilla) {
			transType = "bounce";
		}
		
        validate_carousel();
        if (agile_validated == 'pass') {
            slide_containter_elem = $(this);
            var defaults = {
                disable_on_first_last: "no",
                first_last_buttons: "no",
                first_slide_is_intro: "no",
                hover_next_prev_buttons: "no",
                intro_timer_length: "3000",
                intro_transtion: "no",
                next_prev_buttons: "yes",
                number_slides_visible: "1",
                pause_button: "no",
                slide_buttons: "no",
                slide_captions: "no",
                slide_directory: "slides",
                doctype: "html",
                slide_links: "no",
                slide_number_display: "no",
                timer_length: "7000",
                timer_on: "yes",
                transition_duration: 1000,
                transition_easing: "swing",
                transition_type: transType,//transition_type: "carousel",
                water_mark: "no"
            };
			
			/*
            var opts = $.extend(defaults, options);
            $.ajax({
                type: "POST",
                url: "content.html",
                cache: false,
                data: {
                    first_last_buttons: defaults.first_last_buttons,
                    first_slide_is_intro: defaults.first_slide_is_intro,
                    hover_next_prev_buttons: defaults.hover_next_prev_buttons,
                    next_prev_buttons: defaults.next_prev_buttons,
                    pause_button: defaults.pause_button,
                    slide_buttons: defaults.slide_buttons,
                    slide_captions: defaults.slide_captions,
                    slide_directory: defaults.slide_directory,
                    doctype: defaults.doctype,
                    slide_links: defaults.slide_links,
                    slide_number_display: defaults.slide_number_display,
                    water_mark: defaults.water_mark
                },
                success: function(html) {
                    slide_containter_elem.html(html);

                    if (defaults.first_slide_is_intro == 'yes') {
                        intro();
                    } else {
                        carousel();
                    }
                }
            }); // ajax
			*/

			
            // for intro slide
            function intro() {
                $("#intro").appendTo("#slide_holder_inner");
                $('#slide_1').css("z-index", "1000");
                do_show_1 = function() {
                    $('#slide_1').show();
                };
                show_1 = setTimeout(do_show_1, 300);
                intro_transition = function() {
                    if (defaults.intro_transtion == 'fade') {
                        $('#intro').fadeOut("slow");
                        intro_timer = setTimeout(carousel, 300);
                    } else {
                        $('#intro').hide();
                    } // if
                } // function
                intro_timer = setTimeout("intro_transition()", defaults.intro_timer_length);
            }

            carousel = function() {
                // global variables (evil)
                button_class = "slide_1";
                curr_slide_id = "slide_1";
                curr_slide_id_number = 1;
                next_slide_id_number = 1;
                slideshow_paused = "not_paused";
                transition_type = defaults.transition_type;
                slide_finder = $("#slide_holder_inner div.slide");
                slide_id_array = [];
                slides_index_counter = 0;
                slide_finder.each(function() {
                    slide_id_array[slides_index_counter] = $(this).attr("id");
                    slides_index_counter++;
                });
                slide_captions_array = defaults.slide_captions.split("|");
                slide_height = $('#slide_holder_inner').height();
                half_slide_height_raw = slide_height / 2;
                half_slide_height = parseFloat(half_slide_height_raw);
                slide_holder_width = $(slide_containter_elem).width();
                slide_holder_height = $(slide_containter_elem).height();
                slide_holder_inner_width = $('#slide_holder_inner').width();
                slide_holder_inner_height = $('#slide_holder_inner').height();
                slide_holder_inner_width_px = slide_holder_inner_width + 'px';
                slide_holder_inner_height_px = slide_holder_inner_height + 'px';
                // all_slides_width_raw = slide_holder_inner_width * slide_id_array.length;
                width_per_slide = slide_holder_inner_width / defaults.number_slides_visible;
                width_per_slide = Math.floor(width_per_slide);
                all_slides_width_raw = slide_id_array.length * width_per_slide;
                all_slides_width_raw = Math.floor(all_slides_width_raw);
                all_slides_width = all_slides_width_raw + 'px';
                slide_finder_array_length = slide_finder.length;
                carousel_tranition_number_slides_visible = defaults.carousel_tranition_number_slides_visible;
                num_slides_vis = parseFloat(defaults.number_slides_visible);

                // set up the carousel
                // hide all the slides except slide_1
                $('#intro').remove();
                $('#slide_buttons').show();
                $('#slide_holder_inner div.slide:not(#slide_1)').hide();
                $('#slide_1').css("z-index", "0");
                $('#slide_holder_inner .pause_button').show();
                // initial highlighted and rollover effect for thumb images
                $("#slide_buttons li").removeAttr("id");
                $("#slide_buttons .slide_1").attr("id", "button_selected");
                // disable prev button
                if (defaults.disable_on_first_last == 'yes') {
                    $('.prev_button').attr('class', 'prev_button_disabled');
                }

                Array.prototype.inArray = function(value)
                // Returns true if the passed value is found in the
                // array. Returns false if it is not.
                {
                    var i;
                    for (i = 0; i < this.length; i++) {
                        // Matches identical (===), not just similar (==).
                        if (this[i] === value) {
                            return true;
                        }
                    }
                    return false;
                };
                slide_finder.each(function() {
                    // update slide number display
                    update_slide_number_display = function() {
                        if (defaults.slide_number_display == "yes") {
                            var id_to_split = curr_slide_id;
                            var the_currrent_slide_number_array = id_to_split.split("_");
                            var the_current_slide_number = the_currrent_slide_number_array.pop();
                            $("#slide_number_display span").html(the_current_slide_number + " of" + " <span>" + slide_id_array.length + "</span>");
                            //  $("#slide_number_display span").html(the_current_slide_number);
                        } // if
                    } // update_slide_number_display
                    if (defaults.slide_number_display == "yes") {
                        update_slide_number_display();
                    }
                    // for slide caption display
                } // change_slide_caption
                ) // each
                // pause button 
                pause = function() {
                    if (defaults.timer_on == "yes") {
                        clearInterval(slideshow_timer);
                    };
                    $("#pause_button span").html("play");
                    slideshow_paused = "paused";
                    $("#pause_button").attr("class", "paused_button");
                } // function
                change_slide_caption = function() {
                    if (defaults.slide_captions != "no") {
                        curr_caption = slide_captions_array[curr_slide_id_number - 1];
                        if (curr_caption == null) {
                            curr_caption = "";
                        }
                        $("#slide_captions span").html(curr_caption);
                    } // if
                } // if
                change_slide_caption();

                // for jquery ui effects transition
                if (defaults.transition_type == 'fold') {
                    options_object = {
                        'size': half_slide_height,
                        'easing': defaults.transition_easing
                    }
                } else {
                    options_object = {
                        'easing': defaults.transition_easing
                    };
                }
                if ((defaults.jquery_ui_effect_param != null) && (defaults.jquery_ui_effect_value != null)) {
                    jquery_ui_effect_param = defaults.jquery_ui_effect_param;
                    // handle string vs integer
                    if ((defaults.jquery_ui_effect_param == "distance") || (defaults.jquery_ui_effect_param == "number") || (defaults.jquery_ui_effect_param == "percent") || (defaults.jquery_ui_effect_param == "size") || (defaults.jquery_ui_effect_param == "times") || (defaults.jquery_ui_effect_param == "direction")) {
                        jquery_ui_effect_value = defaults.jquery_ui_effect_value;
                    } else {
                        jquery_ui_effect_value = "'" + defaults.jquery_ui_effect_value + "'";
                    }
                    options_object[jquery_ui_effect_param] = jquery_ui_effect_value;
                }
                // end for jquery ui effects transition
                // for carousel transition - position slides in a row
                if (defaults.transition_type == 'carousel') {
                    $(".slide").show();
                    for (i = 0; i < slide_finder_array_length; i++) {
                        var the_slide = slide_finder[i];
                        var x_pos = (width_per_slide) * i;
                        $(the_slide).css('left', x_pos);
                    } // for
                    $('#row_of_slides').css('width', all_slides_width);
                } // if
                // for carousel transition with multiple slides
                x_position_array = [];
                slidestop_array = [];
                sliced_slidestop_array = [];
                next_slidestop_array = [];
                prev_slidestop_array = [];

                for (i = 0; i < slide_id_array.length; i++) {
                    test_me_for_float = (i) / defaults.number_slides_visible;
                    if (i == 0 || (test_me_for_float == parseInt(test_me_for_float) && test_me_for_float == parseFloat(test_me_for_float))) {
                        var slidestop = 'yes';
                        the_x_pos = width_per_slide * (i) * -1;
                        the_next_slidestop = (1 + i + num_slides_vis);
                        if (the_next_slidestop > slide_id_array.length) {
                            the_next_slidestop = 1;
                        }
                        next_slidestop_array[i] = the_next_slidestop;
                        the_prev_slidestop = (1 + i - num_slides_vis);
                        if (the_prev_slidestop < 1) {
                            the_prev_slidestop = slide_id_array.length - num_slides_vis + 1;
                        }
                        prev_slidestop_array[i] = the_prev_slidestop;
                        next_counter = num_slides_vis - 1;
                        prev_counter = 1;
                    } else {
                        slidestop = 'no';
                        the_next_slidestop = i + 1 + next_counter;
                        if (the_next_slidestop > slide_id_array.length) {
                            the_next_slidestop = 1;
                        }
                        next_slidestop_array[i] = the_next_slidestop;
                        next_counter = next_counter + 1;
                        the_prev_slidestop = i + 1 - prev_counter;
                        if (the_prev_slidestop < 1) {
                            the_prev_slidestop == slide_id_array.length;
                        }
                        if (the_prev_slidestop > slide_id_array.length) {
                            the_prev_slidestop = 1;
                        }
                        prev_slidestop_array[i] = the_prev_slidestop;
                        prev_counter = prev_counter + 1;
                    } // if			
                    x_position_array[i] = the_x_pos;
                    slidestop_array[i] = slidestop;
                } // for
                function carousel_transition() {
                    // create array that stores desired x position per slide
                    $('#row_of_slides').stop().animate({
                        "left": x_position_array[next_slide_id_number - 1]
                    },
                    {
                        "duration": defaults.transition_duration,
                        "easing": defaults.transition_easing
                    });
                }
                // carousel transition
                function fade_transition() {
                    $('#slide_holder_inner div.slide').each(function() {
                        if ($(this).attr('id') != curr_slide_id) {
                            $(this).hide();
                        } // if
                    } // function
                    ) // each
                    $('#slide_holder_inner div[id$="' + curr_slide_id + '"]').css("z-index", "50");
                    $('#slide_holder_inner div[id$="' + button_class + '"]').css("z-index", "100");
                    $('#slide_holder_inner div[id$="' + button_class + '"]').animate({
                        "opacity": "show"
                    },
                    {
                        "duration": defaults.transition_duration,
                        "easing": defaults.transition_easing
                    });
                } //function fade
                function ui_effects_transition() {
                    next_top_show_next = function() {
                        // all divs
                        $('#slide_holder_inner div.slide').show().css('z-index', '20');
                        // next div
                        $('#slide_holder_inner div[id$="' + next_slide_id + '"]').css('z-index', '60');
                        // current div
                        $('#slide_holder_inner div[id$="' + curr_slide_id + '"]').css('z-index', '50');
                        // the transition
                        $('#slide_holder_inner div[id$="' + next_slide_id + '"]').stop().show(defaults.transition_type, options_object, defaults.transition_duration);
                    }
                    next_bottom_hide_curr = function() {
                        // all divs
                        $('#slide_holder_inner div.slide').show().css('z-index', '20');
                        // next div
                        var the_next_div = $('#slide_holder_inner div[id$="' + next_slide_id + '"]').css('z-index', '50');
                        $(the_next_div).css('z-index', '1000');
                        // current div
                        $('#slide_holder_inner div[id$="' + curr_slide_id + '"]').css('z-index', '60');
                        // the transition
                        $('#slide_holder_inner div[id$="' + curr_slide_id + '"]').effect(defaults.transition_type, options_object, defaults.transition_duration);
                    }
                    if (defaults.transition_type == 'blind' || defaults.transition_type == 'bounce' || defaults.transition_type == 'clip' || defaults.transition_type == 'drop' || defaults.transition_type == 'fold' || defaults.transition_type == 'shake' || defaults.transition_type == 'slide' || defaults.transition_type == 'scale' || defaults.transition_type == 'pulsate') {
                        next_top_show_next();
                    } else if (defaults.transition_type == 'explode' || defaults.transition_type == 'puff') {
                        next_bottom_hide_curr();
                    } else {
                        next_top_show_next();
                    }; // if
                } //function
                // scroll right
                function scroll_right_transition() {
                    var slideshow_width = $('#slide_holder_inner').width();
                    var n_slideshow_width = -1 * slideshow_width + 'px';
                    $('#slide_holder_inner div[id$="' + button_class + '"]').stop().show().css("left", n_slideshow_width);
                    $('#slide_holder_inner div[id$="' + button_class + '"]').stop().show().animate({
                        "left": 0
                    },
                    {
                        'easing': defaults.transition_easing
                    },
                    defaults.transition_duration);
                    $('#slide_holder_inner div[id$="' + curr_slide_id + '"]').stop().animate({
                        "left": slideshow_width
                    },
                    {
                        'easing': defaults.transition_easing
                    },
                    defaults.transition_duration);
                } // function
                // no effect transition
                function no_effect_transition() {
                    $('#slide_holder_inner div[id$="' + button_class + '"]').show();
                    $('#slide_holder_inner div[id$="' + curr_slide_id + '"]').hide();
                } // function
                function rotate_slides() {
                    function transition_slides() {
                        // transition slides
                        if (curr_slide_id != button_class) {
                            if (transition_type == 'fade') {
                                fade_transition();
                            } else if (transition_type == 'no_transition_effect') {
                                no_effect_transition();
                            } else if (transition_type == 'scroll_right') {
                                scroll_right_transition();
                            } else if (transition_type == 'carousel') {
                                carousel_transition();
                            } else if (transition_type == 'blind' || transition_type == 'clip' || transition_type == 'drop' || transition_type == 'explode' || transition_type == 'fold' || transition_type == 'puff' || transition_type == 'slide' || transition_type == 'scale' || transition_type == 'pulsate') {
                                ui_effects_transition();
                            } else {
                                no_effect_transition();
                            } // else
                        }; // if
                        curr_slide_id_number = next_slide_id_number;
                        function make_curr_slide_id() {
                            curr_slide_id = button_class;
                        };
                        make_curr_slide_id();
                    } // transition_slides()
                    transition_slides();

                    function animate_slides() {} // animate_slides()
                } // rotate_slides()
                function change_button_class(button_class) {
                    $("#slide_buttons li").removeAttr("id");
                    $("#slide_buttons li").each(function() {
                        if ($(this).attr("class") == button_class) {
                            $(this).attr("id", "button_selected");
                        } // if
                    } // function
                    ); // each
                } // change_button_class
                // functions for pause button
                $(".pause_button").click(function() {
                    if (slideshow_paused == "paused") {
                        // skip to next slide
                        skip('next');
                        if (defaults.timer_on == "yes") {
                            slideshow_timer = setInterval("skip('next')", defaults.timer_length);
                        } //if
                        slideshow_paused = "not_paused";
                        $("#pause_button span").html("pause");
                        $(this).attr("class", "pause_button");
                    } else if (slideshow_paused == "not_paused") {
                        clearInterval(slideshow_timer);
                        slideshow_paused = "paused";
                        $(this).attr("class", "paused_button");
                        pause();
                    }
                } // function
                ) // click
                skip = function(direction) {
                    // identify next slide class
                    curr_slide_id_string = curr_slide_id.toString();
                    split_curr_slide_id_string = curr_slide_id.split("_");
                    curr_slide_id_string = split_curr_slide_id_string.pop();
                    curr_slide_id_number = parseFloat(curr_slide_id_string);
                    if (direction == 'next') {
                        next_slide_id_number = curr_slide_id_number + 1;
                        if (defaults.transition_type == 'carousel') {
                            the_index_to_use = curr_slide_id_number - 1;
                            next_slide_id_number = next_slidestop_array[the_index_to_use];
                        }
                    } else if (direction == 'prev') {
                        next_slide_id_number = curr_slide_id_number - 1;
                        if (defaults.transition_type == 'carousel') {
                            the_index_to_use = curr_slide_id_number - 1;
                            next_slide_id_number = prev_slidestop_array[the_index_to_use];
                        }
                    } else if (direction == 'first') {
                        next_slide_id_number = slide_id_array.length;
                        curr_slide_id_number = 1;
                    } else if (direction == 'last') {
                        next_slide_id_number = 1;
                        curr_slide_id_number = slide_id_array.length;
                    } else {
                        next_slide_id_number = direction;
                    };
                    next_slide_id = "slide_" + next_slide_id_number;
                    // if next slide is after the last slide, then go to first slide
                    if (next_slide_id_number > slide_id_array.length) {
                        next_slide_id = "slide_1";
                        curr_slide_id_number = slide_id_array.length;
                        next_slide_id_number = 1;
                        // if next slide is before the first slide, then go to first slide	
                    } else if (next_slide_id_number < 1) {
                        next_slide_id = "slide_" + slide_id_array.length;
                        next_slide_id_number = slide_id_array.length;
                    } // else 
                    button_class = next_slide_id;
                    // animate to next slide
                    rotate_slides();
                    change_button_class(button_class);
                    if (defaults.slide_number_display == "yes") {
                        update_slide_number_display();
                    }
                    change_slide_caption();
                    // disable first and last buttons
                    if ((defaults.disable_on_first_last == 'yes' && ((next_slide_id_number == slide_id_array.length) || (next_slide_id_number == slide_id_array.length - num_slides_vis + 1)))) {
                        $('#next_button').attr('class', 'next_button_disabled');
                        $('#hover_next_button').attr('class', 'hover_next_buttondisabled');
                        $('#last_button').attr('class', 'last_buttondisabled');
                    } else {
                        $('#next_button').attr('class', 'next_button');
                        $('#hover_next_button').attr('class', 'hover_next_button');
                        $('#last_button').attr('class', 'last_buton');
                    }

                    if ((defaults.disable_on_first_last == 'yes' && ((next_slide_id_number == 1) || (next_slide_id_number == num_slides_vis)))) {
                        $('#prev_button').attr('class', 'prev_button_disabled');
                        $('#hover_prev_button').attr('class', 'hover_prev_button_disabled');
                        $('#first_button').attr('class', 'first_button_disabled');
                    } else {
                        $('#prev_button').attr('class', 'prev_button');
                        $('#hover_prev_button').attr('class', 'hover_prev_button');
                        $('#first_button').attr('class', 'first_button');
                    }
                } //skip
                if (defaults.timer_on == "yes") {
                    slideshow_timer = setInterval("skip('next')", defaults.timer_length);
                } // if
                // functions for clicking slide buttons
                $("#slide_buttons li").each(function() {
                    // add click functionality to buttons
                    $(this).click(function() {
                        button_class = $(this).attr("class");
                        change_button_class(button_class);
                        // declare next_slide_id_number
                        split_button_class_string = button_class.split("_");
                        button_class_string = split_button_class_string.pop();
                        next_slide_id_number = parseFloat(button_class_string);
                        pause();
                        skip(next_slide_id_number);
                        return (false);
                    }); // click
                }); //each
                // remove unused slide buttons for carousel transtion
                if (defaults.transition_type == 'carousel') {
                    $("#slide_buttons li").each(function() {
                        test_the_button_number = $(this).text() - 1;
                        if (slidestop_array[test_the_button_number] == "no") {
                            $(this).remove();
                        } // if
                    } // function
                    ) // each
                } // if
                // functions for clicking prev & next buttons
                // next button
                $(".next_button").click(function() {
                    if (defaults.disable_on_first_last != 'yes') {
                        skip('next');
                        pause();
                    } else if ((defaults.disable_on_first_last == 'yes' && next_slide_id_number == slide_id_array.length) || (next_slide_id_number == (slide_id_array.length - num_slides_vis + 1))) {
                        pause();
                    } else {
                        skip('next');
                        pause();
                    }
                    // if
                } // function
                ); // click	
                $(".prev_button, .prev_button_disabled").click(function() {
                    if (defaults.disable_on_first_last != 'yes') {
                        skip('prev');
                        pause();
                    } else if ((defaults.disable_on_first_last == 'yes' && curr_slide_id_number == 1) || (defaults.disable_on_first_last == 'yes' && next_slide_id_number == num_slides_vis)) {
                        pause();
                    } else {
                        skip('prev');
                        pause();
                    }
                    // if
                } // function
                ); // click	
                if (defaults.hover_next_prev_buttons == "yes") {
                    $(".hover_button").fadeTo(1, 0,
                    function() {
                        $(this).css("display", "block")
                    });
                    $('#hover_prev_button').hover(function() {
                        $("#hover_prev_button").stop().fadeTo("slow", 0.95);
                    },
                    // function
                    function() {
                        $("#hover_prev_button").stop().fadeTo("slow", 0.00);
                    }); // hover
                    $('#hover_next_button').hover(function() {
                        $("#hover_next_button").stop().fadeTo("slow", 0.95);
                    },
                    // function
                    function() {
                        $("#hover_next_button").stop().fadeTo("slow", 0.00);
                    }); // hover
                } // if
                $("#first_button").click(function() {
                    skip('last');
                    pause();
                } // function
                ); // click	
                $("#last_button").click(function() {
                    pause();
                    skip('first');
                } // function
                ); // click	

		
$('.contentDiv').bind('mouseleave', function(){
                        // skip to next slide
                  //      if (defaults.timer_on == "yes") {
                //            slideshow_timer = setInterval("skip('next')", defaults.timer_length);
               //         } //if
            //            slideshow_paused = "not_paused";
              //          $("#pause_button span").html("pause");
          //              $(this).attr("class", "pause_button");
}).bind('mouseover', function(){
		//pause();
});
				
            } // carousel
        
		carousel();
		
		} // if (validation)
    } // function agile_carousel
})(jQuery);

// [EOF] for file carousel_behavior.js

// file: jsonCookies.js

/////////////////////////////////////////////////////////// Ecrit une valeur dans un cookie jsonfunction saveCookieValue(cookieName, key, value) {	if((typeof(key)=="undefined") || (typeof(cookieName)=="undefined")) {		return;	}		if((key.length==0) || (cookieName.length==0)) {		return;	}	var jsonCookie=null;	jsonCookie=Ext.decode($.cookie(cookieName));		if(typeof(jsonCookie)=="undefined") {		jsonCookie={};	}	if(jsonCookie==null) {		jsonCookie={};	}		try{	eval(String.format("jsonCookie.{0}='{1}'", key, value)); 	$.cookie(cookieName, Ext.encode(jsonCookie), {path: '/'});}	catch(e){}}/////////////////////////////////////////////////////////// Lit une valeur dans un cookie jsonfunction getCookieValue(cookieName, key) {	if((typeof(key)=="undefined") || (typeof(cookieName)=="undefined"))	{		return;	}		if(cookieName.length==0) {		return;	}								var jsonCookie=null;	jsonCookie=Ext.decode($.cookie(cookieName));		if(typeof(jsonCookie)=="undefined") {		jsonCookie={};	}		if(jsonCookie==null) {		jsonCookie={};	}		if(key=='') {		return jsonCookie;	}		try{	var value=eval(String.format("jsonCookie.{0}", key));	value=typeof(value)=="undefined"?"":value;	}	catch(e){}			return value;}	

// [EOF] for file jsonCookies.js

// file: cookies.js

/**
 * Cookie plugin
 *
 * Copyright (c) 2006 Klaus Hartl (stilbuero.de)
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 *
 */
jQuery.cookie = function(name, value, options) {
    if (typeof value != 'undefined') { // name and value given, set cookie
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
        }
        // CAUTION: Needed to parenthesize options.path and options.domain
        // in the following expressions, otherwise they evaluate to undefined
        // in the packed version for some reason...
        var path = options.path ? '; path=' + (options.path) : '';
        var domain = options.domain ? '; domain=' + (options.domain) : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else { // only name given, get cookie
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
};

// [EOF] for file cookies.js

// file: jquery.fancybox-1.2.6.pack.js

/*
 * FancyBox - jQuery Plugin
 * simple and fancy lightbox alternative
 *
 * Copyright (c) 2009 Janis Skarnelis
 * Examples and documentation at: http://fancybox.net
 * 
 * Version: 1.2.6 (16/11/2009)
 * Requires: jQuery v1.3+
 * 
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */
 
;eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}(';(p($){$.q.1Q=p(){J O.2n(p(){n b=$(O).u(\'2o\');8(b.1d(/^3i\\(["\']?(.*\\.2p)["\']?\\)$/i)){b=3j.$1;$(O).u({\'2o\':\'3k\',\'1e\':"3l:3m.3n.3o(3p=D, 3q="+($(O).u(\'3r\')==\'2q-3s\'?\'3t\':\'3u\')+", 13=\'"+b+"\')"}).2n(p(){n a=$(O).u(\'1u\');8(a!=\'2r\'&&a!=\'2s\')$(O).u(\'1u\',\'2s\')})}})};n l,4,1f=F,X=1v 1w,1x,1y=1,1z=/\\.(3v|3w|2p|3x|3y)(.*)?$/i;n m=1A,18=$.14.1g&&$.14.2t.1R(0,1)==6&&!19.3z,1S=18||($.14.1g&&$.14.2t.1R(0,1)==7);$.q.r=p(o){n j=$.2u({},$.q.r.2v,o);n k=O;p 2w(){l=O;4=$.2u({},j);2x();J F};p 2x(){8(1f)J;8($.1T(4.1U)){4.1U()}4.v=[];4.t=0;8(j.v.Y>0){4.v=j.v}C{n a={};8(!l.1B||l.1B==\'\'){n a={K:l.K,G:l.G};8($(l).1C("1l:1D").Y){a.S=$(l).1C("1l:1D")}C{a.S=$(l)}8(a.G==\'\'||1V a.G==\'1m\'){a.G=a.S.2y(\'1W\')}4.v.2z(a)}C{n b=$(k).1e("a[1B="+l.1B+"]");n a={};3A(n i=0;i<b.Y;i++){a={K:b[i].K,G:b[i].G};8($(b[i]).1C("1l:1D").Y){a.S=$(b[i]).1C("1l:1D")}C{a.S=$(b[i])}8(a.G==\'\'||1V a.G==\'1m\'){a.G=a.S.2y(\'1W\')}4.v.2z(a)}}}3B(4.v[4.t].K!=l.K){4.t++}8(4.1E){8(18){$(\'1X, 1Y, 1Z\').u(\'21\',\'3C\');$("#T").u(\'A\',$(U).A())}$("#T").u({\'3D-3E\':4.2A,\'22\':4.2B}).Z()}$(19).11("23.L 24.L",$.q.r.2C);1h()};p 1h(){$("#1n, #1o, #1i, #H").1a();n b=4.v[4.t].K;8(b.1d("1j")||l.3F.2D("1j")>=0){$.q.r.1F();1p(\'<1j s="2E" 3G="2F.q.r.2G()" 3H="3I\'+P.1b(P.3J()*3K)+\'" 2H="0" 3L="0" 13="\'+b+\'"></1j>\',4.1G,4.1H)}C 8(b.1d(/#/)){n c=19.3M.K.3N(\'#\')[0];c=b.3O(c,\'\');c=c.1R(c.2D(\'#\'));1p(\'<9 s="3P">\'+$(c).2I()+\'</9>\',4.1G,4.1H)}C 8(b.1d(1z)){X=1v 1w;X.13=b;8(X.3Q){25()}C{$.q.r.1F();$(X).Q().11(\'3R\',p(){$("#M").1a();25()})}}C{$.q.r.1F();$.3S(b,p(a){$("#M").1a();1p(\'<9 s="3T">\'+a+\'</9>\',4.1G,4.1H)})}};p 25(){n a=X.E;n b=X.A;n c=(4.N*2)+40;n d=(4.N*2)+26;n w=$.q.r.1q();8(4.2J&&(a>(w[0]-c)||b>(w[1]-d))){n e=P.28(P.28(w[0]-c,a)/a,P.28(w[1]-d,b)/b);a=P.1b(e*a);b=P.1b(e*b)}1p(\'<1l 1W="" s="3U" 13="\'+X.13+\'" />\',a,b)};p 2K(){8((4.v.Y-1)>4.t){n a=4.v[4.t+1].K||F;8(a&&a.1d(1z)){1I=1v 1w();1I.13=a}}8(4.t>0){n a=4.v[4.t-1].K||F;8(a&&a.1d(1z)){1I=1v 1w();1I.13=a}}};p 1p(a,b,c){1f=D;n d=4.N;8(1S||m){$("#y")[0].15.2L("A");$("#y")[0].15.2L("E")}8(d>0){b+=d*2;c+=d*2;$("#y").u({\'z\':d+\'R\',\'2M\':d+\'R\',\'2N\':d+\'R\',\'B\':d+\'R\',\'E\':\'2O\',\'A\':\'2O\'});8(1S||m){$("#y")[0].15.2P(\'A\',\'(O.2Q.3V - \'+d*2+\')\');$("#y")[0].15.2P(\'E\',\'(O.2Q.3W - \'+d*2+\')\')}}C{$("#y").u({\'z\':0,\'2M\':0,\'2N\':0,\'B\':0,\'E\':\'2R%\',\'A\':\'2R%\'})}8($("#x").16(":V")&&b==$("#x").E()&&c==$("#x").A()){$("#y").1J(\'29\',p(){$("#y").1r().1K($(a)).2a("1L",p(){1s()})});J}n w=$.q.r.1q();n e=(c+26)>w[1]?w[3]:(w[3]+P.1b((w[1]-c-26)*0.5));n f=(b+40)>w[0]?w[2]:(w[2]+P.1b((w[0]-b-40)*0.5));n g={\'B\':f,\'z\':e,\'E\':b+\'R\',\'A\':c+\'R\'};8($("#x").16(":V")){$("#y").1J("1L",p(){$("#y").1r();$("#x").2b(g,4.2S,4.2T,p(){$("#y").1K($(a)).2a("1L",p(){1s()})})})}C{8(4.2c>0&&4.v[4.t].S!==1m){$("#y").1r().1K($(a));n h=4.v[4.t].S;n i=$.q.r.2d(h);$("#x").u({\'B\':(i.B-20-4.N)+\'R\',\'z\':(i.z-20-4.N)+\'R\',\'E\':$(h).E()+(4.N*2),\'A\':$(h).A()+(4.N*2)});8(4.2e){g.22=\'Z\'}$("#x").2b(g,4.2c,4.2U,p(){1s()})}C{$("#y").1a().1r().1K($(a)).Z();$("#x").u(g).2a("1L",p(){1s()})}}};p 2V(){8(4.t!==0){$("#1o, #2W").Q().11("17",p(e){e.2X();4.t--;1h();J F});$("#1o").Z()}8(4.t!=(4.v.Y-1)){$("#1n, #2Y").Q().11("17",p(e){e.2X();4.t++;1h();J F});$("#1n").Z()}};p 1s(){8($.14.1g){$("#y")[0].15.1M(\'1e\');$("#x")[0].15.1M(\'1e\')}2V();2K();$(U).11("1N.L",p(e){8(e.2f==27&&4.2Z){$.q.r.1c()}C 8(e.2f==37&&4.t!==0){$(U).Q("1N.L");4.t--;1h()}C 8(e.2f==39&&4.t!=(4.v.Y-1)){$(U).Q("1N.L");4.t++;1h()}});8(4.30){$("#y").17($.q.r.1c)}8(4.1E&&4.31){$("#T").11("17",$.q.r.1c)}8(4.33){$("#1i").11("17",$.q.r.1c).Z()}8(1V 4.v[4.t].G!==\'1m\'&&4.v[4.t].G.Y>0){n a=$("#x").1u();$(\'#H 9\').3X(4.v[4.t].G).2I();$(\'#H\').u({\'z\':a.z+$("#x").34()-32,\'B\':a.B+(($("#x").35()*0.5)-($(\'#H\').E()*0.5))}).Z()}8(4.1E&&18){$(\'1X, 1Y, 1Z\',$(\'#y\')).u(\'21\',\'V\')}8($.1T(4.2g)){4.2g(4.v[4.t])}8($.14.1g){$("#x")[0].15.1M(\'1e\');$("#y")[0].15.1M(\'1e\')}1f=F};J O.Q(\'17.L\').11(\'17.L\',2w)};$.q.r.2C=p(){n w=$.q.r.1q();8(4.2h&&$("#x").16(\':V\')){n a=$("#x").35();n b=$("#x").34();n c={\'z\':(b>w[1]?w[3]:w[3]+P.1b((w[1]-b)*0.5)),\'B\':(a>w[0]?w[2]:w[2]+P.1b((w[0]-a)*0.5))};$("#x").u(c);$(\'#H\').u({\'z\':c.z+b-32,\'B\':c.B+((a*0.5)-($(\'#H\').E()*0.5))})}8(18&&$("#T").16(\':V\')){$("#T").u({\'A\':$(U).A()})}8($("#M").16(\':V\')){$("#M").u({\'B\':((w[0]-40)*0.5+w[2]),\'z\':((w[1]-40)*0.5+w[3])})}};$.q.r.1t=p(a,b){J 3Y($.3Z(a.41?a[0]:a,b,D))||0};$.q.r.2d=p(a){n b=a.42();b.z+=$.q.r.1t(a,\'43\');b.z+=$.q.r.1t(a,\'44\');b.B+=$.q.r.1t(a,\'45\');b.B+=$.q.r.1t(a,\'46\');J b};$.q.r.2G=p(){$("#M").1a();$("#2E").Z()};$.q.r.1q=p(){J[$(19).E(),$(19).A(),$(U).47(),$(U).48()]};$.q.r.36=p(){8(!$("#M").16(\':V\')){38(1x);J}$("#M > 9").u(\'z\',(1y*-40)+\'R\');1y=(1y+1)%12};$.q.r.1F=p(){38(1x);n w=$.q.r.1q();$("#M").u({\'B\':((w[0]-40)*0.5+w[2]),\'z\':((w[1]-40)*0.5+w[3])}).Z();$("#M").11(\'17\',$.q.r.1c);1x=49($.q.r.36,4a)};$.q.r.1c=p(){1f=D;$(X).Q();$(U).Q("1N.L");$(19).Q("23.L 24.L");$("#T, #y, #1i").Q();$("#1i, #M, #1o, #1n, #H").1a();1O=p(){8($("#T").16(\':V\')){$("#T").1J("29")}$("#y").1r();8(4.2h){$(19).Q("23.L 24.L")}8(18){$(\'1X, 1Y, 1Z\').u(\'21\',\'V\')}8($.1T(4.2i)){4.2i()}1f=F};8($("#x").16(":V")!==F){8(4.2j>0&&4.v[4.t].S!==1m){n a=4.v[4.t].S;n b=$.q.r.2d(a);n c={\'B\':(b.B-20-4.N)+\'R\',\'z\':(b.z-20-4.N)+\'R\',\'E\':$(a).E()+(4.N*2),\'A\':$(a).A()+(4.N*2)};8(4.2e){c.22=\'1a\'}$("#x").3a(F,D).2b(c,4.2j,4.3b,1O)}C{$("#x").3a(F,D).1J(\'29\',1O)}}C{1O()}J F};$.q.r.3c=p(){n a=\'\';a+=\'<9 s="T"></9>\';a+=\'<9 s="M"><9></9></9>\';a+=\'<9 s="x">\';a+=\'<9 s="3d">\';a+=\'<9 s="1i"></9>\';a+=\'<9 s="W"><9 I="W" s="4b"></9><9 I="W" s="4c"></9><9 I="W" s="4d"></9><9 I="W" s="4e"></9><9 I="W" s="4f"></9><9 I="W" s="4g"></9><9 I="W" s="4h"></9><9 I="W" s="4i"></9></9>\';a+=\'<a K="2k:;" s="1o"><1P I="2l" s="2W"></1P></a><a K="2k:;" s="1n"><1P I="2l" s="2Y"></1P></a>\';a+=\'<9 s="y"></9>\';a+=\'</9>\';a+=\'</9>\';a+=\'<9 s="H"></9>\';$(a).3e("4j");$(\'<3f 4k="0" 4l="0" 4m="0"><3g><1k I="H" s="4n"></1k><1k I="H" s="4o"><9></9></1k><1k I="H" s="4p"></1k></3g></3f>\').3e(\'#H\');8($.14.1g){$(".W").1Q()}8(18){$("9#T").u("1u","2r");$("#M 9, #1i, .H, .2l").1Q();$("#3d").4q(\'<1j s="3h" 13="2k:F;" 4r="2q" 2H="0"></1j>\');n b=$(\'#3h\')[0].4s.U;b.4t();b.1c()}};$.q.r.2v={N:10,2J:D,2e:D,2c:0,2j:0,2S:4u,2U:\'2m\',3b:\'2m\',2T:\'2m\',1G:4v,1H:4w,1E:D,2B:0.3,2A:\'#4x\',2Z:D,33:D,31:D,30:D,2h:D,v:[],1U:1A,2g:1A,2i:1A};$(U).4y(p(){m=$.14.1g&&!$.4z;8($("#x").Y<1){$.q.r.3c()}})})(2F);',62,284,'||||opts||||if|div||||||||||||||var||function|fn|fancybox|id|itemCurrent|css|itemArray||fancy_outer|fancy_content|top|height|left|else|true|width|false|title|fancy_title|class|return|href|fb|fancy_loading|padding|this|Math|unbind|px|orig|fancy_overlay|document|visible|fancy_bg|imagePreloader|length|show||bind||src|browser|style|is|click|IE6|window|hide|round|close|match|filter|busy|msie|_change_item|fancy_close|iframe|td|img|undefined|fancy_right|fancy_left|_set_content|getViewport|empty|_finish|getNumeric|position|new|Image|loadingTimer|loadingFrame|imageRegExp|null|rel|children|first|overlayShow|showLoading|frameWidth|frameHeight|objNext|fadeOut|append|normal|removeAttribute|keydown|__cleanup|span|fixPNG|substr|oldIE|isFunction|callbackOnStart|typeof|alt|embed|object|select||visibility|opacity|resize|scroll|_proceed_image|60||min|fast|fadeIn|animate|zoomSpeedIn|getPosition|zoomOpacity|keyCode|callbackOnShow|centerOnScroll|callbackOnClose|zoomSpeedOut|javascript|fancy_ico|swing|each|backgroundImage|png|no|absolute|relative|version|extend|defaults|_initialize|_start|attr|push|overlayColor|overlayOpacity|scrollBox|indexOf|fancy_frame|jQuery|showIframe|frameborder|html|imageScale|_preload_neighbor_images|removeExpression|right|bottom|auto|setExpression|parentNode|100|zoomSpeedChange|easingChange|easingIn|_set_navigation|fancy_left_ico|stopPropagation|fancy_right_ico|enableEscapeButton|hideOnContentClick|hideOnOverlayClick||showCloseButton|outerHeight|outerWidth|animateLoading||clearInterval||stop|easingOut|build|fancy_inner|appendTo|table|tr|fancy_bigIframe|url|RegExp|none|progid|DXImageTransform|Microsoft|AlphaImageLoader|enabled|sizingMethod|backgroundRepeat|repeat|crop|scale|jpg|gif|bmp|jpeg|XMLHttpRequest|for|while|hidden|background|color|className|onload|name|fancy_iframe|random|1000|hspace|location|split|replace|fancy_div|complete|load|get|fancy_ajax|fancy_img|clientHeight|clientWidth|text|parseInt|curCSS||jquery|offset|paddingTop|borderTopWidth|paddingLeft|borderLeftWidth|scrollLeft|scrollTop|setInterval|66|fancy_bg_n|fancy_bg_ne|fancy_bg_e|fancy_bg_se|fancy_bg_s|fancy_bg_sw|fancy_bg_w|fancy_bg_nw|body|cellspacing|cellpadding|border|fancy_title_left|fancy_title_main|fancy_title_right|prepend|scrolling|contentWindow|open|300|560|340|666|ready|boxModel'.split('|'),0,{}));

// [EOF] for file jquery.fancybox-1.2.6.pack.js

// file: hint_plugin.js

/**
* @author Remy Sharp
* @url http://remysharp.com/2007/01/25/jquery-tutorial-text-box-hints/
*/

(function ($) {

$.fn.hint = function (blurClass) {
  if (!blurClass) { 
    blurClass = 'blur';
  }
    
    return this.each(function () {
    // get jQuery version of 'this'
        var $input = $(this),
    
    // capture the rest of the variable to allow for reuse
            title = $input.attr('title'),
            $form = $(this.form),
            $win = $(window);

        function remove() {
      if ($input.val() === title && $input.hasClass(blurClass)) {
                $input.val('').removeClass(blurClass);
            }
        }

        // only apply logic if the element has the attribute
        if (title) { 
            // on blur, set value to title attr if text is blank
            $input.blur(function () {
                if (this.value === '') {
                    $input.val(title).addClass(blurClass);
                }
            }).focus(remove).blur(); // now change all inputs to title
            
            // clear the pre-defined text when form is submitted
            $form.submit(remove);
            $win.unload(remove); // handles Firefox's autocomplete
        }
    });
};

})(jQuery);

// [EOF] for file hint_plugin.js

// file: jquery.media.js

/*
 * jQuery Media Plugin for converting elements into rich media content.
 *
 * Examples and documentation at: http://malsup.com/jquery/media/
 * Copyright (c) 2007-2008 M. Alsup
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 *
 * @author: M. Alsup
 * @version: 0.92 (24-SEP-2009)
 * @requires jQuery v1.1.2 or later
 * $Id: jquery.media.js 2460 2007-07-23 02:53:15Z malsup $
 *
 * Supported Media Players:
 *    - Flash
 *    - Quicktime
 *    - Real Player
 *    - Silverlight
 *    - Windows Media Player
 *    - iframe
 *
 * Supported Media Formats:
 *   Any types supported by the above players, such as:
 *     Video: asf, avi, flv, mov, mpg, mpeg, mp4, qt, smil, swf, wmv, 3g2, 3gp
 *     Audio: aif, aac, au, gsm, mid, midi, mov, mp3, m4a, snd, rm, wav, wma
 *     Other: bmp, html, pdf, psd, qif, qtif, qti, tif, tiff, xaml
 *
 * Thanks to Mark Hicken and Brent Pedersen for helping me debug this on the Mac!
 * Thanks to Dan Rossi for numerous bug reports and code bits!
 * Thanks to Skye Giordano for several great suggestions!
 * Thanks to Richard Connamacher for excellent improvements to the non-IE behavior!
 */
;(function($) {

/**
 * Chainable method for converting elements into rich media.
 *
 * @param options
 * @param callback fn invoked for each matched element before conversion
 * @param callback fn invoked for each matched element after conversion
 */
$.fn.media = function(options, f1, f2) {
	if (options == 'undo') {
		return this.each(function() {
			var $this = $(this);
			var html = $this.data('media.origHTML');
			if (html)
				$this.replaceWith(html);
		});
	}
	
    return this.each(function() {
        if (typeof options == 'function') {
            f2 = f1;
            f1 = options;
            options = {};
        }
        var o = getSettings(this, options);
        // pre-conversion callback, passes original element and fully populated options
        if (typeof f1 == 'function') f1(this, o);

        var r = getTypesRegExp();
        var m = r.exec(o.src.toLowerCase()) || [''];

        o.type ? m[0] = o.type : m.shift();
        for (var i=0; i < m.length; i++) {
            fn = m[i].toLowerCase();
            if (isDigit(fn[0])) fn = 'fn' + fn; // fns can't begin with numbers
            if (!$.fn.media[fn])
                continue;  // unrecognized media type
            // normalize autoplay settings
            var player = $.fn.media[fn+'_player'];
            if (!o.params) o.params = {};
            if (player) {
                var num = player.autoplayAttr == 'autostart';
                o.params[player.autoplayAttr || 'autoplay'] = num ? (o.autoplay ? 1 : 0) : o.autoplay ? true : false;
            }
            var $div = $.fn.media[fn](this, o);

            $div.css('backgroundColor', o.bgColor).width(o.width);
			
			if (o.canUndo) {
				var $temp = $('<div></div>').append(this);
				$div.data('media.origHTML', $temp.html()); // store original markup
			}
			
            // post-conversion callback, passes original element, new div element and fully populated options
            if (typeof f2 == 'function') f2(this, $div[0], o, player.name);
            break;
        }
    });
};

/**
 * Non-chainable method for adding or changing file format / player mapping
 * @name mapFormat
 * @param String format File format extension (ie: mov, wav, mp3)
 * @param String player Player name to use for the format (one of: flash, quicktime, realplayer, winmedia, silverlight or iframe
 */
$.fn.media.mapFormat = function(format, player) {
    if (!format || !player || !$.fn.media.defaults.players[player]) return; // invalid
    format = format.toLowerCase();
    if (isDigit(format[0])) format = 'fn' + format;
    $.fn.media[format] = $.fn.media[player];
    $.fn.media[format+'_player'] = $.fn.media.defaults.players[player];
};

// global defautls; override as needed
$.fn.media.defaults = {
	standards:  false,      // use object tags only (no embeds for non-IE browsers)
	canUndo:    true,       // tells plugin to store the original markup so it can be reverted via: $(sel).mediaUndo()
    width:         400,
    height:        400,
    autoplay:      0,         // normalized cross-player setting
    bgColor:       '#ffffff', // background color
    params:        { wmode: 'transparent'},  // added to object element as param elements; added to embed element as attrs
    attrs:         {},        // added to object and embed elements as attrs
    flvKeyName:    'file',    // key used for object src param (thanks to Andrea Ercolino)
    flashvars:     {},        // added to flash content as flashvars param/attr
    flashVersion:  '7',       // required flash version
    expressInstaller: null,   // src for express installer

    // default flash video and mp3 player (@see: http://jeroenwijering.com/?item=Flash_Media_Player)
    flvPlayer:     'mediaplayer.swf',
    mp3Player:     'mediaplayer.swf',

    // @see http://msdn2.microsoft.com/en-us/library/bb412401.aspx
    silverlight: {
        inplaceInstallPrompt: 'true', // display in-place install prompt?
        isWindowless:         'true', // windowless mode (false for wrapping markup)
        framerate:            '24',   // maximum framerate
        version:              '0.9',  // Silverlight version
        onError:              null,   // onError callback
        onLoad:               null,   // onLoad callback
        initParams:           null,   // object init params
        userContext:          null    // callback arg passed to the load callback
    }
};

// Media Players; think twice before overriding
$.fn.media.defaults.players = {
    flash: {
        name:         'flash',
		title:		 'Flash',
        types:        'flv,mp3,swf',
		mimetype:	 'application/x-shockwave-flash',
		pluginspage: 'http://www.adobe.com/go/getflashplayer',
		ieAttrs: {
            classid:  'clsid:d27cdb6e-ae6d-11cf-96b8-444553540000',
            type:     'application/x-oleobject',
            codebase: 'http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=' + $.fn.media.defaults.flashVersion
        }
    },
    quicktime: {
        name:         'quicktime',
		title:		 'QuickTime',
		mimetype:	 'video/quicktime',
		pluginspage: 'http://www.apple.com/quicktime/download/',
        types:        'aif,aiff,aac,au,bmp,gsm,mov,mid,midi,mpg,mpeg,mp4,m4a,psd,qt,qtif,qif,qti,snd,tif,tiff,wav,3g2,3gp',
		ieAttrs: {
            classid:  'clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B',
            codebase: 'http://www.apple.com/qtactivex/qtplugin.cab'
        }
    },
    realplayer: {
        name:         'real',
		title:		  'RealPlayer',
        types:        'ra,ram,rm,rpm,rv,smi,smil',
		mimetype:	  'audio/x-pn-realaudio-plugin',
		pluginspage:  'http://www.real.com/player/',
        autoplayAttr: 'autostart',
		ieAttrs: {
            classid:  'clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA'
        }
    },
    winmedia: {
        name:         'winmedia',
		title:		  'Windows Media',
        types:        'asx,asf,avi,wma,wmv',
		mimetype:	  $.browser.mozilla && isFirefoxWMPPluginInstalled() ? 'application/x-ms-wmp' : 'application/x-mplayer2',
		pluginspage:  'http://www.microsoft.com/Windows/MediaPlayer/',
        autoplayAttr: 'autostart',
        oUrl:         'url',
		ieAttrs: {
            classid:  'clsid:6BF52A52-394A-11d3-B153-00C04F79FAA6',
            type:     'application/x-oleobject'
        }
    },
    // special cases
    iframe: {
        name:  'iframe',
        types: 'html,pdf'
    },
    silverlight: {
        name:  'silverlight',
        types: 'xaml'
    }
};

//
//  everything below here is private
//


// detection script for FF WMP plugin (http://www.therossman.org/experiments/wmp_play.html)
// (hat tip to Mark Ross for this script)
function isFirefoxWMPPluginInstalled() {
    var plugs = navigator.plugins;
	for (var i = 0; i < plugs.length; i++) {
        var plugin = plugs[i];
        if (plugin['filename'] == 'np-mswmp.dll')
            return true;
    }
    return false;
}

var counter = 1;

for (var player in $.fn.media.defaults.players) {
    var types = $.fn.media.defaults.players[player].types;
    $.each(types.split(','), function(i,o) {
        if (isDigit(o[0])) o = 'fn' + o;
        $.fn.media[o] = $.fn.media[player] = getGenerator(player);
        $.fn.media[o+'_player'] = $.fn.media.defaults.players[player];
    });
};

function getTypesRegExp() {
    var types = '';
    for (var player in $.fn.media.defaults.players) {
        if (types.length) types += ',';
        types += $.fn.media.defaults.players[player].types;
    };
	return new RegExp('\\.(' + types.replace(/,/ig,'|') + ')\\b');
};

function getGenerator(player) {
    return function(el, options) {
        return generate(el, options, player);
    };
};

function isDigit(c) {
    return '0123456789'.indexOf(c) > -1;
};

// flatten all possible options: global defaults, meta, option obj
function getSettings(el, options) {
    options = options || {};
    var $el = $(el);
    var cls = el.className || '';
    // support metadata plugin (v1.0 and v2.0)
    var meta = $.metadata ? $el.metadata() : $.meta ? $el.data() : {};
    meta = meta || {};
    var w = meta.width  || parseInt(((cls.match(/w:(\d+)/)||[])[1]||0));
    var h = meta.height || parseInt(((cls.match(/h:(\d+)/)||[])[1]||0));

    if (w) meta.width  = w;
    if (h) meta.height = h;
    if (cls) meta.cls = cls;

    var a = $.fn.media.defaults;
    var b = options;
    var c = meta;

    var p = { params: { bgColor: options.bgColor || $.fn.media.defaults.bgColor } };
    var opts = $.extend({}, a, b, c);
    $.each(['attrs','params','flashvars','silverlight'], function(i,o) {
        opts[o] = $.extend({}, p[o] || {}, a[o] || {}, b[o] || {}, c[o] || {});
    });

    if (typeof opts.caption == 'undefined') opts.caption = $el.text();

    // make sure we have a source!
    opts.src = opts.src || $el.attr('href') || $el.attr('src') || 'unknown';
    return opts;
};

//
//  Flash Player
//

// generate flash using SWFObject library if possible
$.fn.media.swf = function(el, opts) {
    if (!window.SWFObject && !window.swfobject) {
        // roll our own
        if (opts.flashvars) {
            var a = [];
            for (var f in opts.flashvars)
                a.push(f + '=' + opts.flashvars[f]);
            if (!opts.params) opts.params = {};
            opts.params.flashvars = a.join('&');
        }
        return generate(el, opts, 'flash');
    }

    var id = el.id ? (' id="'+el.id+'"') : '';
    var cls = opts.cls ? (' class="' + opts.cls + '"') : '';
    var $div = $('<div' + id + cls + '>');

    // swfobject v2+
    if (window.swfobject) {
        $(el).after($div).appendTo($div);
        if (!el.id) el.id = 'movie_player_' + counter++;

        // replace el with swfobject content
        swfobject.embedSWF(opts.src, el.id, opts.width, opts.height, opts.flashVersion,
            opts.expressInstaller, opts.flashvars, opts.params, opts.attrs);
    }
    // swfobject < v2
    else {
        $(el).after($div).remove();
        var so = new SWFObject(opts.src, 'movie_player_' + counter++, opts.width, opts.height, opts.flashVersion, opts.bgColor);
        if (opts.expressInstaller) so.useExpressInstall(opts.expressInstaller);

        for (var p in opts.params)
            if (p != 'bgColor') so.addParam(p, opts.params[p]);
        for (var f in opts.flashvars)
            so.addVariable(f, opts.flashvars[f]);
        so.write($div[0]);
    }

    if (opts.caption) $('<div>').appendTo($div).html(opts.caption);
    return $div;
};

// map flv and mp3 files to the swf player by default
$.fn.media.flv = $.fn.media.mp3 = function(el, opts) {
    var src = opts.src;
    var player = /\.mp3\b/i.test(src) ? $.fn.media.defaults.mp3Player : $.fn.media.defaults.flvPlayer;
    var key = opts.flvKeyName;
    src = encodeURIComponent(src);
    opts.src = player;
    opts.src = opts.src + '?'+key+'=' + (src);
    var srcObj = {};
    srcObj[key] = src;
    opts.flashvars = $.extend({}, srcObj, opts.flashvars );
    return $.fn.media.swf(el, opts);
};

//
//  Silverlight
//
$.fn.media.xaml = function(el, opts) {
    if (!window.Sys || !window.Sys.Silverlight) {
        if ($.fn.media.xaml.warning) return;
        $.fn.media.xaml.warning = 1;
        alert('You must include the Silverlight.js script.');
        return;
    }

    var props = {
        width: opts.width,
        height: opts.height,
        background: opts.bgColor,
        inplaceInstallPrompt: opts.silverlight.inplaceInstallPrompt,
        isWindowless: opts.silverlight.isWindowless,
        framerate: opts.silverlight.framerate,
        version: opts.silverlight.version
    };
    var events = {
        onError: opts.silverlight.onError,
        onLoad: opts.silverlight.onLoad
    };

    var id1 = el.id ? (' id="'+el.id+'"') : '';
    var id2 = opts.id || 'AG' + counter++;
    // convert element to div
    var cls = opts.cls ? (' class="' + opts.cls + '"') : '';
    var $div = $('<div' + id1 + cls + '>');
    $(el).after($div).remove();

    Sys.Silverlight.createObjectEx({
        source: opts.src,
        initParams: opts.silverlight.initParams,
        userContext: opts.silverlight.userContext,
        id: id2,
        parentElement: $div[0],
        properties: props,
        events: events
    });

    if (opts.caption) $('<div>').appendTo($div).html(opts.caption);
    return $div;
};

//
// generate object/embed markup
//
function generate(el, opts, player) {
    var $el = $(el);
    var o = $.fn.media.defaults.players[player];

    if (player == 'iframe') {
        var o = $('<iframe' + ' width="' + opts.width + '" height="' + opts.height + '" >');
        o.attr('src', opts.src);
        o.css('backgroundColor', o.bgColor);
    }
    else if ($.browser.msie) {
        var a = ['<object width="' + opts.width + '" height="' + opts.height + '" '];
        for (var key in opts.attrs)
            a.push(key + '="'+opts.attrs[key]+'" ');
		for (var key in o.ieAttrs || {}) {
			var v = o.ieAttrs[key];
			if (key == 'codebase' && window.location.protocol == 'https:')
                v = v.replace('http','https');
            a.push(key + '="'+v+'" ');
        }
        a.push('></ob'+'ject'+'>');
        var p = ['<param name="' + (o.oUrl || 'src') +'" value="' + opts.src + '">'];
        for (var key in opts.params)
            p.push('<param name="'+ key +'" value="' + opts.params[key] + '">');
        var o = document.createElement(a.join(''));
        for (var i=0; i < p.length; i++)
            o.appendChild(document.createElement(p[i]));
    }
	else if (o.standards) {
		// Rewritten to be standards compliant by Richard Connamacher
		var a = ['<object type="' + o.mimetype +'" width="' + opts.width + '" height="' + opts.height +'"'];
		if (opts.src) a.push(' data="' + opts.src + '" ');
		a.push('>');
		a.push('<param name="' + (o.oUrl || 'src') +'" value="' + opts.src + '">');
		for (var key in opts.params) {
			if (key == 'wmode' && player != 'flash') // FF3/Quicktime borks on wmode
				continue;
			a.push('<param name="'+ key +'" value="' + opts.params[key] + '">');
		}
		// Alternate HTML
		a.push('<div><p><strong>'+o.title+' Required</strong></p><p>'+o.title+' is required to view this media. <a href="'+o.pluginspage+'">Download Here</a>.</p></div>');
		a.push('</ob'+'ject'+'>');
	}
    else {
        var a = ['<embed width="' + opts.width + '" height="' + opts.height + '" style="display:block"'];
        if (opts.src) a.push(' src="' + opts.src + '" ');
        for (var key in opts.attrs)
            a.push(key + '="'+opts.attrs[key]+'" ');
        for (var key in o.eAttrs || {})
            a.push(key + '="'+o.eAttrs[key]+'" ');
	        for (var key in opts.params) {
	            if (key == 'wmode' && player != 'flash') // FF3/Quicktime borks on wmode
	            	continue;
                a.push(key + '="'+opts.params[key]+'" ');
	        }
        a.push('></em'+'bed'+'>');
    }
    // convert element to div
    var id = el.id ? (' id="'+el.id+'"') : '';
    var cls = opts.cls ? (' class="' + opts.cls + '"') : '';
    var $div = $('<div' + id + cls + '>');
    $el.after($div).remove();
    ($.browser.msie || player == 'iframe') ? $div.append(o) : $div.html(a.join(''));
    if (opts.caption) $('<div>').appendTo($div).html(opts.caption);
    return $div;
};


})(jQuery);


// [EOF] for file jquery.media.js

// file: pngFix.js

/**
 * --------------------------------------------------------------------
 * jQuery-Plugin "pngFix"
 * Version: 1.1, 11.09.2007
 * by Andreas Eberhard, andreas.eberhard@gmail.com
 *                      http://jquery.andreaseberhard.de/
 *
 * Copyright (c) 2007 Andreas Eberhard
 * Licensed under GPL (http://www.opensource.org/licenses/gpl-license.php)
 *
 * Changelog:
 *    11.09.2007 Version 1.1
 *    - removed noConflict
 *    - added png-support for input type=image
 *    - 01.08.2007 CSS background-image support extension added by Scott Jehl, scott@filamentgroup.com, http://www.filamentgroup.com
 *    31.05.2007 initial Version 1.0
 * --------------------------------------------------------------------
 * @example $(function(){$(document).pngFix();});
 * @desc Fixes all PNG's in the document on document.ready
 *
 * jQuery(function(){jQuery(document).pngFix();});
 * @desc Fixes all PNG's in the document on document.ready when using noConflict
 *
 * @example $(function(){$('div.examples').pngFix();});
 * @desc Fixes all PNG's within div with class examples
 *
 * @example $(function(){$('div.examples').pngFix( { blankgif:'ext.gif' } );});
 * @desc Fixes all PNG's within div with class examples, provides blank gif for input with png
 * --------------------------------------------------------------------
 */

(function($) {

jQuery.fn.pngFix = function(settings) {

	// Settings
	settings = jQuery.extend({
		blankgif: 'blank.gif'
	}, settings);

	var ie55 = (navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion) == 4 && navigator.appVersion.indexOf("MSIE 5.5") != -1);
	var ie6 = (navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion) == 4 && navigator.appVersion.indexOf("MSIE 6.0") != -1);
	var ie7 = (navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion) == 4 && navigator.appVersion.indexOf("MSIE 7.0") != -1);

	if (false && jQuery.browser.msie && (ie55 || ie6) && !ie7) {

		//fix images with png-source
		jQuery(this).find("img[src$=.png]").each(function() {

			jQuery(this).attr('width',jQuery(this).width());
			jQuery(this).attr('height',jQuery(this).height());

			var prevStyle = '';
			var strNewHTML = '';
			var imgId = (jQuery(this).attr('id')) ? 'id="' + jQuery(this).attr('id') + '" ' : '';
			var imgClass = (jQuery(this).attr('class')) ? 'class="' + jQuery(this).attr('class') + '" ' : '';
			var imgTitle = (jQuery(this).attr('title')) ? 'title="' + jQuery(this).attr('title') + '" ' : '';
			var imgAlt = (jQuery(this).attr('alt')) ? 'alt="' + jQuery(this).attr('alt') + '" ' : '';
			var imgAlign = (jQuery(this).attr('align')) ? 'float:' + jQuery(this).attr('align') + ';' : '';
			var imgHand = (jQuery(this).parent().attr('href')) ? 'cursor:hand;' : '';
			if (this.style.border) {
				prevStyle += 'border:'+this.style.border+';';
				this.style.border = '';
			}
			if (this.style.padding) {
				prevStyle += 'padding:'+this.style.padding+';';
				this.style.padding = '';
			}
			if (this.style.margin) {
				prevStyle += 'margin:'+this.style.margin+';';
				this.style.margin = '';
			}
			var imgStyle = (this.style.cssText);

			strNewHTML += '<span '+imgId+imgClass+imgTitle+imgAlt;
			strNewHTML += 'style="position:relative;white-space:pre-line;display:inline-block;background:transparent;'+imgAlign+imgHand;
			strNewHTML += 'width:' + jQuery(this).width() + 'px;' + 'height:' + jQuery(this).height() + 'px;';
			strNewHTML += 'filter:progid:DXImageTransform.Microsoft.AlphaImageLoader' + '(src=\'' + jQuery(this).attr('src') + '\', sizingMethod=\'scale\');';
			strNewHTML += imgStyle+'"></span>';
			if (prevStyle != ''){
				strNewHTML = '<span style="position:relative;display:inline-block;'+prevStyle+imgHand+'width:' + jQuery(this).width() + 'px;' + 'height:' + jQuery(this).height() + 'px;'+'">' + strNewHTML + '</span>';
			}

			jQuery(this).hide();
			jQuery(this).after(strNewHTML);

		});

		// fix css background pngs
		jQuery(this).find("*").each(function(){
			var bgIMG = jQuery(this).css('background-image');
			if(bgIMG.indexOf(".png")!=-1){
				var iebg = bgIMG.split('url("')[1].split('")')[0];
				jQuery(this).css('background-image', 'none');
				jQuery(this).get(0).runtimeStyle.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + iebg + "',sizingMethod='scale')";
			}
		});
		
		//fix input with png-source
		jQuery(this).find("input[src$=.png]").each(function() {
			var bgIMG = jQuery(this).attr('src');
			jQuery(this).get(0).runtimeStyle.filter = 'progid:DXImageTransform.Microsoft.AlphaImageLoader' + '(src=\'' + bgIMG + '\', sizingMethod=\'scale\');';
   		jQuery(this).attr('src', settings.blankgif)
		});
	
	}
	
	return jQuery;

};

})(jQuery);


// [EOF] for file pngFix.js

// file: SearchHighlight.js

/**
 * SearchHighlight plugin for jQuery
 * 
 * Thanks to Scott Yang <http://scott.yang.id.au/>
 * for the original idea and some code
 *    
 * @author Renato Formato <renatoformato@virgilio.it> 
 *  
 * @version 0.33
 *
 *  Options
 *  - exact (string, default:"exact") 
 *    "exact" : find and highlight the exact words.
 *    "whole" : find partial matches but highlight whole words
 *    "partial": find and highlight partial matches
 *     
 *  - style_name (string, default:'hilite')
 *    The class given to the span wrapping the matched words.
 *     
 *  - style_name_suffix (boolean, default:true)
 *    If true a different number is added to style_name for every different matched word.
 *     
 *  - debug_referrer (string, default:null)
 *    Set a referrer for debugging purpose.
 *     
 *  - engines (array of regex, default:null)
 *    Add a new search engine regex to highlight searches coming from new search engines.
 *    The first element is the regex to match the domain.
 *    The second element is the regex to match the query string. 
 *    Ex: [/^http:\/\/my\.site\.net/i,/search=([^&]+)/i]        
 *            
 *  - highlight (string, default:null)
 *    A jQuery selector or object to set the elements enabled for highlight.
 *    If null or no elements are found, all the document is enabled for highlight.
 *        
 *  - nohighlight (string, default:null)  
 *    A jQuery selector or object to set the elements not enabled for highlight.
 *    This option has priority on highlight. 
 *    
 *  - keys (string, default:null)
 *    Disable the analisys of the referrer and search for the words given as argument    
 *    
 */

(function($){
  jQuery.fn.SearchHighlight = function(options) {
    var ref = options.debug_referrer || document.referrer;
    if(!ref && options.keys==undefined) return this;
    
    SearchHighlight.options = $.extend({exact:"exact",style_name:'hilite',style_name_suffix:true},options);
    
    if(options.engines) SearchHighlight.engines.unshift(options.engines);  
    var q = options.keys!=undefined?options.keys.toLowerCase().split(/[\s,\+\.]+/):SearchHighlight.decodeURL(ref,SearchHighlight.engines);
    if(q && q.join("")) {
      SearchHighlight.buildReplaceTools(q);
      return this.each(function(){
        var el = this;
        if(el==document) el = $("body")[0];
        SearchHighlight.hiliteElement(el, q); 
      })
    } else return this;
  }    

  var SearchHighlight = {
    options: {},
    regex: [],
    engines: [
    [/^http:\/\/(www\.)?google\./i, /q=([^&]+)/i],                            // Google
    [/^http:\/\/(www\.)?search\.yahoo\./i, /p=([^&]+)/i],                     // Yahoo
    [/^http:\/\/(www\.)?search\.msn\./i, /q=([^&]+)/i],                       // MSN
    [/^http:\/\/(www\.)?search\.live\./i, /query=([^&]+)/i],                  // MSN Live
    [/^http:\/\/(www\.)?search\.aol\./i, /userQuery=([^&]+)/i],               // AOL
    [/^http:\/\/(www\.)?ask\.com/i, /q=([^&]+)/i],                            // Ask.com
    [/^http:\/\/(www\.)?altavista\./i, /q=([^&]+)/i],                         // AltaVista
    [/^http:\/\/(www\.)?feedster\./i, /q=([^&]+)/i],                          // Feedster
    [/^http:\/\/(www\.)?search\.lycos\./i, /q=([^&]+)/i],                     // Lycos
    [/^http:\/\/(www\.)?alltheweb\./i, /q=([^&]+)/i],                         // AllTheWeb
    [/^http:\/\/(www\.)?technorati\.com/i, /([^\?\/]+)(?:\?.*)$/i],           // Technorati
    ],
    subs: {},
    decodeURL: function(URL,reg) {
      URL = decodeURIComponent(URL);
      var query = null;
      $.each(reg,function(i,n){
        if(n[0].test(URL)) {
          var match = URL.match(n[1]);
          if(match) {
            query = match[1].toLowerCase();
            return false;
          }
        }
      })
      
      if (query) {
      query = query.replace(/(\'|")/, '\$1');
      query = query.split(/[\s,\+\.]+/);
      }
      
      return query;
    },
		regexAccent : [
      [/[\xC0-\xC5\u0100-\u0105]/ig,'a'],
      [/[\xC7\u0106-\u010D]/ig,'c'],
      [/[\xC8-\xCB]/ig,'e'],
      [/[\xCC-\xCF]/ig,'i'],
      [/\xD1/ig,'n'],
      [/[\xD2-\xD6\xD8]/ig,'o'],
      [/[\u015A-\u0161]/ig,'s'],
      [/[\u0162-\u0167]/ig,'t'],
      [/[\xD9-\xDC]/ig,'u'],
      [/\xFF/ig,'y'],
      [/[\x91\x92\u2018\u2019]/ig,'\'']
    ],
    matchAccent : /[\x91\x92\xC0-\xC5\xC7-\xCF\xD1-\xD6\xD8-\xDC\xFF\u0100-\u010D\u015A-\u0167\u2018\u2019]/ig,  
		replaceAccent: function(q) {
		  SearchHighlight.matchAccent.lastIndex = 0;
      if(SearchHighlight.matchAccent.test(q)) {
        for(var i=0,l=SearchHighlight.regexAccent.length;i<l;i++)
          q = q.replace(SearchHighlight.regexAccent[i][0],SearchHighlight.regexAccent[i][1]);
      }
      return q;
    },
    escapeRegEx : /((?:\\{2})*)([[\]{}*?|])/g, //the special chars . and + are already gone at this point because they are considered split chars
    buildReplaceTools : function(query) {
        var re = [], regex;
        $.each(query,function(i,n){
            if(n = SearchHighlight.replaceAccent(n).replace(SearchHighlight.escapeRegEx,"$1\\$2"))
              re.push(n);        
        });
        
        regex = re.join("|");
        switch(SearchHighlight.options.exact) {
          case "exact":
            regex = '\\b(?:'+regex+')\\b';
            break;
          case "whole":
            regex = '\\b\\w*('+regex+')\\w*\\b';
            break;
        }    
        SearchHighlight.regex = new RegExp(regex, "gi");
        
        $.each(re,function(i,n){
            SearchHighlight.subs[n] = SearchHighlight.options.style_name+
              (SearchHighlight.options.style_name_suffix?i+1:''); 
        });       
    },
    nosearch: /s(?:cript|tyle)|textarea/i,
    hiliteElement: function(el, query) {
        var opt = SearchHighlight.options, elHighlight, noHighlight;
        elHighlight = opt.highlight?$(opt.highlight):$("body"); 
        if(!elHighlight.length) elHighlight = $("body"); 
        noHighlight = opt.nohighlight?$(opt.nohighlight):$([]);
                
        elHighlight.each(function(){
          SearchHighlight.hiliteTree(this,query,noHighlight);
        });
    },
    hiliteTree : function(el,query,noHighlight) {
        if(noHighlight.index(el)!=-1) return;
        var matchIndex = SearchHighlight.options.exact=="whole"?1:0;
        for(var startIndex=0,endIndex=el.childNodes.length;startIndex<endIndex;startIndex++) {
          var item = el.childNodes[startIndex];
          if ( item.nodeType != 8 ) {//comment node
  				  //text node
            if(item.nodeType==3) {
              var text = item.data, textNoAcc = SearchHighlight.replaceAccent(text);
              var newtext="",match,index=0;
              SearchHighlight.regex.lastIndex = 0;
              while(match = SearchHighlight.regex.exec(textNoAcc)) {
                newtext += text.substr(index,match.index-index)+'<span class="'+
                SearchHighlight.subs[match[matchIndex].toLowerCase()]+'">'+text.substr(match.index,match[0].length)+"</span>";
                index = match.index+match[0].length;
              }
              if(newtext) {
                //add the last part of the text
                newtext += text.substring(index);
                var repl = $.merge([],$("<span>"+newtext+"</span>")[0].childNodes);
                endIndex += repl.length-1;
                startIndex += repl.length-1;
                $(item).before(repl).remove();
              }                
            } else {
              if(item.nodeType==1 && item.nodeName.search(SearchHighlight.nosearch)==-1)
                  SearchHighlight.hiliteTree(item,query,noHighlight);
            }	
          }
        }    
    }
  };
})(jQuery)


// [EOF] for file SearchHighlight.js

// file: thickbox.js

/*
 * Thickbox 3.1 - One Box To Rule Them All.
 * By Cody Lindley (http://www.codylindley.com)
 * Copyright (c) 2007 cody lindley
 * Licensed under the MIT License: http://www.opensource.org/licenses/mit-license.php
*/
		  
var tb_pathToImage = "/Plugins/BAM/Packages/BAM_JQUERY_ALL/DATA/loadingAnimation.gif";

/*!!!!!!!!!!!!!!!!! edit below this line at your own risk !!!!!!!!!!!!!!!!!!!!!!!*/

//on page load call tb_init
$(document).ready(function(){   
	//tb_init('a.thickbox, area.thickbox, input.thickbox');//pass where to apply thickbox
	tb_init('a.thickbox');//pass where to apply thickbox
	imgLoader = new Image();// preload image
	imgLoader.src = tb_pathToImage;
});

//add thickbox to href & area elements that have a class of .thickbox
function tb_init(domChunk){
	$(domChunk).click(function(){
	var t = this.title || this.name || null;
	var a = this.href || this.alt;
	var g = this.rel || false;
	tb_show(t,a,g);
	this.blur();
	return false;
	});
}

function tb_show(caption, url, imageGroup) {//function called when the user clicks on a thickbox link

	try {
		if (typeof document.body.style.maxHeight === "undefined") {//if IE 6
			$("body","html").css({height: "100%", width: "100%"});
			$("html").css("overflow","hidden");
			if (document.getElementById("TB_HideSelect") === null) {//iframe to hide select elements in ie6
				$("body").append("<iframe id='TB_HideSelect'></iframe><div id='TB_overlay'></div><div id='TB_window'></div>");
				$("#TB_overlay").click(tb_remove);
			}
		}else{//all others
			if(document.getElementById("TB_overlay") === null){
				$("body").append("<div id='TB_overlay'></div><div id='TB_window'></div>");
				$("#TB_overlay").click(tb_remove);
			}
		}
		
		if(tb_detectMacXFF()){
			$("#TB_overlay").addClass("TB_overlayMacFFBGHack");//use png overlay so hide flash
		}else{
			$("#TB_overlay").addClass("TB_overlayBG");//use background and opacity
		}
		
		if(caption===null){caption="";}
		$("body").append("<div id='TB_load'><img src='"+imgLoader.src+"' /></div>");//add loader to the page
		$('#TB_load').show();//show loader
		
		var baseURL;
	   if(url.indexOf("?")!==-1){ //ff there is a query string involved
			baseURL = url.substr(0, url.indexOf("?"));
	   }else{ 
	   		baseURL = url;
	   }
	   
	   var urlString = /\.jpg$|\.jpeg$|\.png$|\.gif$|\.bmp$|\.ashx$/;
	   var urlType = baseURL.toLowerCase().match(urlString);

		if(urlType == '.jpg' || urlType == '.jpeg' || urlType == '.png' || urlType == '.gif' || urlType == '.bmp' || urlType == '.ashx'){//code to show images
				
			TB_PrevCaption = "";
			TB_PrevURL = "";
			TB_PrevHTML = "";
			TB_NextCaption = "";
			TB_NextURL = "";
			TB_NextHTML = "";
			TB_imageCount = "";
			TB_FoundURL = false;
			if(imageGroup){
				TB_TempArray = $("a[rel="+imageGroup+"]").get();
				for (TB_Counter = 0; ((TB_Counter < TB_TempArray.length) && (TB_NextHTML === "")); TB_Counter++) {
					var urlTypeTemp = TB_TempArray[TB_Counter].href.toLowerCase().match(urlString);
						if (!(TB_TempArray[TB_Counter].href == url)) {						
							if (TB_FoundURL) {
								TB_NextCaption = TB_TempArray[TB_Counter].title;
								TB_NextURL = TB_TempArray[TB_Counter].href;
								TB_NextHTML = "<span id='TB_next'>&nbsp;&nbsp;<a href='#'>Next &gt;</a></span>";
							} else {
								TB_PrevCaption = TB_TempArray[TB_Counter].title;
								TB_PrevURL = TB_TempArray[TB_Counter].href;
								TB_PrevHTML = "<span id='TB_prev'>&nbsp;&nbsp;<a href='#'>&lt; Prev</a></span>";
							}
						} else {
							TB_FoundURL = true;
							TB_imageCount = "Image " + (TB_Counter + 1) +" of "+ (TB_TempArray.length);											
						}
				}
			}

			imgPreloader = new Image();
			imgPreloader.onload = function(){		
			imgPreloader.onload = null;
				
			// Resizing large images - orginal by Christian Montoya edited by me.
			var pagesize = tb_getPageSize();
			var x = pagesize[0] - 150;
			var y = pagesize[1] - 150;
			var imageWidth = imgPreloader.width;
			var imageHeight = imgPreloader.height;
			if (imageWidth > x) {
				imageHeight = imageHeight * (x / imageWidth); 
				imageWidth = x; 
				if (imageHeight > y) { 
					imageWidth = imageWidth * (y / imageHeight); 
					imageHeight = y; 
				}
			} else if (imageHeight > y) { 
				imageWidth = imageWidth * (y / imageHeight); 
				imageHeight = y; 
				if (imageWidth > x) { 
					imageHeight = imageHeight * (x / imageWidth); 
					imageWidth = x;
				}
			}
			// End Resizing
			
			TB_WIDTH = imageWidth + 30;
			TB_HEIGHT = imageHeight + 60;
			$("#TB_window").append("<a href='' id='TB_ImageOff' title='Close'><img id='TB_Image' src='"+url+"' width='"+imageWidth+"' height='"+imageHeight+"' alt='"+caption+"'/></a>" + "<div id='TB_caption'>"+caption+"<div id='TB_secondLine'>" + TB_imageCount + TB_PrevHTML + TB_NextHTML + "</div></div><div id='TB_closeWindow'><a href='#' id='TB_closeWindowButton' title='Close'>Fermez</a> ou appuyez sur 'echappe'</div>"); 		
			
			$("#TB_closeWindowButton").click(tb_remove);
			
			if (!(TB_PrevHTML === "")) {
				function goPrev(){
					if($(document).unbind("click",goPrev)){$(document).unbind("click",goPrev);}
					$("#TB_window").remove();
					$("body").append("<div id='TB_window'></div>");
					tb_show(TB_PrevCaption, TB_PrevURL, imageGroup);
					return false;	
				}
				$("#TB_prev").click(goPrev);
			}
			
			if (!(TB_NextHTML === "")) {		
				function goNext(){
					$("#TB_window").remove();
					$("body").append("<div id='TB_window'></div>");
					tb_show(TB_NextCaption, TB_NextURL, imageGroup);				
					return false;	
				}
				$("#TB_next").click(goNext);
				
			}

			document.onkeydown = function(e){ 	
				if (e == null) { // ie
					keycode = event.keyCode;
				} else { // mozilla
					keycode = e.which;
				}
				if(keycode == 27){ // close
					tb_remove();
				} else if(keycode == 190){ // display previous image
					if(!(TB_NextHTML == "")){
						document.onkeydown = "";
						goNext();
					}
				} else if(keycode == 188){ // display next image
					if(!(TB_PrevHTML == "")){
						document.onkeydown = "";
						goPrev();
					}
				}	
			};
			
			tb_position();
			$("#TB_load").remove();
			$("#TB_ImageOff").click(tb_remove);
			$("#TB_window").css({display:"block"}); //for safari using css instead of show
			};
			
			imgPreloader.src = url;
		}else{//code to show html
			
			var queryString = url.replace(/^[^\?]+\??/,'');
			var params = tb_parseQuery( queryString );

			TB_WIDTH = (params['width']*1) + 30 || 630; //defaults to 630 if no paramaters were added to URL
			TB_HEIGHT = (params['height']*1) + 40 || 440; //defaults to 440 if no paramaters were added to URL
			ajaxContentW = TB_WIDTH - 30;
			ajaxContentH = TB_HEIGHT - 45;
			
			if(url.indexOf('TB_iframe') != -1){// either iframe or ajax window		
					urlNoQuery = url.split('TB_');
					$("#TB_iframeContent").remove();
					if(params['modal'] != "true"){//iframe no modal
						$("#TB_window").append("<div id='TB_title'><div id='TB_ajaxWindowTitle'>"+caption+"</div><div id='TB_closeAjaxWindow'><a href='#' id='TB_closeWindowButton' title='Fermer'>Fermer</a></div></div><iframe frameborder='0' hspace='0' src='"+urlNoQuery[0]+"' id='TB_iframeContent' name='TB_iframeContent"+Math.round(Math.random()*1000)+"' onload='tb_showIframe()' style='width:"+(ajaxContentW + 29)+"px;height:"+(ajaxContentH + 17)+"px;' > </iframe>");
					}else{//iframe modal
					$("#TB_overlay").unbind();
						$("#TB_window").append("<iframe frameborder='0' hspace='0' src='"+urlNoQuery[0]+"' id='TB_iframeContent' name='TB_iframeContent"+Math.round(Math.random()*1000)+"' onload='tb_showIframe()' style='width:"+(ajaxContentW + 29)+"px;height:"+(ajaxContentH + 17)+"px;'> </iframe>");
					}
			}else{// not an iframe, ajax
					if($("#TB_window").css("display") != "block"){
						if(params['modal'] != "true"){//ajax no modal
						$("#TB_window").append("<div id='TB_title'><div id='TB_ajaxWindowTitle'>"+caption+"</div><div id='TB_closeAjaxWindow'><a href='#' id='TB_closeWindowButton'>Fermer</a></div></div><div id='TB_ajaxContent' style='width:"+ajaxContentW+"px;height:"+ajaxContentH+"px'></div>");
						}else{//ajax modal
						$("#TB_overlay").unbind();
						$("#TB_window").append("<div id='TB_ajaxContent' class='TB_modal' style='width:"+ajaxContentW+"px;height:"+ajaxContentH+"px;'></div>");	
						}
					}else{//this means the window is already up, we are just loading new content via ajax
						$("#TB_ajaxContent")[0].style.width = ajaxContentW +"px";
						$("#TB_ajaxContent")[0].style.height = ajaxContentH +"px";
						$("#TB_ajaxContent")[0].scrollTop = 0;
						$("#TB_ajaxWindowTitle").html(caption);
					}
			}
					
			$("#TB_closeWindowButton").click(tb_remove);
			
				if(url.indexOf('TB_inline') != -1){	
					$("#TB_ajaxContent").append($('#' + params['inlineId']).children());
					$("#TB_window").unload(function () {
						$('#' + params['inlineId']).append( $("#TB_ajaxContent").children() ); // move elements back when you're finished
					});
					tb_position();
					$("#TB_load").remove();
					$("#TB_window").css({display:"block"}); 
				}else if(url.indexOf('TB_iframe') != -1){
					tb_position();
					if($.browser.safari){//safari needs help because it will not fire iframe onload
						$("#TB_load").remove();
						$("#TB_window").css({display:"block"});
					}
				}else{
					$("#TB_ajaxContent").load(url += "&random=" + (new Date().getTime()),function(){//to do a post change this load method
						tb_position();
						$("#TB_load").remove();
						tb_init("#TB_ajaxContent a.thickbox");
						$("#TB_window").css({display:"block"});
					});
				}
			
		}

		if(!params['modal']){
			document.onkeyup = function(e){ 	
				if (e == null) { // ie
					keycode = event.keyCode;
				} else { // mozilla
					keycode = e.which;
				}
				if(keycode == 27){ // close
					tb_remove();
				}	
			};
		}
		
	} catch(e) {
		//nothing here
	}
}

//helper functions below
function tb_showIframe(){
	$("#TB_load").remove();
	$("#TB_window").css({display:"block"});
}

function tb_remove() {
 	$("#TB_imageOff").unbind("click");
	$("#TB_closeWindowButton").unbind("click");
	$("#TB_window").fadeOut("fast",function(){$('#TB_window,#TB_overlay,#TB_HideSelect').trigger("unload").unbind().remove();});
	$("#TB_load").remove();
	if (typeof document.body.style.maxHeight == "undefined") {//if IE 6
		$("body","html").css({height: "auto", width: "auto"});
		$("html").css("overflow","");
	}
	document.onkeydown = "";
	document.onkeyup = "";
	return false;
}

function tb_position() { // hot fixed for microsuck internet exploiter
  jQuery("#TB_window").css({marginLeft: '-' + parseInt((TB_WIDTH /2),
10) + 'px', width: TB_WIDTH + 'px'});
  var dtop=parseInt((TB_HEIGHT / 2),10);
  var scrolledDown=0;
  if(jQuery.browser.msie){//ie hax
    if(document.body != null){
      scrolledDown=document.body.scrollTop;
    }
    else if(document.documentElement != null){
      scrolledDown = document.documentElement.scrollTop; //ie7
    }
  }
  if(scrolledDown){
    jQuery("#TB_window").css({marginTop: '+' + scrolledDown + 'px'});
  }
  else{
    jQuery("#TB_window").css({marginTop: '-' + dtop + 'px'});
  }
}

function tb_parseQuery ( query ) {
   var Params = {};
   if ( ! query ) {return Params;}// return empty object
   var Pairs = query.split(/[;&]/);
   for ( var i = 0; i < Pairs.length; i++ ) {
      var KeyVal = Pairs[i].split('=');
      if ( ! KeyVal || KeyVal.length != 2 ) {continue;}
      var key = unescape( KeyVal[0] );
      var val = unescape( KeyVal[1] );
      val = val.replace(/\+/g, ' ');
      Params[key] = val;
   }
   return Params;
}

function tb_getPageSize(){
	var de = document.documentElement;
	var w = window.innerWidth || self.innerWidth || (de&&de.clientWidth) || document.body.clientWidth;
	var h = window.innerHeight || self.innerHeight || (de&&de.clientHeight) || document.body.clientHeight;
	arrayPageSize = [w,h];
	return arrayPageSize;
}

function tb_detectMacXFF() {
  var userAgent = navigator.userAgent.toLowerCase();
  if (userAgent.indexOf('mac') != -1 && userAgent.indexOf('firefox')!=-1) {
    return true;
  }
}




// [EOF] for file thickbox.js

// file: jquery.AcsTooltip.js


/*
 * Archimed - Culture & Savoir
 * Tooltip v0.1a (02/03/2010)
 * A jQuery tooltip plugin
 * Copyright (c) 2010 Archimed
 *
 * Aur?lien Dolande
 * dolande@archimed.fr
 *
 */

(function($){
	
	var opts = {};
	
	
	$.fn.tooltip = function(settings) {	
		opts.settings = $.extend({}, $.fn.tooltip.defaults, settings);

		$.fn.tooltip.init(opts);
		
		return this.each(function() {
			var $this = $(this);
			var o = $.metadata ? $.extend({}, opts.settings, $this.metadata()) : opts.settings;
			

			$this.unbind('mouseover').mouseover(function() {
				$.fn.tooltip.stopTimer();
				$.fn.tooltip.timerMillisecondsStart = o.timerMillisecondsStart;
        $.fn.tooltip.linkTitle = $this.attr('title');
				$this.attr('title', '');
				$.fn.tooltip.overSchedule($this, o); return false;
			});
			
			$this.unbind('mouseout').mouseout(function() {
				$.fn.tooltip.stopTimer();
				$.fn.tooltip.out($this, o); return false;
			});
		});
	};
	
	
	$.fn.tooltip.stopTimer = function() {
		if($.fn.tooltip.timerRunning)
			clearTimeout($.fn.tooltip.timerID);
		$.fn.tooltip.timerRunning = false;
	}
	
	$.fn.tooltip.overSchedule = function(el, o) {
		if ($.fn.tooltip.timerMillisecondsStart<=0)
		{
			$.fn.tooltip.stopTimer();
			$.fn.tooltip.over(el, o);
		}
		else
		{
			self.status = $.fn.tooltip.timerMillisecondsStart;
			$.fn.tooltip.timerMillisecondsStart = $.fn.tooltip.timerMillisecondsStart - o.timerMillisecondsStep;
			$.fn.tooltip.timerRunning = true;
			$.fn.tooltip.timerID = self.setTimeout(function(){$.fn.tooltip.overSchedule(el, o)}, o.timerMillisecondsStep);
		}
	}
	
	
	$.fn.tooltip.over = function(el, o) {
						
		//Affectation du titre
		$.fn.tooltip.tooltipContainer.html( $.fn.tooltip.linkTitle );
		
		//Traitement particuliers ?
		if (o.forceImageMargin)
		{
			$.fn.tooltip.tooltipContainer.find("img").each(function(){
				jQuery(this).css("margin", o.imageMargin);
			});
		}
		
		//Position de l'appelant
		var pos = el.offset();  
		var width = el.width();
		
		
		$.fn.tooltip.tooltipContainer.css(
		{
			"left": (pos.left + width) + "px",
			"top": pos.top + "px"
		}
		);
		
		$.fn.tooltip.tooltipContainer.show();
		
		if ((pos.top + $.fn.tooltip.tooltipContainer.height()) > ($(window).scrollTop() + $(window).height()))
		{
			$.fn.tooltip.tooltipContainer.css("top", Math.max($(window).scrollTop(), (pos.top - $.fn.tooltip.tooltipContainer.height())));
		}
		
	}
	
	$.fn.tooltip.out = function(el, o) {
		//Masquage du tooltip
		$.fn.tooltip.tooltipContainer.hide();
		
		//R?affectation du titre
		el.attr('title', $.fn.tooltip.linkTitle);
	}
	
	
	$.fn.tooltip.init = function(o) {
		if ($.fn.tooltip.tooltipContainer==null) {
			$('<div id="tooltip_container" class="tooltip" style="display:none;"/>').appendTo("body");
			$.fn.tooltip.tooltipContainer = $("body div#tooltip_container");
			$.fn.tooltip.tooltipContainer.width(o.width);
		}

	};
	
	$.fn.tooltip.defaults = {
		width: 'auto',
		forceImageMargin: false,
		imageMargin: '5px',
		timerMillisecondsStep: 100,
		timerMillisecondsStart: 400
	};
	
	$.fn.tooltip.tooltipContainer;
	$.fn.tooltip.timerRunning = false;
	$.fn.tooltip.timerID = null;
	$.fn.tooltip.linkTitle = "";
	$.fn.tooltip.timerMillisecondsStart;

})(jQuery);


// [EOF] for file jquery.AcsTooltip.js

// file: jquery.AcsCheckForm.js

/*
 * Archimed - Culture et Savoir
 * CheckForm v0.1b (26/05/2010)
 * A jQuery form check plugin
 * Copyright (c) 2010 Archimed
 *
 * Aurelien Dolande
 * dolande@archimed.fr
 * 
 * Change log: v0.1b : gestion de la verification des champs de type date (checkDate) + validation des champs mail et date sans qu ils soient forcement requis
 */

(function($){
	
	var opts = {};
	
	$.fn.checkForm = function(settings) {	
		opts.settings = $.extend({}, $.fn.checkForm.defaults, settings);
		
		return this.each(function() {
			var $this = $(this);
			var o = $.metadata ? $.extend({}, opts.settings, $this.metadata()) : opts.settings;
			o.wmlKeys = opts.settings.wmlKeys ? $.extend({}, $.fn.checkForm.defaults.wmlKeys, opts.settings.wmlKeys) : $.fn.checkForm.defaults.wmlKeys;
			
			// Ajout d'un marqueur sur les champs obligatoires
			$.fn.checkForm.flagrequiredField($this, o);
			
			$this.unbind('submit').removeAttr('onsubmit').submit(function() {
				return $.fn.checkForm.check($this, o); 
			});
		
		});
	};
		
	
	// Validation du formulaire
	// ------------------------
	$.fn.checkForm.check = function(el, o) {
		// Activation des validations ? la volee des qu'on a poste au moins une fois le formulaire
		if (!$.fn.checkForm.liveCheck)
		{
			el.find(':input').unbind('change').bind('change', function() {
				$.fn.checkForm.check(el, o);
			});
			$.fn.checkForm.liveCheck = true;
		}
	
		$.fn.checkForm.requiredField = true;
		$.fn.checkForm.fieldOnError = false;
		
		//Suppression de tous les messages precedents
		el.find('.requiredFieldsAlert').remove();
	
		// Recherche des champs vides
		el.find(':input.checkRequired,:input.checkMail,:input.checkDate').each(function() {
			$.fn.checkForm.checkField(el, $(this), o);
		});
		
		return $.fn.checkForm.requiredField && !$.fn.checkForm.fieldOnError;
	};
	
	
	// Operations sur un champ
	// -----------------------
	$.fn.checkForm.checkField = function(form, input, o)	{
		// Traitement different en fonction du type de champ
		if (input[0].type=='checkbox')
		{
			var checked = false;
			// On liste les checkbox ayant le m?me nom
			var checkBoxes = form.find(':checkbox[name='+$(input).attr('name')+']');
			for (var i=0; i<checkBoxes.length; i++)
			{
				if (checkBoxes[i].checked)
					checked = true;
			}
			if (!checked)
			{
				// Message d'erreur
				$.fn.checkForm.addErrorMessage(checkBoxes[checkBoxes.length-1], o, o.wmlKeys.requiredField);
				$.fn.checkForm.requiredField = false;
			}
		}
		else
		{		
			if ($(input)[0].type=='radio')
			{
				var checked = false;
				// On liste les radio bouttons ayant le m?me nom
				var radios = form.find(':radio[name='+$(input).attr('name')+']');
				for (var i=0; i<radios.length; i++)
				{
					if (radios[i].checked)
						checked = true;
				}
				if (!checked)
				{
					// Message d'erreur
					$.fn.checkForm.addErrorMessage(radios[radios.length-1], o, o.wmlKeys.requiredField);
					$.fn.checkForm.requiredField = false;
				}
			}
			else // Tous les autres type de champ
			{
				if (!$(input).hasClass('checkRequired') && ( $(input).val()=="" || jQuery.trim($(input).val())=="" ) )
				{
					//Rien a afficher
				}
				else
				{
					if ($(input).val()=="" || jQuery.trim($(input).val())=="")
					{
						input.addClass('errorField');
						// Message d erreur
						$.fn.checkForm.addErrorMessage(input, o, o.wmlKeys.requiredField);
						$.fn.checkForm.requiredField = false;
					}
					else
					{
						// Verification des champs mails
						if (input.hasClass('checkMail'))
							$.fn.checkForm.checkMail(input, o);
						// Verification des champs date
						else if (input.hasClass('checkDate'))
							$.fn.checkForm.checkDate(input, o);
						else
							input.removeClass('errorField');
					}
				}
			}
		}
	};
	
	
  // Validation d un champ mail	
	// --------------------------
	$.fn.checkForm.checkMail = function(input, o) {
		try
		{
			var reg = new RegExp('^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$','i');
			if (!reg.test(input.val()))
			{
				input.addClass('errorField');
				$.fn.checkForm.addErrorMessage(input, o, o.wmlKeys.mailError);
				$.fn.checkForm.fieldOnError = true;
			}
			else
				input.removeClass('errorField');
		}
		catch(err){
			// console.log(err.description);
		}
	};
	
	// Validation d'un champ date
	$.fn.checkForm.checkDate = function(input, o) {
		try
		{
			var reg = new RegExp(o.dateRegex, 'i');
			if (!reg.test(input.val()))
			{
				input.addClass('errorField');
				$.fn.checkForm.addErrorMessage(input, o, o.wmlKeys.dateError);
				$.fn.checkForm.fieldOnError = true;
			}
			else
				input.removeClass('errorField');
		}
		catch(err){
			// console.log(err.description);
		}
	};
	
	
	// Affichage d'un message d'erreur
	// -------------------------------
	$.fn.checkForm.addErrorMessage = function(el, o, message) {
		switch (o.position)
		{
		case $.fn.checkForm.alertPosition.top: 
			$(el).parent().prepend('<div class="requiredFieldsAlert">'+message+'<br/></div>');
			break;
		case $.fn.checkForm.alertPosition.right: 
			$(el).parent().append('<span class="requiredFieldsAlert">&#160;'+message+'</span>');
			break;
		case $.fn.checkForm.alertPosition.left: 
			$(el).parent().prepend('<span class="requiredFieldsAlert">'+message+'&#160;</span>');
			break;
		case $.fn.checkForm.alertPosition.bottom:
			$(el).parent().append('<span class="requiredFieldsAlert"><br/>'+message+'&#160;</span>');
			break;
		
		case $.fn.checkForm.alertPosition.closeTop: 
			$('<div class="requiredFieldsAlert">'+message+'<br/></div>').insertBefore(el);
			break;
		case $.fn.checkForm.alertPosition.closeRight: 
			$('<span class="requiredFieldsAlert">&#160;'+message+'</span>').insertAfter(el);
			break;
		case $.fn.checkForm.alertPosition.closeLeft: 
			$('<span class="requiredFieldsAlert">'+message+'&#160;</span>').insertBefore(el);
			break;
		case $.fn.checkForm.alertPosition.closeBottom:
			$('<div class="requiredFieldsAlert">'+message+'</div>').insertAfter(el);
			break;
			
		default:
			el.parent().append('<span class="requiredFieldsAlert">'+message+'&#160;</span>');
		} 
	};
	
	
	// Affichage d'un marqueur pour les champs vides
	// ---------------------------------------------
	$.fn.checkForm.flagrequiredField = function(form, o) {		
		form.find(':input.checkRequired').each(function() {
			var label = form.find('label[for='+$(this).attr('name')+']');
			if (label.length > 0)
			{
				switch (o.requiredFlagPosition)
				{
					case $.fn.checkForm.requiredFlagPosition.left:
						$(label[0]).text( o.requiredFlagChar + ' ' + $(label[0]).text());
						break;
					case $.fn.checkForm.requiredFlagPosition.rightBeforeColon:
						var lastIndexOfColon = $(label[0]).text().lastIndexOf(':');
						if (lastIndexOfColon > 0)
						{
							$(label[0]).text( $(label[0]).text().substring(0, lastIndexOfColon) + o.requiredFlagChar + ' :');
						}
						else
						{
							$(label[0]).text( $(label[0]).text() + ' ' + o.requiredFlagChar);
						}
						break;
					case $.fn.checkForm.requiredFlagPosition.right:
					default:	
						$(label[0]).text( $(label[0]).text() + ' ' + o.requiredFlagChar);
				}
				// console.log($(label[0]).text());
			}

		});
	};
	
	
	// Variables
	// ---------
	$.fn.checkForm.requiredField = true;
	
	$.fn.checkForm.fieldOnError = false;
	
	$.fn.checkForm.liveCheck = false;
	
	$.fn.checkForm.alertPosition = {
		top    			: {}, 
		bottom 			: {},
		right  	  	: {}, 
		left	      : {},
		closeTop    : {}, 
		closeBottom : {},
		closeRight  : {}, 
		closeLeft	  : {}
	};
	
	$.fn.checkForm.requiredFlagPosition = {
		right  : {},
		left	 : {},
		rightBeforeColon : {}  // Colon = ':'
	};
	
	// Parametres
	// ----------
	$.fn.checkForm.defaults = {
			wmlKeys: {
				requiredField : "Ce champ est requis",
				mailError  : "L'adresse electronique saisie est incorrecte",
				dateError : "Le format de date saisi est incorrect jj/mm/aaaa"
			},
			position: $.fn.checkForm.alertPosition.bottom,
			requiredFlagPosition : $.fn.checkForm.requiredFlagPosition.right,
			requiredFlagChar : "*",
			dateRegex : '^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/(19|20)[0-9]{2}$'
	};
	

})(jQuery);


// [EOF] for file jquery.AcsCheckForm.js

// file: run.js

$(document).ready(function() {
	$("a.fancybox").fancybox(
		{
		'zoomSpeedIn':	0, 
		'zoomSpeedOut':	0, 
		'overlayShow':	false,
		'overlayOpacity':0.3,
		'hideOnContentClick':false,
		'imageScale':true,
		'zoomSpeedChange':true,
		'frameWidth': 800, 
		'frameHeight': 600,
		'titlePosition':'outside',
		'centerOnScroll':true
		}
	);
	
	$("a.tooltip[title!='']").tooltip({
		'forceImageMargin' : true
	});
	
	// Activation des caroussel (encarts de contenu)
	jQuery("ul.jcarousel-skin-ie7").jcarousel({
		scroll:1,
		auto: 7, 
		wrap: 'last',
		initCallback:function (carousel)
		{
			// Disable autoscrolling if the user clicks the prev or next button.
			carousel.buttonNext.bind('click', function() {
				carousel.startAuto(0);
			});
		 
			carousel.buttonPrev.bind('click', function() {
				carousel.startAuto(0);
			});
		 
			// Pause autoscrolling if the user moves with the cursor over the clip.
			carousel.clip.hover(function() {
				carousel.stopAuto();
			}, function() {
				carousel.startAuto();
			});
		}
	});

});

// [EOF] for file run.js

// file: jquery.jcarousel.pack.js

/**
 * jCarousel - Riding carousels with jQuery
 *   http://sorgalla.com/jcarousel/
 *
 * Copyright (c) 2006 Jan Sorgalla (http://sorgalla.com)
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 * Built on top of the jQuery library
 *   http://jquery.com
 *
 * Inspired by the "Carousel Component" by Bill Scott
 *   http://billwscott.com/carousel/
 */
eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('(9($){$.1s.A=9(o){z 4.14(9(){2H r(4,o)})};8 q={W:F,23:1,1G:1,u:7,15:3,16:7,1H:\'2I\',24:\'2J\',1i:0,B:7,1j:7,1I:7,25:7,26:7,27:7,28:7,29:7,2a:7,2b:7,1J:\'<N></N>\',1K:\'<N></N>\',2c:\'2d\',2e:\'2d\',1L:7,1M:7};$.A=9(e,o){4.5=$.17({},q,o||{});4.Q=F;4.D=7;4.H=7;4.t=7;4.R=7;4.S=7;4.O=!4.5.W?\'1N\':\'2f\';4.E=!4.5.W?\'2g\':\'2h\';8 a=\'\',1d=e.J.1d(\' \');1k(8 i=0;i<1d.K;i++){6(1d[i].2i(\'A-2j\')!=-1){$(e).1t(1d[i]);8 a=1d[i];1l}}6(e.2k==\'2K\'||e.2k==\'2L\'){4.t=$(e);4.D=4.t.18();6(4.D.1m(\'A-H\')){6(!4.D.18().1m(\'A-D\'))4.D=4.D.B(\'<N></N>\');4.D=4.D.18()}X 6(!4.D.1m(\'A-D\'))4.D=4.t.B(\'<N></N>\').18()}X{4.D=$(e);4.t=$(e).2M(\'>2l,>2m,N>2l,N>2m\')}6(a!=\'\'&&4.D.18()[0].J.2i(\'A-2j\')==-1)4.D.B(\'<N 2N=" \'+a+\'"></N>\');4.H=4.t.18();6(!4.H.K||!4.H.1m(\'A-H\'))4.H=4.t.B(\'<N></N>\').18();4.S=$(\'.A-11\',4.D);6(4.S.u()==0&&4.5.1K!=7)4.S=4.H.1u(4.5.1K).11();4.S.V(4.J(\'A-11\'));4.R=$(\'.A-19\',4.D);6(4.R.u()==0&&4.5.1J!=7)4.R=4.H.1u(4.5.1J).11();4.R.V(4.J(\'A-19\'));4.H.V(4.J(\'A-H\'));4.t.V(4.J(\'A-t\'));4.D.V(4.J(\'A-D\'));8 b=4.5.16!=7?1n.1O(4.1o()/4.5.16):7;8 c=4.t.2O(\'1v\');8 d=4;6(c.u()>0){8 f=0,i=4.5.1G;c.14(9(){d.1P(4,i++);f+=d.T(4,b)});4.t.y(4.O,f+\'U\');6(!o||o.u===L)4.5.u=c.u()}4.D.y(\'1w\',\'1x\');4.R.y(\'1w\',\'1x\');4.S.y(\'1w\',\'1x\');4.2n=9(){d.19()};4.2o=9(){d.11()};4.1Q=9(){d.2p()};6(4.5.1j!=7)4.5.1j(4,\'2q\');6($.2r.2s){4.1e(F,F);$(2t).1y(\'2P\',9(){d.1z()})}X 4.1z()};8 r=$.A;r.1s=r.2Q={A:\'0.2.3\'};r.1s.17=r.17=$.17;r.1s.17({1z:9(){4.C=7;4.G=7;4.Y=7;4.12=7;4.1a=F;4.1f=7;4.P=7;4.Z=F;6(4.Q)z;4.t.y(4.E,4.1A(4.5.1G)+\'U\');8 p=4.1A(4.5.23);4.Y=4.12=7;4.1p(p,F);$(2t).1R(\'2u\',4.1Q).1y(\'2u\',4.1Q)},2v:9(){4.t.2w();4.t.y(4.E,\'2R\');4.t.y(4.O,\'2S\');6(4.5.1j!=7)4.5.1j(4,\'2v\');4.1z()},2p:9(){6(4.P!=7&&4.Z)4.t.y(4.E,r.I(4.t.y(4.E))+4.P);4.P=7;4.Z=F;6(4.5.1I!=7)4.5.1I(4);6(4.5.16!=7){8 a=4;8 b=1n.1O(4.1o()/4.5.16),O=0,E=0;$(\'1v\',4.t).14(9(i){O+=a.T(4,b);6(i+1<a.C)E=O});4.t.y(4.O,O+\'U\');4.t.y(4.E,-E+\'U\')}4.15(4.C,F)},2T:9(){4.Q=1g;4.1e()},2U:9(){4.Q=F;4.1e()},u:9(s){6(s!=L){4.5.u=s;6(!4.Q)4.1e()}z 4.5.u},2V:9(i,a){6(a==L||!a)a=i;6(4.5.u!==7&&a>4.5.u)a=4.5.u;1k(8 j=i;j<=a;j++){8 e=4.M(j);6(!e.K||e.1m(\'A-1b-1B\'))z F}z 1g},M:9(i){z $(\'.A-1b-\'+i,4.t)},2x:9(i,s){8 e=4.M(i),1S=0,2x=0;6(e.K==0){8 c,e=4.1C(i),j=r.I(i);1q(c=4.M(--j)){6(j<=0||c.K){j<=0?4.t.2y(e):c.1T(e);1l}}}X 1S=4.T(e);e.1t(4.J(\'A-1b-1B\'));1U s==\'2W\'?e.2X(s):e.2w().2Y(s);8 a=4.5.16!=7?1n.1O(4.1o()/4.5.16):7;8 b=4.T(e,a)-1S;6(i>0&&i<4.C)4.t.y(4.E,r.I(4.t.y(4.E))-b+\'U\');4.t.y(4.O,r.I(4.t.y(4.O))+b+\'U\');z e},1V:9(i){8 e=4.M(i);6(!e.K||(i>=4.C&&i<=4.G))z;8 d=4.T(e);6(i<4.C)4.t.y(4.E,r.I(4.t.y(4.E))+d+\'U\');e.1V();4.t.y(4.O,r.I(4.t.y(4.O))-d+\'U\')},19:9(){4.1D();6(4.P!=7&&!4.Z)4.1W(F);X 4.15(((4.5.B==\'1X\'||4.5.B==\'G\')&&4.5.u!=7&&4.G==4.5.u)?1:4.C+4.5.15)},11:9(){4.1D();6(4.P!=7&&4.Z)4.1W(1g);X 4.15(((4.5.B==\'1X\'||4.5.B==\'C\')&&4.5.u!=7&&4.C==1)?4.5.u:4.C-4.5.15)},1W:9(b){6(4.Q||4.1a||!4.P)z;8 a=r.I(4.t.y(4.E));!b?a-=4.P:a+=4.P;4.Z=!b;4.Y=4.C;4.12=4.G;4.1p(a)},15:9(i,a){6(4.Q||4.1a)z;4.1p(4.1A(i),a)},1A:9(i){6(4.Q||4.1a)z;i=r.I(i);6(4.5.B!=\'1c\')i=i<1?1:(4.5.u&&i>4.5.u?4.5.u:i);8 a=4.C>i;8 b=r.I(4.t.y(4.E));8 f=4.5.B!=\'1c\'&&4.C<=1?1:4.C;8 c=a?4.M(f):4.M(4.G);8 j=a?f:f-1;8 e=7,l=0,p=F,d=0;1q(a?--j>=i:++j<i){e=4.M(j);p=!e.K;6(e.K==0){e=4.1C(j).V(4.J(\'A-1b-1B\'));c[a?\'1u\':\'1T\'](e)}c=e;d=4.T(e);6(p)l+=d;6(4.C!=7&&(4.5.B==\'1c\'||(j>=1&&(4.5.u==7||j<=4.5.u))))b=a?b+d:b-d}8 g=4.1o();8 h=[];8 k=0,j=i,v=0;8 c=4.M(i-1);1q(++k){e=4.M(j);p=!e.K;6(e.K==0){e=4.1C(j).V(4.J(\'A-1b-1B\'));c.K==0?4.t.2y(e):c[a?\'1u\':\'1T\'](e)}c=e;8 d=4.T(e);6(d==0){2Z(\'30: 31 1N/2f 32 1k 33. 34 35 36 37 38 39. 3a...\');z 0}6(4.5.B!=\'1c\'&&4.5.u!==7&&j>4.5.u)h.3b(e);X 6(p)l+=d;v+=d;6(v>=g)1l;j++}1k(8 x=0;x<h.K;x++)h[x].1V();6(l>0){4.t.y(4.O,4.T(4.t)+l+\'U\');6(a){b-=l;4.t.y(4.E,r.I(4.t.y(4.E))-l+\'U\')}}8 n=i+k-1;6(4.5.B!=\'1c\'&&4.5.u&&n>4.5.u)n=4.5.u;6(j>n){k=0,j=n,v=0;1q(++k){8 e=4.M(j--);6(!e.K)1l;v+=4.T(e);6(v>=g)1l}}8 o=n-k+1;6(4.5.B!=\'1c\'&&o<1)o=1;6(4.Z&&a){b+=4.P;4.Z=F}4.P=7;6(4.5.B!=\'1c\'&&n==4.5.u&&(n-k+1)>=1){8 m=r.10(4.M(n),!4.5.W?\'1r\':\'1Y\');6((v-m)>g)4.P=v-g-m}1q(i-->o)b+=4.T(4.M(i));4.Y=4.C;4.12=4.G;4.C=o;4.G=n;z b},1p:9(p,a){6(4.Q||4.1a)z;4.1a=1g;8 b=4;8 c=9(){b.1a=F;6(p==0)b.t.y(b.E,0);6(b.5.B==\'1X\'||b.5.B==\'G\'||b.5.u==7||b.G<b.5.u)b.2z();b.1e();b.1Z(\'2A\')};4.1Z(\'3c\');6(!4.5.1H||a==F){4.t.y(4.E,p+\'U\');c()}X{8 o=!4.5.W?{\'2g\':p}:{\'2h\':p};4.t.1p(o,4.5.1H,4.5.24,c)}},2z:9(s){6(s!=L)4.5.1i=s;6(4.5.1i==0)z 4.1D();6(4.1f!=7)z;8 a=4;4.1f=3d(9(){a.19()},4.5.1i*3e)},1D:9(){6(4.1f==7)z;3f(4.1f);4.1f=7},1e:9(n,p){6(n==L||n==7){8 n=!4.Q&&4.5.u!==0&&((4.5.B&&4.5.B!=\'C\')||4.5.u==7||4.G<4.5.u);6(!4.Q&&(!4.5.B||4.5.B==\'C\')&&4.5.u!=7&&4.G>=4.5.u)n=4.P!=7&&!4.Z}6(p==L||p==7){8 p=!4.Q&&4.5.u!==0&&((4.5.B&&4.5.B!=\'G\')||4.C>1);6(!4.Q&&(!4.5.B||4.5.B==\'G\')&&4.5.u!=7&&4.C==1)p=4.P!=7&&4.Z}8 a=4;4.R[n?\'1y\':\'1R\'](4.5.2c,4.2n)[n?\'1t\':\'V\'](4.J(\'A-19-1E\')).20(\'1E\',n?F:1g);4.S[p?\'1y\':\'1R\'](4.5.2e,4.2o)[p?\'1t\':\'V\'](4.J(\'A-11-1E\')).20(\'1E\',p?F:1g);6(4.R.K>0&&(4.R[0].1h==L||4.R[0].1h!=n)&&4.5.1L!=7){4.R.14(9(){a.5.1L(a,4,n)});4.R[0].1h=n}6(4.S.K>0&&(4.S[0].1h==L||4.S[0].1h!=p)&&4.5.1M!=7){4.S.14(9(){a.5.1M(a,4,p)});4.S[0].1h=p}},1Z:9(a){8 b=4.Y==7?\'2q\':(4.Y<4.C?\'19\':\'11\');4.13(\'25\',a,b);6(4.Y!==4.C){4.13(\'26\',a,b,4.C);4.13(\'27\',a,b,4.Y)}6(4.12!==4.G){4.13(\'28\',a,b,4.G);4.13(\'29\',a,b,4.12)}4.13(\'2a\',a,b,4.C,4.G,4.Y,4.12);4.13(\'2b\',a,b,4.Y,4.12,4.C,4.G)},13:9(a,b,c,d,e,f,g){6(4.5[a]==L||(1U 4.5[a]!=\'2B\'&&b!=\'2A\'))z;8 h=1U 4.5[a]==\'2B\'?4.5[a][b]:4.5[a];6(!$.3g(h))z;8 j=4;6(d===L)h(j,c,b);X 6(e===L)4.M(d).14(9(){h(j,4,d,c,b)});X{1k(8 i=d;i<=e;i++)6(i!==7&&!(i>=f&&i<=g))4.M(i).14(9(){h(j,4,i,c,b)})}},1C:9(i){z 4.1P(\'<1v></1v>\',i)},1P:9(e,i){8 a=$(e).V(4.J(\'A-1b\')).V(4.J(\'A-1b-\'+i));a.20(\'3h\',i);z a},J:9(c){z c+\' \'+c+(!4.5.W?\'-3i\':\'-W\')},T:9(e,d){8 a=e.2C!=L?e[0]:e;8 b=!4.5.W?a.1F+r.10(a,\'2D\')+r.10(a,\'1r\'):a.2E+r.10(a,\'2F\')+r.10(a,\'1Y\');6(d==L||b==d)z b;8 w=!4.5.W?d-r.10(a,\'2D\')-r.10(a,\'1r\'):d-r.10(a,\'2F\')-r.10(a,\'1Y\');$(a).y(4.O,w+\'U\');z 4.T(a)},1o:9(){z!4.5.W?4.H[0].1F-r.I(4.H.y(\'3j\'))-r.I(4.H.y(\'3k\')):4.H[0].2E-r.I(4.H.y(\'3l\'))-r.I(4.H.y(\'3m\'))},3n:9(i,s){6(s==L)s=4.5.u;z 1n.3o((((i-1)/s)-1n.3p((i-1)/s))*s)+1}});r.17({3q:9(d){z $.17(q,d||{})},10:9(e,p){6(!e)z 0;8 a=e.2C!=L?e[0]:e;6(p==\'1r\'&&$.2r.2s){8 b={\'1w\':\'1x\',\'3r\':\'3s\',\'1N\':\'1i\'},21,22;$.2G(a,b,9(){21=a.1F});b[\'1r\']=0;$.2G(a,b,9(){22=a.1F});z 22-21}z r.I($.y(a,p))},I:9(v){v=3t(v);z 3u(v)?0:v}})})(3v);',62,218,'||||this|options|if|null|var|function||||||||||||||||||||list|size||||css|return|jcarousel|wrap|first|container|lt|false|last|clip|intval|className|length|undefined|get|div|wh|tail|locked|buttonNext|buttonPrev|dimension|px|addClass|vertical|else|prevFirst|inTail|margin|prev|prevLast|callback|each|scroll|visible|extend|parent|next|animating|item|circular|split|buttons|timer|true|jcarouselstate|auto|initCallback|for|break|hasClass|Math|clipping|animate|while|marginRight|fn|removeClass|before|li|display|block|bind|setup|pos|placeholder|create|stopAuto|disabled|offsetWidth|offset|animation|reloadCallback|buttonNextHTML|buttonPrevHTML|buttonNextCallback|buttonPrevCallback|width|ceil|format|funcResize|unbind|old|after|typeof|remove|scrollTail|both|marginBottom|notify|attr|oWidth|oWidth2|start|easing|itemLoadCallback|itemFirstInCallback|itemFirstOutCallback|itemLastInCallback|itemLastOutCallback|itemVisibleInCallback|itemVisibleOutCallback|buttonNextEvent|click|buttonPrevEvent|height|left|top|indexOf|skin|nodeName|ul|ol|funcNext|funcPrev|reload|init|browser|safari|window|resize|reset|empty|add|prepend|startAuto|onAfterAnimation|object|jquery|marginLeft|offsetHeight|marginTop|swap|new|normal|swing|UL|OL|find|class|children|load|prototype|0px|10px|lock|unlock|has|string|html|append|alert|jCarousel|No|set|items|This|will|cause|an|infinite|loop|Aborting|push|onBeforeAnimation|setTimeout|1000|clearTimeout|isFunction|jcarouselindex|horizontal|borderLeftWidth|borderRightWidth|borderTopWidth|borderBottomWidth|index|round|floor|defaults|float|none|parseInt|isNaN|jQuery'.split('|'),0,{}))


// [EOF] for file jquery.jcarousel.pack.js

//package loaded!
packages.complete('BAM_JQUERY_ALL');

// Served in 660 ms