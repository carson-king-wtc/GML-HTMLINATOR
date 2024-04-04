/// @description Insert description here
// You can write your code in this editor

var _x=32
var _y=scrollOffset
for(var i=0;i<array_length(lines);i++)
{
	var _line=lines[i]
	
	var _formatStartOpen=string_pos("<",_line)
	var _formatStartClose=string_pos(">",_line)
	
	var _format=string_copy(_line,_formatStartOpen,abs(_formatStartOpen-_formatStartClose))
	
	_line=string_delete(_line,_formatStartOpen,abs(_formatStartOpen-_formatStartClose)+1)
	
	var _formatEndOpen=string_last_pos("<",_line)
	var _formatEndClose=string_last_pos(">",_line)
	_line=string_delete(_line,_formatEndOpen,abs(_formatEndOpen-_formatEndClose)+1)
	
	var _formatID=-4
	for(var o=0;o<ds_map_size(lineFormatting);o++)
	{
		if(string_count(ds_map_find_value(lineFormatting,o).startOfLine,_format)>0)
		{
			_formatID=o
		}
	}
	
	draw_set_font(fn_default)
	draw_set_color(c_black)
	
	var _size=1
	
	if(_formatID==lineTypes.headerBig)
	{
		_size=2
		draw_set_font(fn_default_bold)
	}
	if(_formatID==lineTypes.headerMiddle)
	{
		_size=1.75
		draw_set_font(fn_default_bold)
	}
	if(_formatID==lineTypes.headerSmall)
	{
		_size=1.5
		draw_set_font(fn_default_bold)
	}
	if(_formatID==lineTypes.link)
	{
		draw_set_color(c_blue)
		var _linkPos=string_pos("href=",_format)
		var _link=string_copy(_format,_linkPos+5,_formatStartClose)
		_link=string_replace_all(_link,"\"","")
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x,_y,_x+string_width(_line),_y+string_height(_line)))
		{
			draw_set_color(c_aqua)
			if(mouse_check_button_pressed(mb_left))
			{
				url_open(_link)
			}
		}
	}
	if(_formatID==lineTypes.button)
	{
		draw_rectangle(_x,_y,_x+string_width(_line),_y+string_height(_line),true)
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x,_y,_x+string_width(_line),_y+string_height(_line)))
		{
			draw_set_color(c_gray)
			draw_rectangle(_x,_y,_x+string_width(_line),_y+string_height(_line),false)
			draw_set_color(c_black)
			if(mouse_check_button_pressed(mb_left))
			{
				
			}
		}
	}
	
	draw_text_transformed(_x,_y,_line,_size,_size,0)
	_y+=64
}