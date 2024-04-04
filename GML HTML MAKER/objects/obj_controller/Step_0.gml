/// @description Insert description here
// You can write your code in this editor

scrollSpeed-=scrollSpeed/10

if(mouse_wheel_down())
{
	scrollSpeed+=-maxScrollSpeed
}
if(mouse_wheel_up())
{
	scrollSpeed+=maxScrollSpeed
}

scrollOffset+=scrollSpeed