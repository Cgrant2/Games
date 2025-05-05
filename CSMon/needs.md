Current needs:

Inputs:
=======
	Overworld:
	----------
	D-Pad - movement
	A     - interact
	Start - open menu

	Menu:
	-----
	; If the menu is open we need input to reflect that ;
	D-Pad - menu select movement
	A     - open inner menu (ie bag, settings, etc)
	B     - close menu / close inner menu

	Dialogue:
	---------
	A/B   - Continue dialogue
	
	Battle Scene:
	-------------
	essentially menu inputs, but modified
	to work with a battle interface

Map:
====
	~~Something to parse the tilemap~~
	~~Something to draw the tilemap~~
	Something to handle map transitions
	(it would be inefficient and difficult to have 1 universal map)

Scene:
======
	Something that stores the current scene
	Something that can handle scene transitions
	(Ovw --> battle and vice versa)

Storage:
========
	A storage scheme for multi-use data
	(ie a template for a pokemon that has sprite/stat data)
	A storage scheme for tile data, ie collisions/special interactions
	A storage scheme for the actual tile map, (double pointer?)
