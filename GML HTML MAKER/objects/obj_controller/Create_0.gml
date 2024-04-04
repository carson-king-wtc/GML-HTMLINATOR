/// @description Insert description here
// You can write your code in this editor
startLines=[
	"<!DOCTYPE html>",
	"<html>",
	"<head>",
	"<title>fr fr</title>",
	"</head>",
	"<body>",
]

endLines=[
	"</body>",
	"</html>",
]

lines=[
	"<h1>This is a <br>Heading<br>Heading<br>Heading<br>Heading</h1>",
	
	"<h2>This is a medium Heading</h2>",
	
	"<h3>This is a small Heading</h3>",
	
	"<a href=\"https://www.w3schools.com\">This is a link</a>",
	
	"<p></p>",
	
	"<button>Button</button>",
	
	"<p></p>",
]

function format_string_line_breaks(str){
	return string_replace_all(str,"\\n","<br>")
}

enum lineTypes{
	paragraph,
	headerBig,
	headerMiddle,
	headerSmall,
	link,
	button,
	image,
	list
}

lineFormatting=ds_map_create()

ds_map_add(lineFormatting,lineTypes.paragraph,{startOfLine:"<p",endOfLine:"</p>",name:"Paragraph"})

ds_map_add(lineFormatting,lineTypes.headerBig,{startOfLine:"<h1",endOfLine:"</h1>",name:"Big Header"})

ds_map_add(lineFormatting,lineTypes.headerMiddle,{startOfLine:"<h2",endOfLine:"</h2>",name:"Medium Header"})

ds_map_add(lineFormatting,lineTypes.headerSmall,{startOfLine:"<h3",endOfLine:"</h3>",name:"Small Header"})

ds_map_add(lineFormatting,lineTypes.link,{startOfLine:"<a",endOfLine:"</a>",name:"Link"})

ds_map_add(lineFormatting,lineTypes.button,{startOfLine:"<button",endOfLine:"</button>",name:"Button"})

ds_map_add(lineFormatting,lineTypes.image,{startOfLine:"<img",endOfLine:">",name:"Image"})

images=ds_map_create()

function new_line(){
	return "<br>"
}

function add_line(type){
	var _str="w"
	if(type!=lineTypes.image)
	{
		_str=get_string("type in the line (use \\n for a new line)","")
	}
	if(_str=="")
	{
		return 0
	}
	
	var _previousStr=_str
	var hasLineBreaks=false
	_str = format_string_line_breaks(_str)
	
	if(_str!=_previousStr)
	{
		hasLineBreaks=true
	}
	
	if(type==lineTypes.link)
	{
		var _link=get_string("link","https://youtube.com")
		var _format=ds_map_find_value(lineFormatting,type)
		_str=_format.startOfLine+" href=\""+_link+"\">"+_str+_format.endOfLine
	}
	else if(type==lineTypes.image)
	{
		var _image=get_open_filename("image files","")
		file_copy(_image,game_save_id+filename_name(_image))
		var _format=ds_map_find_value(lineFormatting,type)
		_str=_format.startOfLine+" src=\""+filename_name(_image)+"\" width=\"999\" height=\"520\">"
	}
	else{
		var _format=ds_map_find_value(lineFormatting,type)
		_str=_format.startOfLine+">"+_str+_format.endOfLine
	}
	array_push(lines,_str)
	return 1
}

function save_html(){
	var _str=""
	for(var i=0;i<array_length(startLines);i++)
	{
		_str=_str+startLines[i]+"\n"
	}
	for(var i=0;i<array_length(lines);i++)
	{
		_str=_str+lines[i]+"\n"
	}
	for(var i=0;i<array_length(endLines);i++)
	{
		_str=_str+endLines[i]+"\n"
	}
	save_file(_str,game_save_id+"html.html")
}

scrollOffset=128

scrollSpeed=0

maxScrollSpeed=15