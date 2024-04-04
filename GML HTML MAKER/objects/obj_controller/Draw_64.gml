/// @description Insert description here
// You can write your code in this editor
var _x=32
var _y=scrollOffset
for(var i=0;i<array_length(lines);i++)
{
	var _line=lines[i]
	draw_text(_x,_y,_line)
	_y+=64
}