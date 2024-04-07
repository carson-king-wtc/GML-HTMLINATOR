/// @description Insert description here
// You can write your code in this editor

var _x=32
var _y=scrollOffset
for(var i=0;i<array_length(lines);i++)
{
	draw_set_color(c_black)
	_x=32
	var _line=lines[i]
	
	var _formatStartOpen=string_pos("<",_line)
	var _formatStartClose=string_pos(">",_line)
	
	var _charactersAtStart=abs(_formatStartOpen-_formatStartClose)
	
	var _format=string_copy(_line,_formatStartOpen,_charactersAtStart)
	
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
	
	var _isInHitbox=point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x,_y,_x+string_width(_line),_y+string_height(_line))
	
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
		if(_isInHitbox)
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
		draw_set_color(c_white)
		if(_isInHitbox)
		{
			draw_set_color(c_gray)
			
			if(mouse_check_button(mb_left))
			{
				draw_set_color(c_dkgray)
			}
		}
		draw_rectangle(_x,_y,_x+string_width(_line),_y+string_height(_line),false)
		draw_set_color(c_black)
	}
	if(string_count("<img",_line)>0)
	{
		_formatID=lineTypes.image
	}
	if(_formatID==lineTypes.image)
	{
		_line=lines[i]
		
		var _linkPos=string_pos("\"",_line)
		var _endPos=string_pos_ext("\"",_line,_linkPos+1)
		var _link=string_copy(_line,_linkPos,abs(_linkPos-_endPos))
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
			if(!is_undefined(_spr)&&sprite_exists(_spr))
			{
				var _xScale=_width/sprite_get_width(_spr)
				var _yScale=_height/sprite_get_height(_spr)
				draw_sprite_ext(_spr,0,_x,_y,_xScale,_yScale,0,c_white,1)
				if(string_count(".webp",_imageID)>0)
				{
					draw_text(_x,_y,"the engine can not display webp files, sorry! (it will appear on the site tho)")
				}
				if(string_count(".gif",_imageID)>0)
				{
					draw_text(_x,_y,"gifs are not animated in engine, they will be on your site!")
				}
			}
		}
		
		_y+=_height
		
		_line=""
	}
	
	_line=string_replace_all(_line,"<br>","\n")
	
	_isInHitbox=point_in_rectangle(
	device_mouse_x_to_gui(0),
	device_mouse_y_to_gui(0),
	_x,
	_y,
	_x+string_width(_line)*_size,
	_y+string_height(_line)*_size)
	if(_isInHitbox)
	{
		draw_set_color(c_red)
		if(mouse_check_button_pressed(mb_right))
		{
			lineEditing=i
			lineIndex=string_length(_line)+1
		}
	}
	var _editLine=_line
	var _pressedNonTextKey=false
	if(lineEditing==i)
	{
		var _lineBreaks=find_line_breaks(_line)
		show_debug_message(_lineBreaks)
		for(var o=0;o<array_length(_lineBreaks);o++)
		{
			if(lineIndex>=_lineBreaks[o])
			{
				_charactersAtStart++
			}
		}
		if(lineTimer>15)
		{
			_editLine=string_insert("^",_line,lineIndex)
		}
		if(keyboard_check(vk_backspace))
		{
			if(keyboard_check_pressed(vk_backspace))
			{
				backTime=0
			}
			if(lineIndex!=1)
			{
				if(keyboard_check_pressed(vk_backspace)||backTime>30)
				{
					lines[i]=string_delete(lines[i],lineIndex+_charactersAtStart,1)
					lineIndex--
				}
			}
			backTime++
			_pressedNonTextKey=true
		}
		
		if(keyboard_check_pressed(vk_left))
		{
			arrowHoldTime=0
			lineIndex--
			if(lineIndex<1)
			{
				lineIndex=1
			}
			_pressedNonTextKey=true
		}
		if(keyboard_check_pressed(vk_right))
		{
			arrowHoldTime=0
			lineIndex++
			if(lineIndex>string_length(_line)+1)
			{
				lineIndex=string_length(_line)+1
			}
			_pressedNonTextKey=true
		}
		if(keyboard_check_pressed(vk_home))
		{
			lineIndex=0
		}
		if(keyboard_check_pressed(vk_end))
		{
			lineIndex=string_length(_line)+1
		}
		if(keyboard_check(vk_left)&&arrowHoldTime>30)
		{
			lineIndex--
			if(lineIndex<1)
			{
				lineIndex=1
			}
			_pressedNonTextKey=true
		}
		if(keyboard_check(vk_right)&&arrowHoldTime>30)
		{
			lineIndex++
			if(lineIndex>string_length(_line)+1)
			{
				lineIndex=string_length(_line)+1
			}
			_pressedNonTextKey=true
		}
		arrowHoldTime++
		/*if(keyboard_check_pressed(vk_enter))
		{
			lines[i]=string_insert("\n",lines[i],lineIndex+_charactersAtStart)
			lineIndex+=2
			_pressedNonTextKey=true
		}*/
		if(keyboard_check_pressed(vk_anykey)&&!_pressedNonTextKey&&!keyboard_check(vk_control))
		{
			lines[i]=string_insert(keyboard_lastchar,lines[i],lineIndex+_charactersAtStart +1)
			lineIndex++
			keyboard_lastchar=""
		}
	}
	
	draw_text_transformed(_x,_y,_editLine,_size,_size,0)
	
	
	
	if(lines[i]=="")
	{
		//_y-=string_height(_line)*2
	}
	else
	{
		var _height=string_height(_line)*1.9
		if(_formatID==lineTypes.image)
		{
			_height=64
		}
		_x+=string_width(_line)*_size +64
		if(_line=="")
		{
			_x=128
			_height=64
		}
	
		draw_rectangle(_x,_y,_x+128,_y+_height,true)
		if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),
		_x,_y,_x+128,_y+_height))
		{
			if(mouse_check_button_pressed(mb_left))
			{
				array_delete(lines,i,1)
				break;
			}
		}
		draw_text(_x,_y,"delete line")
	}
	_y+=string_height(_line)*2
}
draw_set_color(c_black)
_x=128
_y=16

for(var i=0;i<ds_map_size(lineFormatting);i++)
{
	var val=ds_map_find_value(lineFormatting,i)
	var _xScale=1
	if(string_width(val.name)*1.5>128)
	{
		_xScale=string_width(val.name)*1.5/128
	}
	draw_sprite_ext(spr_text_button,0,_x,_y,_xScale,1,0,c_white,1)
	draw_text(_x,_y,val.name)
	if(point_in_rectangle(device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),_x,_y,_x+128,_y+64))
	{
		if(mouse_check_button_pressed(mb_left))
		{
			add_line(i)
		}
	}
	_x+=128*_xScale
}