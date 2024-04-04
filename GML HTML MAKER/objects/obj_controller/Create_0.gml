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
	"<h1>This is a Heading</h1>",
	
	"<h2>This is a medium Heading</h2>",
	
	"<h3>This is a small Heading</h3>",
	
	"<p>This is a Har Har paragraph</p>",
	
	"<a href=\"https://www.w3schools.com\">This is a link</a>",
	
	"<p></p>",
	
	"<button>Button</button>",
	
	"<p></p>",
	
	"<img src=\"image.png\" width=\"104\" height=\"142\">"
]

function format_string_line_breaks(str){
	return string_replace_all(str,"\\n","\n")
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

ds_map_add(lineFormatting,lineTypes.paragraph,{startOfLine:"<p",endOfLine:"/<p>"})

ds_map_add(lineFormatting,lineTypes.headerBig,{startOfLine:"<h1",endOfLine:"/<h1>"})

ds_map_add(lineFormatting,lineTypes.headerMiddle,{startOfLine:"<h2",endOfLine:"/<h2>"})

ds_map_add(lineFormatting,lineTypes.headerSmall,{startOfLine:"<h3",endOfLine:"/<h3>"})

ds_map_add(lineFormatting,lineTypes.link,{startOfLine:"<a",endOfLine:"/<a>"})

ds_map_add(lineFormatting,lineTypes.button,{startOfLine:"<button",endOfLine:"</button>"})

function add_line(type){
	var _str=get_string("type in the line (use \n for a new line)","")
	
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

scrollOffset=0

scrollSpeed=0

maxScrollSpeed=15