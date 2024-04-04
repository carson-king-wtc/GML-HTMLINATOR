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
	if(string_count("<img",_line)>0)
	{
		_formatID=lineTypes.image
	}
	if(_formatID==lineTypes.image)
	{
		_line=lines[i]
		
		var _linkPos=string_pos("src=",_line)
		var _endPos=string_pos_ext("\"",_line,_linkPos)
		var _link=string_copy(_line,_linkPos+4,_endPos)
		_link=string_replace_all(_link,"\"","")
		
		var _imageID=_link
		
		_linkPos=string_pos("width=",_line)
		_endPos=string_pos_ext("h",_line,_linkPos)
		_link=string_copy(_line,_linkPos+6,_endPos)
		_link=string_replace_all(_link,"\"","")
		
		var _width=real(_link)
		
		_linkPos=string_pos("height=",_line)
		_endPos=string_pos_ext(">",_line,_linkPos)
		_link=string_copy(_line,_linkPos+7,_endPos-1)
		_link=string_replace_all(_link,"\"","")
		
		var _height=real(_link)
		
		if(ds_map_find_value(images,_imageID)==undefined)
		{
			ds_map_add(images,_imageID,sprite_add(_imageID,1,false,false,0,0))
		}
		else
		{
			var _spr=ds_map_find_value(images,_imageID)
			var _xScale=_width/sprite_get_width(_spr)
			var _yScale=_height/sprite_get_height(_spr)
			draw_sprite_ext(_spr,0,_x,_y,_xScale,_yScale,0,c_white,1)
		}
		
		_line=""
	}
	
	draw_text_transformed(_x,_y,_line,_size,_size,0)
	_y+=64
	if(lines[i]=="<p></p>")
	{
		_y-=64
	}
}