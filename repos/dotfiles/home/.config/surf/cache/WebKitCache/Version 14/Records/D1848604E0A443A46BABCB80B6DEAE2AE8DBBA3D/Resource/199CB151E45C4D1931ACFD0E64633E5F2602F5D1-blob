/**
* bbCode control by subBlue design [ www.subBlue.com ]
* Includes unixsafe colour palette selector by SHS`
*/

// Startup variables
var imageTag = false;
var theSelection = false;
var bbcodeEnabled = true;

// Check for Browser & Platform for PC & IE specific bits
// More details from: http://www.mozilla.org/docs/web-developer/sniffer/browser_type.html
var clientPC = navigator.userAgent.toLowerCase(); // Get client info
var clientVer = parseInt(navigator.appVersion); // Get browser version

var is_ie = ((clientPC.indexOf('msie') != -1) && (clientPC.indexOf('opera') == -1));
var is_win = ((clientPC.indexOf('win') != -1) || (clientPC.indexOf('16bit') != -1));

var baseHeight;


/*
 * MOD buttons
 */
var mod_buttons = [
//[[regexp, replecement],[regexp, replecement],...],
[[/\[(|\/|\\)tex\]/gi, ' ']], //button 0
[[/\*/gi, ' \\cdot ']], //button 1
[[/(\\int_\{\}\^\{\}\s*){3,3}/gi, ' \\iiint '], [/(\\int_\{\}\^\{\}\s*){2,2}/gi, ' \\iint '], [/\\int_\{\}\^\{\}/gi, ' \\int ']], //button 2
[[/(\\?)(a|arc|)(sin|cos|tan|tg|ctg|cot|ln|log|sup|max|min)(h?)(.)/g, common_func_r], [/(\\?)()(inf(?!ty))()(.)/g, common_func_r]],
//[[/(arcsin|arccos|cgth|coth|sinh|cosh|tgh|tanh)([0-9A-z\(])/gi, ' \\$1 $2 '], [/(arctan|arctg)([0-9A-z\(])/gi, ' \\arc\\tg $2 '], [/(ln|log)([0-9A-z])/gi, ' \\$1 $2 '], [/(sin|cos|tg|tan|cot|ctg)([0-9A-GI-gi-z\(])/gi, ' \\$1 $2 ']], //button 3
[[/(\[\/?tex\]|\\sqrt\s*\[(.*?)\])/g, brace_pre],[/(\\left)?(\(|\[|\\\{)/gi, brace_scaller], [/(\\right)?(\)|\]|\\\})/gi, brace_scaller], [/<(.*?)>/g, '\\left\\langle $1 \\right\\rangle'], [/__BL_/g, '['], [/__BR_/g, ']']], //button4
[[/ {2,}/gi, ' ']], //button5
];

var button_num_global;

function mod_button(num)
{
	button_num_global = num;
	var textarea = document.forms[form_name].elements[text_name];
	var tmpScroll=textarea.scrollTop;

	//sprawdzamy czy jest coś zaznaczone
	var selectionStart = 0;
	var selectionEnd = 0;

	textarea.focus();
	if ((clientVer >= 4) && is_ie && is_win) {
		var range = document.selection.createRange();
		if (range.text) {
			var stored_range = range.duplicate();
			stored_range.moveToElementText( textarea );
			stored_range.setEndPoint( 'EndToEnd', range );
			selectionStart = stored_range.text.length - range.text.length;
			selectionEnd = selectionStart + range.text.length;
		}
	}
	else if (document.forms[form_name].elements[text_name].selectionEnd) {
		selectionStart = document.forms[form_name].elements[text_name].selectionStart;
		selectionEnd = document.forms[form_name].elements[text_name].selectionEnd;
	}
	

	if(selectionStart<selectionEnd) {
		//mamy zaznaczenie
		var string_to_change = textarea.value.substring(selectionStart,selectionEnd);
		if(num != 7) {
			for(var i=0;i<mod_buttons[num].length;i++) {
				string_to_change = string_to_change.replace(mod_buttons[num][i][0], mod_buttons[num][i][1]);
			}
		} else {
			string_to_change = strip_bbcode(string_to_change);
		}
		textarea.value = textarea.value.substring(0,selectionStart) + string_to_change + textarea.value.substring(selectionEnd);
	} else {
		//zmieniamy całość
		var string_to_change = textarea.value;
		if(num == 7) {
			string_to_change = strip_bbcode(string_to_change);
		} else if(num != 0 && num != 5) {
			string_to_change = replace_in_tags(string_to_change);
		} else {
			for(var i=0;i<mod_buttons[num].length;i++) {
				string_to_change = string_to_change.replace(mod_buttons[num][i][0], mod_buttons[num][i][1]);
			}
		}
		textarea.value = string_to_change;
	}
	textarea.scrollTop=tmpScroll; 
}

function brace_scaller(str, p1, p2)
{
	if('' == p1 || undefined == p1) {
		var brace = '';
		var left_braces = {'\\{':1, '[':1, '(':1};
		if(p2 in left_braces) {
			brace = ' \\left';
		} else {
			brace = ' \\right';
		}
		return brace+p2+' ';
	}
	return str;
}

function brace_pre(str, p1, p2) {
	if(p1 == '[tex]') {
		return '__BL_tex__BR_';
	} else if(p1 == '[/tex]') {
		return '__BL_/tex__BR_';
	} else {
		return '\\sqrt__BL_'+(p2||'')+'__BR_';
	}
}
function common_func_r(str, slash, pref, name, suf, arg) {
	if(pref != '') {
		pref = 'arc';
		if(name == 'tg') name = 'tan';
		if(name == 'ctg') name = 'cot';
	}
	if(suf != '') {
		if(name == 'ctg') name = 'cot';
	}
	if(arg != ' ') arg = ' '+arg;
	
	return '\\'+pref+name+suf+arg;
}

var tex_tag_counter;
var tex_tag_error;
var latest_close;
function replace_in_tags(text) {
	tex_tag_counter = 0;
	tex_tag_error = false;
	latest_close = 2;

	text = text.replace(/\[(\/?)tex\]/g, replace_helper);

	if(tex_tag_error) {
		alert('Błąd tagów tex');
	} else {
		text = text.replace(/__TOPEN_(\d+)_([\s\S]+)__TCLOSE_\1_/gi, block_replacer);
	}
	text = text.replace(/__TOPEN_\d+_/g, '[tex]');
	text = text.replace(/__TCLOSE_\d+_/g, '[/tex]');

	return text;
}

function replace_helper(a,b) {
	if(b == '') {
		if(latest_close == 1) {
			tex_tag_error = true;
			return a;
		}
		latest_close = 1;
		tex_tag_counter++;
		return '__TOPEN_'+tex_tag_counter+'_';
	} else {
		if(latest_close == 0) {
			tex_tag_error = true;
			return a;
		}
		latest_close = 0;
		return '__TCLOSE_'+tex_tag_counter+'_';
	}
}

function block_replacer(t,n,d) {
	for(var i=0;i<mod_buttons[button_num_global].length;i++) {
		d = d.replace(mod_buttons[button_num_global][i][0], mod_buttons[button_num_global][i][1]);
	}
	return '[tex]'+d+'[/tex]';
}

var bbcode_tag_list = ['b', 'i', 'u', 'quote', 'code', 'list', 'img', 'url', 'size', 'center', 'hide', 'tex'];

function strip_bbcode(msg) {
	var tag;
	for(i in bbcode_tag_list) {
		tag = bbcode_tag_list[i];
		var ree = new RegExp("\\[[/\\\\]?"+tag+"(=.*?)?\\]", "gi");
		if($('#mod7-'+tag).attr('checked')) {
			msg = msg.replace(ree, '');
			if(tag == 'list') {
				msg = msg.replace(/\[\*\]/gi, '');
			}
		}
	}
	$('#mod7-adds').slideToggle();
	return msg;
}


//f&r
function find_next(str) {
	var textarea = document.forms[form_name].elements[text_name];
	
	var start = doGetCaretPosition(textarea)+1; //TODO
	var new_pos = textarea.value.substring(start).indexOf(str) + start;
	
	createSelection(textarea, new_pos, new_pos+str.length);
}

function createSelection(field, start, end) {
    if( field.createTextRange ) {
        var selRange = field.createTextRange();
        selRange.collapse(true);
        selRange.moveStart('character', start);
        selRange.moveEnd('character', end);
        selRange.select();
    } else if( field.setSelectionRange ) {
        field.setSelectionRange(start, end);
    } else if( field.selectionStart ) {
        field.selectionStart = start;
        field.selectionEnd = end;
    }
    field.focus();
}     

function doGetCaretPosition (ctrl) {
	var CaretPos = 0;	// IE Support
	if (document.selection) {
	ctrl.focus ();
		var Sel = document.selection.createRange ();
		Sel.moveStart ('character', -ctrl.value.length);
		CaretPos = Sel.text.length;
	}
	// Firefox support
	else if (ctrl.selectionStart || ctrl.selectionStart == '0')
		CaretPos = ctrl.selectionStart;
	return (CaretPos);
}
function setCaretPosition(ctrl, pos){
	if(ctrl.setSelectionRange) {
		ctrl.focus();
		ctrl.setSelectionRange(pos,pos);
	}
	else if (ctrl.createTextRange) {
		var range = ctrl.createTextRange();
		range.collapse(true);
		range.moveEnd('character', pos);
		range.moveStart('character', pos);
		range.select();
	}
}

function quickTag(e) {
	var tmpPos = doGetCaretPosition(this);
	var tag, posO, posC;
	var text = $(this).val();
	if(text.substring(tmpPos-2, tmpPos) == '$$') {
		var preText = text.substring(0,tmpPos-2);
		posO = preText.lastIndexOf('[tex]');
		posC = preText.lastIndexOf('[/tex]');
		if(posO > posC) {
			tag = '[/tex]';
		} else {
			tag = '[tex]';
		}
		text = text.substring(0,tmpPos-2) + tag + text.substring(tmpPos);
		$(this).val(text);
		setCaretPosition(this, tmpPos+tag.length-2);
	} else {
		var b = text.substring(tmpPos-2, tmpPos);
		var preText = text.substring(0,tmpPos-2);
		for(brace in lt_brace) {
			if(b == brace) {
				text = text.substring(0,tmpPos-2) + lt_brace[brace] + text.substring(tmpPos);
				$(this).val(text);
				setCaretPosition(this, tmpPos+lt_brace[brace].length-2);
				break;
			}
		}
	}
}

function fillLocals() {
	$('#localScreenWidth').val(screen.width);
	$('#localScreenHeight').val(screen.height);
	var t = new Date();
	$('#localTime').val(parseInt(t.getTime()/1000));
}
//-----



/**
* Shows the help messages in the helpline window
*/
function helpline(help)
{
	document.forms[form_name].helpbox.value = help_line[help];
}

/**
* Fix a bug involving the TextRange object. From
* http://www.frostjedi.com/terra/scripts/demo/caretBug.html
*/ 
function initInsertions() 
{
	var doc;

	if (document.forms[form_name])
	{
		doc = document;
	}
	else 
	{
		if(!opener) return;
		doc = opener.document;
	}

	var textarea = doc.forms[form_name].elements[text_name];
	if (is_ie && typeof(baseHeight) != 'number')
	{	
		textarea.focus();
		baseHeight = doc.selection.createRange().duplicate().boundingHeight;

		if (!document.forms[form_name])
		{
			document.body.focus();
		}
	}
}

/*
function remove_tex_tags()
{
	var textarea;
	textarea = document.forms[form_name].elements[text_name];
	textarea.value = textarea.value.replace(/\[tex\]/gi, '').replace(/\[\/tex\]/gi, '');
}
*/


/**
* bbstyle
*/
function bbstyle(bbnumber)
{	
	if (bbnumber != -1)
	{
		bbfontstyle(bbtags[bbnumber], bbtags[bbnumber+1]);
	} 
	else 
	{
		insert_text('[*]');
		document.forms[form_name].elements[text_name].focus();
	}
}

/**
* Apply bbcodes
*/
function bbfontstyle(bbopen, bbclose)
{
	theSelection = false;
		
	var textarea = document.forms[form_name].elements[text_name];

	textarea.focus();

	if ((clientVer >= 4) && is_ie && is_win)
	{
		// Get text selection
		theSelection = document.selection.createRange().text;

		if (theSelection)
		{
			// Add tags around selection
			document.selection.createRange().text = bbopen + theSelection + bbclose;
			document.forms[form_name].elements[text_name].focus();
			theSelection = '';
			return;
		}
	}
	else if (document.forms[form_name].elements[text_name].selectionEnd && (document.forms[form_name].elements[text_name].selectionEnd - document.forms[form_name].elements[text_name].selectionStart > 0))
	{
		mozWrap(document.forms[form_name].elements[text_name], bbopen, bbclose);
		document.forms[form_name].elements[text_name].focus();
		theSelection = '';
		return;
	}
	
	//The new position for the cursor after adding the bbcode
	var caret_pos = getCaretPosition(textarea).start;
	var new_pos = caret_pos + bbopen.length;

	// Open tag
	insert_text(bbopen + bbclose);

	// Center the cursor when we don't have a selection
	// Gecko and proper browsers
	if (!isNaN(textarea.selectionStart))
	{
		textarea.selectionStart = new_pos;
		textarea.selectionEnd = new_pos;
	}	
	// IE
	else if (document.selection)
	{
		var range = textarea.createTextRange(); 
		range.move("character", new_pos); 
		range.select();
		storeCaret(textarea);
	}

	textarea.focus();
	return;
}

/**
* Insert text at position
*/
function insert_text(text, spaces, popup)
{
	var textarea;
	
	if (!popup) 
	{
		textarea = document.forms[form_name].elements[text_name];
	} 
	else 
	{
		textarea = opener.document.forms[form_name].elements[text_name];
	}
	if (spaces) 
	{
		text = ' ' + text + ' ';
	}
	
	// Since IE9, IE also has textarea.selectionStart, but it still needs to be treated the old way.
	// Therefore we simply add a !is_ie here until IE fixes the text-selection completely.
	if (!isNaN(textarea.selectionStart) && !is_ie)
	{
		var sel_start = textarea.selectionStart;
		var sel_end = textarea.selectionEnd;

		mozWrap(textarea, text, '');
		textarea.selectionStart = sel_start + text.length;
		textarea.selectionEnd = sel_end + text.length;
	}	
	
	else if (textarea.createTextRange && textarea.caretPos)
	{
		if (baseHeight != textarea.caretPos.boundingHeight) 
		{
			textarea.focus();
			storeCaret(textarea);
		}		
		var caret_pos = textarea.caretPos;
		caret_pos.text = caret_pos.text.charAt(caret_pos.text.length - 1) == ' ' ? caret_pos.text + text + ' ' : caret_pos.text + text;
		
	}
	else
	{
		textarea.value = textarea.value + text;
	}
	if (!popup) 
	{
		textarea.focus();
	} 	

}

/**
* Add inline attachment at position
*/
function attach_inline(index, filename)
{
	insert_text('[attachment=' + index + ']' + filename + '[/attachment]');
	document.forms[form_name].elements[text_name].focus();
}

/**
* Add quote text to message
*/
function addquote(post_id, username, l_wrote)
{
	var message_name = 'message_' + post_id;
	var theSelection = '';
	var divarea = false;

	if (l_wrote === undefined)
	{
		// Backwards compatibility
		l_wrote = 'wrote';
	}

	if (document.all)
	{
		divarea = document.all[message_name];
	}
	else
	{
		divarea = document.getElementById(message_name);
	}

	// Get text selection - not only the post content :(
	// IE9 must use the document.selection method but has the *.getSelection so we just force no IE
	if (window.getSelection && !is_ie)
	{
		theSelection = window.getSelection().toString();
	}
	else if (document.getSelection && !is_ie)
	{
		theSelection = document.getSelection();
	}
	else if (document.selection)
	{
		theSelection = document.selection.createRange().text;
	}

	if (theSelection == '' || typeof theSelection == 'undefined' || theSelection == null)
	{
		if (divarea.innerHTML)
		{
			theSelection = divarea.innerHTML.replace(/<br>/ig, '\n');
			theSelection = theSelection.replace(/<br\/>/ig, '\n');
			theSelection = theSelection.replace(/&lt\;/ig, '<');
			theSelection = theSelection.replace(/&gt\;/ig, '>');
			theSelection = theSelection.replace(/&amp\;/ig, '&');
			theSelection = theSelection.replace(/&nbsp\;/ig, ' ');
		}
		else if (document.all)
		{
			theSelection = divarea.innerText;
		}
		else if (divarea.textContent)
		{
			theSelection = divarea.textContent;
		}
		else if (divarea.firstChild.nodeValue)
		{
			theSelection = divarea.firstChild.nodeValue;
		}
	}

	if (theSelection)
	{
		if (bbcodeEnabled)
	{
		insert_text('[quote="' + username + '"]' + theSelection + '[/quote]');
		}
		else
		{
			insert_text(username + ' ' + l_wrote + ':' + '\n');
			var lines = split_lines(theSelection);
			for (i = 0; i < lines.length; i++)
			{
				insert_text('> ' + lines[i] + '\n');
			}
		}
	}

	return;
}


function split_lines(text)
{
	var lines = text.split('\n');
	var splitLines = new Array();
	var j = 0;
	for(i = 0; i < lines.length; i++)
	{
		if (lines[i].length <= 80)
		{
			splitLines[j] = lines[i];
			j++;
		}
		else
		{
			var line = lines[i];
			do
			{
				var splitAt = line.indexOf(' ', 80);
				
				if (splitAt == -1)
				{
					splitLines[j] = line;
					j++;
				}
				else
				{
					splitLines[j] = line.substring(0, splitAt);
					line = line.substring(splitAt);
					j++;
				}
			}
			while(splitAt != -1);
		}
	}
	return splitLines;
}

/**
* From http://www.massless.org/mozedit/
*/
function mozWrap(txtarea, open, close)
{
	var selLength = (typeof(txtarea.textLength) == 'undefined') ? txtarea.value.length : txtarea.textLength;
	var selStart = txtarea.selectionStart;
	var selEnd = txtarea.selectionEnd;
	var scrollTop = txtarea.scrollTop;

	/*if (selEnd == 1 || selEnd == 2) 
	{
		selEnd = selLength;
	}*/

	var s1 = (txtarea.value).substring(0,selStart);
	var s2 = (txtarea.value).substring(selStart, selEnd);
	var s3 = (txtarea.value).substring(selEnd, selLength);

	txtarea.value = s1 + open + s2 + close + s3;
	txtarea.selectionStart = selStart + open.length;
	txtarea.selectionEnd = selEnd + open.length;
	txtarea.focus();
	txtarea.scrollTop = scrollTop;

	return;
}

/**
* Insert at Caret position. Code from
* http://www.faqts.com/knowledge_base/view.phtml/aid/1052/fid/130
*/
function storeCaret(textEl)
{
	if (textEl.createTextRange)
	{
		textEl.caretPos = document.selection.createRange().duplicate();
	}
}

/**
* Color pallette
*/
function colorPalette(dir, width, height)
{
	var r = 0, g = 0, b = 0;
	var numberList = new Array(6);
	var color = '';

	numberList[0] = '00';
	numberList[1] = '40';
	numberList[2] = '80';
	numberList[3] = 'BF';
	numberList[4] = 'FF';

	document.writeln('<table cellspacing="1" cellpadding="0" border="0">');

	for (r = 0; r < 5; r++)
	{
		if (dir == 'h')
		{
			document.writeln('<tr>');
		}

		for (g = 0; g < 5; g++)
		{
			if (dir == 'v')
			{
				document.writeln('<tr>');
			}
			
			for (b = 0; b < 5; b++)
			{
				color = String(numberList[r]) + String(numberList[g]) + String(numberList[b]);
				document.write('<td bgcolor="#' + color + '" style="width: ' + width + 'px; height: ' + height + 'px;">');
				document.write('<a href="#" onclick="bbfontstyle(\'[color=#' + color + ']\', \'[/color]\'); return false;"><img src="images/spacer.gif" width="' + width + '" height="' + height + '" alt="#' + color + '" title="#' + color + '" /></a>');
				document.writeln('</td>');
			}

			if (dir == 'v')
			{
				document.writeln('</tr>');
			}
		}

		if (dir == 'h')
		{
			document.writeln('</tr>');
		}
	}
	document.writeln('</table>');
}

/**
* Color bar
*/
function colorBar(container) {
	var out = '<div class="color-bar">';
	var colorList = ['FF0000', '00FF00', '0000FF', 'FFA34F', '006600'];
	var colorNames = ['czerwony', 'zielony', 'niebieski', 'pomarańczowy-admin', 'zielony-moderator'];
	
	for(var i=0;i<colorList.length;i++) {
		out += '<a href="#" onclick="bbfontstyle(\'[color=#' + colorList[i] + ']\', \'[/color]\'); return false;" style="background-color: #'+colorList[i]+';" title="'+colorNames[i]+' (#'+colorList[i]+')"></a>';
	}
	out += '<br style="clear: both;"></div>';
	$(container).html(out);
	$('.color-bar > a').mouseover(function(){document.forms[form_name].helpbox.value = $(this).attr('title');});
}

/**
* Caret Position object
*/
function caretPosition()
{
	var start = null;
	var end = null;
}


/**
* Get the caret position in an textarea
*/
function getCaretPosition(txtarea)
{
	var caretPos = new caretPosition();
	
	// simple Gecko/Opera way
	if(txtarea.selectionStart || txtarea.selectionStart == 0)
	{
		caretPos.start = txtarea.selectionStart;
		caretPos.end = txtarea.selectionEnd;
	}
	// dirty and slow IE way
	else if(document.selection)
	{
		// get current selection
		var range = document.selection.createRange();

		// a new selection of the whole textarea
		var range_all = document.body.createTextRange();
		range_all.moveToElementText(txtarea);
		
		// calculate selection start point by moving beginning of range_all to beginning of range
		var sel_start;
		
		try
		{

		for (sel_start = 0; range_all.compareEndPoints('StartToStart', range) < 0; sel_start++)
		{		
			range_all.moveStart('character', 1);
		}
	
		txtarea.sel_start = sel_start;
	
		// we ignore the end value for IE, this is already dirty enough and we don't need it
		caretPos.start = txtarea.sel_start;
		caretPos.end = txtarea.sel_start;
		}
		catch(e)
		{
		}

	}

	return caretPos;
}


/**
* luka52: Dodaje tekst do pola "Powod edycji postu"
*/
function add_edit_reason(text)
{
	var edit_reason;
	edit_reason = document.postform.edit_reason;
	edit_reason.value = edit_reason.value + text + ' ';
	edit_reason.focus();
}