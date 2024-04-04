/// @description Insert description here
// You can write your code in this editor
startLines=[
	"<!DOCTYPE html>",
	"<html>",
	"<head>",
	"<title>Page Title</title>",
	"</head>",
	"<body>",
]

endLines=[
	"</body>",
	"</html>",
]

lines=[
	"<h1>This is a Heading</h1>",
	"<p>This is a paragraph.</p>",
]

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
	save_file(_str,game_save_id+"/html.html")
}