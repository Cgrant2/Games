//Include libraries
#include "audio.h"
#include "video.h"
#include "input.h"
#include "time.h"
#include "math.h"
#include "misc.h"
#include "string.h"

//Include header for queue functionality
#include "assets/queues.h"

//Texture Definitions
#define TextureBG 0
#define TextureCursor 1 
#define TextureTowers 2
#define TextureBlackBlock 3

//Region Definitions
#define RegionBG 0
#define RegionCursor 1
#define RegionTowers 4
#define RegionBlackBlock 25

//Sound Definitions
#define SoundBG 0


//////////
// Main //
//////////

void main() {

	//Seed the RNG
	srand( get_time() );

	//Define Variables
	int[30] textdisplayer;
	int health = 255;
	int killCount = 0;
	int enemax = 16;
	int bits = 255;
	int cooldown;
	int spawn;
	int cursorX = 9;
	int cursorY = 5;
	int menuY = 0;
	bool menuFlag = false;
	bool placeFlag = true;

	//Create node pointers for list traversal
    GameObject *tmp = NULL;
    tmp = (GameObject *) malloc(sizeof(GameObject));
    GameObject *vmp = NULL;
    vmp = (GameObject *) malloc(sizeof(GameObject));

	///////////////////
	// Define Assets //
	///////////////////

	//Background
	select_texture(TextureBG);
	select_region(RegionBG);
	define_region_topleft( 0, 0, 639, 359 );

	//Cursor Block
	select_texture(TextureCursor);
	select_region(RegionCursor);
	define_region_matrix(RegionCursor, 0, 0, 31, 31, 0, 0, 2, 1, 0);

	//Towers
	select_texture(TextureTowers);
	select_region(RegionTowers);
	define_region_matrix(RegionTowers, 0, 0, 31, 31, 0, 0, 3, 6, 0);

	//Menu Text Border
	select_texture(TextureBlackBlock);
	select_region(RegionBlackBlock);
	define_region_topleft( 0, 0, 194, 79 );

	//Create a queue for enemies
	Queue *Bloons = mkqueue( 50 );

	//Create a queue for towers
	Queue *Towers = mkqueue( 150 );
	
	//Create a queue for buying towers
	Queue *Constructor = mkqueue( 1 );

	//////////////////
	// Start Screen //
	//////////////////

	while(gamepad_button_b() <= 0) {
		clear_screen( color_black );
		print_at(0, 10, " > Oh no, your device is being attacked!");
		print_at(0, 30, " > Random bits are invading to steal your data");
		print_at(0, 50, " > The only way to destroy them is with Bitwise Logic (TM)");
		print_at(0, 70, " > You only have a few towers at your disposal:");
		print_at(0, 90, " > AND, OR, NOT, XOR, LSHIFT, and RSHIFT");
		print_at(0, 110, " > Use these towers to destroy the rogue numbers");
		print_at(0, 130, " > I will give you 255 bits to buy your first tower(s)");
		print_at(0, 150, " > Good luck");
		print_at(0, 190, " > Use the D-Pad to move your cursor");
		print_at(0, 210, " > Use B to interact");
		print_at(0, 230, " > Use A to upgrade");
		print_at(0, 250, " > Press B to start");
		if( get_frame_counter() % 60 < 30 ) {
			print_at(0, 290, " > _");
		}
		else if( get_frame_counter() % 60 > 30 ) {
			print_at(0, 290, " > ");
		}
		end_frame();
	}
	cooldown = 10;
	spawn = 180;

	select_sound( SoundBG );
	set_sound_loop( true );
	play_sound_in_channel( SoundBG, 1 );
	select_channel( 1 );

	/////////////////
	//Gameplay Loop//
	/////////////////
	while(true) {
		//Set/Reset All necessary variables
		health = 255;
		killCount = 0;
		enemax = 16;
		bits = 255;
		cursorX = 9;
		cursorY = 5;
		menuY = 0;
		menuFlag = false;
		placeFlag = true;
		Bloons = clearqueue( Bloons );
		Towers = clearqueue( Towers );
		Constructor = clearqueue( Constructor );


		while(health > 0) {

			//Decrement cooldowns
			cooldown --;
			spawn --;
			tmp = Towers -> front;
			while( tmp!= NULL ) {
				tmp -> cooldown --;
				tmp = tmp -> next;
			}

			//Enemy Movement
			tmp = Bloons -> front;
			while( tmp != NULL ) {
				if(get_frame_counter() % 15 == 0) {
					if(tmp -> ypos == 0 || tmp -> ypos == 20 || tmp -> ypos == 32) {
						tmp -> xpos++;
					}
					if( tmp -> xpos == 20 || tmp -> xpos == 32 || tmp -> xpos == 72) {
						tmp -> ypos++;
					}
					else if( tmp -> xpos == 40 ) {
						tmp -> ypos--;
					}
				}
				if( tmp -> xpos > 76 ) {
					health -= tmp -> value;
					Bloons = dequeue( Bloons, &tmp );
					tmp = rmnode( tmp );
					tmp = Bloons -> front;
				}
				else {
					tmp = tmp -> next;
				}
			}

			//Spawn a new enemy 
			if( spawn <= 0 ) {
				tmp = mkenemy( 0, 0, 1 + rand() % (enemax-1));
				Bloons = enqueue( Bloons, tmp );
				if(enemax < 32) {
					spawn = 90;
				}
				else {
					spawn = 45;
				}
			}

			//Enemy Logic
			tmp = Bloons -> front;
			while( tmp != NULL ) {
				if(tmp -> value <= 0){
					killCount += 1;
					Bloons = dequeue( Bloons, &tmp );
					tmp = rmnode( tmp );
					tmp = Bloons -> front;
				}
				else {	
					tmp = tmp -> next;
				}
			}
			if( killCount >= enemax ) {
				enemax *= 2;
			}


			//Move Cursor
			if( gamepad_up() > 0 && cooldown <= 0 ) {
				cooldown = 8;
				if( menuFlag && menuY >= 0 ) {
					menuY--;
				}
				else if( cursorY > 0 ) {
					cursorY--;
				}
				if ( menuFlag && menuY < 0 ) {
					menuY = 5;
				}
			}
			if( gamepad_down() > 0 && cooldown <= 0 ) { 
				cooldown = 8;
				if( menuFlag && menuY < 6 ) {
					menuY++;
				}
				else if ( cursorY < 10 ) {
					cursorY++;
				}
				if ( menuFlag && menuY > 5 ) {
					menuY = 0;
				}
			}
			if( gamepad_left() > 0 && cooldown <= 0 && cursorX > 0) {
				cooldown = 8;
				cursorX--;
			}
			if( gamepad_right() > 0 && cooldown <= 0 && cursorX <= 19) {
				cooldown = 8;
				cursorX++;
			}


			//Display Tower Menu
			if(cursorX == 20) {
				menuFlag = true;
				if(cursorY > 6 ) {
					cursorY = 0;
				}
				else if(cursorY < 0){
					cursorY = 5;
				}
			}
			else {
				menuFlag = false;
			}

			//Select a Tower to Buy
			if(menuFlag) {
				if(gamepad_button_b() > 0 && Constructor -> amount == 0) {
					tmp = mktower(cursorX, cursorY, menuY+1);
					Constructor = enqueue( Constructor, tmp );
					cooldown = 15;
					cursorX --;
				}
			}

			tmp = Constructor -> front; 
			if( tmp != NULL ) {
				tmp -> xpos = cursorX;
				tmp -> ypos = cursorY;
			}


			//Assume Tower Placeable
			placeFlag = true;

			//Place and Buy a Tower
			vmp = Constructor -> front;
			tmp = Towers -> front;

			//Check if the location is valid
			if( vmp -> ypos == 0 && vmp -> xpos <= 5 ) {
				placeFlag = false;
			}
			else if( vmp -> xpos == 5 && vmp -> ypos <= 5 ) {
				placeFlag = false;
			}
			else if( vmp -> ypos == 5 && vmp -> xpos >= 5 && vmp -> xpos <= 8 ) {
				placeFlag = false;
			}
			else if( vmp -> xpos == 8 && vmp -> ypos >= 5 && vmp -> ypos <= 8  ) {
				placeFlag = false;
			}
			else if( vmp -> ypos == 8 && vmp -> xpos >= 8 && vmp -> xpos <= 10 ) {
				placeFlag = false;
			}
			else if( vmp -> xpos == 10 && vmp -> ypos >= 5 && vmp -> ypos <= 8 ) {
				placeFlag = false;
			}
			else if( vmp -> ypos == 5 && vmp -> xpos >= 10 && vmp -> xpos <= 18 ) {
				placeFlag = false;
			}
			else if( vmp -> xpos == 18 && vmp -> ypos >= 5 && vmp -> ypos <= 8 ) {
				placeFlag = false;
			}
			else if( vmp -> ypos == 8 && vmp -> xpos >= 18 && vmp -> xpos <= 19 ) {
				placeFlag = false;
			}
			else {
				while( tmp != NULL ) {
					if( tmp -> xpos == cursorX ) {
						if( tmp -> ypos == cursorY ) {
							placeFlag = false;
						}
					}
					tmp = tmp -> next;
				}
			}

			if( !menuFlag ) {
				if( gamepad_button_b() > 0 && Constructor -> amount == 1 && cooldown <=0 && placeFlag ) {
					//Cost of each tower
					//Left shift
					if( vmp -> type == 1 && bits >= 50 ) {
						vmp = Constructor -> front;
						Constructor = dequeue( Constructor, &vmp );
						vmp -> xpos = cursorX;
						vmp -> ypos = cursorY;
						Towers = enqueue( Towers, vmp );
						bits -=50;
					}
					//Right shift
					else if( vmp -> type == 2 && bits >= 30 ) {
						vmp = Constructor -> front;
						Constructor = dequeue( Constructor, &vmp );
						vmp -> xpos = cursorX;
						vmp -> ypos = cursorY;
						Towers = enqueue( Towers, vmp );
						bits -=30;
					}
					//And
					else if( vmp -> type == 3 && bits >= 75 ) {
						vmp = Constructor -> front;
						Constructor = dequeue( Constructor, &vmp );
						vmp -> xpos = cursorX;
						vmp -> ypos = cursorY;
						Towers = enqueue( Towers, vmp );
						bits -=75;
					}
					//Or
					else if( vmp -> type == 4 && bits >= 150 ) {
						vmp = Constructor -> front;
						Constructor = dequeue( Constructor, &vmp );
						vmp -> xpos = cursorX;
						vmp -> ypos = cursorY;
						Towers = enqueue( Towers, vmp );
						bits -=150;
					}
					//Xor
					else if( vmp -> type == 5 && bits >= 125 ) {
						vmp = Constructor -> front;
						Constructor = dequeue( Constructor, &vmp );
						vmp -> xpos = cursorX;
						vmp -> ypos = cursorY;
						Towers = enqueue( Towers, vmp );
						bits -=125;
					}
					//Not 
					else if( vmp -> type == 6 && bits >= 50 ) {
						vmp = Constructor -> front;
						Constructor = dequeue( Constructor, &vmp );
						vmp -> xpos = cursorX;
						vmp -> ypos = cursorY;
						Towers = enqueue( Towers, vmp );
						bits -=50;
					}
				}
			}


			//Upgrade a Tower
			if( gamepad_button_a() > 0 && cooldown <= 0 ) {
				tmp = Towers -> front;
				while(tmp != NULL) {
					if(tmp -> xpos == cursorX && tmp -> ypos == cursorY && tmp -> level < 3) {
						//Left Shift Upgrade
						if(tmp -> type == 1) {
							if(tmp -> level == 1 && bits >= 100) {
								tmp -> level ++;
								bits -= 100;
							}
							else if(tmp -> level == 2 && bits >= 300) {
								tmp -> level ++;
								bits -= 300;
							}
						}
						//Right Shift Upgrade
						else if(tmp -> type == 2) {
							if(tmp -> level == 1 && bits >= 50 ) {
								tmp -> level ++;
								bits -= 50;
							}
							else if(tmp -> level == 2 && bits >= 200 ) {
								tmp -> level ++;
								bits -= 200;
							}
						}
						//And Upgrade
						else if(tmp -> type == 3) {
							if(tmp -> level == 1 && bits >= 150) {
								tmp -> level ++;
								bits -= 150;
							}
							else if(tmp -> level == 2 && bits >= 750) {
								tmp -> level ++;
								bits -= 500;
							}
						}
						//Or Upgrade
						else if(tmp -> type == 4) {
							if(tmp -> level == 1 && bits >= 150) {
								tmp -> level ++;
								bits -= 150;
							}
							else if(tmp -> level == 2 && bits >= 1000) {
								tmp -> level ++;
								bits -= 1000;
							}
						}
						//Xor Upgrade
						else if(tmp -> type == 5) {
							if(tmp -> level == 1 && bits >= 150) {
								tmp -> level ++;
								bits -= 150;
							}
							else if(tmp -> level == 2 && bits >= 300) {
								tmp -> level ++;
								bits -= 300;
							}
						}
						//Not Upgrade
						else if(tmp -> type == 6) {
							if(tmp -> level == 1 && bits >= 100) {
								tmp -> level ++;
								bits -= 100;
							}
							else if(tmp -> level == 2 && bits >= 200) {
								tmp -> level ++;
								bits -= 200;
							}
						}
					}
					tmp = tmp -> next;
				}
				cooldown = 15;
			}

			//Tower Shoot Logic
			//Start at top of the tower list
			tmp = Towers -> front;
			vmp = Bloons -> front;
			float distance;
			while( tmp != NULL ) {
				//Calculate distance from the front enemy to each tower
				distance = sqrt( pow((tmp -> xpos) - (vmp -> xpos/4), 2) + pow((tmp -> ypos) - (vmp -> ypos/4), 2) );

				//if the enemy is within range, shoot
				if( distance < tmp -> range && tmp -> cooldown <= 0 ) {
					//Left shift tower logic
					if(tmp -> type == 1) {
						//Level 1 tower
						if (tmp -> level == 1) {
							if(vmp -> value > enemax/2) {
								vmp -> value = (vmp -> value - enemax/2) * 2;
								bits += enemax/2;
							}
							else {
								vmp -> value *= 2;
							}
							if( vmp -> value >= enemax ) {
								vmp -> value = 0;
								bits += enemax/2;
							}
							tmp -> cooldown = 120;
						}
						//Level 2 tower
						else if (tmp -> level == 2) {
							if(vmp -> value > enemax/2) {
								vmp -> value = (vmp -> value - enemax/2) * 2;
								bits += enemax/2;
							}
							else {
								vmp -> value *= 2;
							}
							if( vmp -> value >= enemax ) {
								vmp -> value = 0;
								bits += enemax/2;
							}
							tmp -> cooldown = 90;
						}
						//Level 3 tower
						else if (tmp -> level == 3) {
							if(vmp -> value > enemax/2) {
								vmp -> value = (vmp -> value - enemax/2) * 2;
								bits += enemax/2;
							}
							else {
								vmp -> value *= 2;
							}
							if( vmp -> value >= enemax ) {
								vmp -> value = 0;
								bits += enemax/2;
							}
							tmp -> cooldown = 60;
						}
					}
					//Right shift tower logic
					if(tmp -> type == 2) {
						//Level 1 tower
						if( tmp -> level == 1) {
							vmp -> value /= 2;
							bits +=1;
							tmp -> cooldown = 45;
						}
						//Level 2 tower
						else if( tmp -> level == 2) {
							vmp -> value /= 4;
							bits +=3;
							tmp -> cooldown = 37;
						}
						//Level 3 tower
						else if( tmp -> level == 3) {
							vmp -> value /= 16;
							bits +=15;
							tmp -> cooldown = 30;
						}
					}
					//And tower logic
					if(tmp -> type == 3) {
						//Level 1 tower
						if( tmp -> level == 1 ) {
							int curvalue = vmp -> value;
							vmp -> value = vmp -> value & (enemax - 1 - enemax/2 - enemax/8);
							bits += (curvalue - vmp -> value);
							tmp -> cooldown = 150;
						}
						//Level 2 tower
						else if( tmp -> level == 2 ) {
							int curvalue = vmp -> value;
							vmp -> value = vmp -> value & (enemax - 1 - enemax/2 - enemax/8 - enemax/16 - enemax/32);
							bits += (curvalue - vmp -> value);
							tmp -> cooldown = 120;
						}
						//Level 3 tower
						else if( tmp -> level == 3 ) {
							int curvalue = vmp -> value;
							vmp -> value = vmp -> value & 1;
							bits += (curvalue - vmp -> value);
							tmp -> cooldown = 90;
						}
					}
					//Or tower logic
					if(tmp -> type == 4) {
						//Level 1 tower
						if( tmp -> level == 1 ) {
							vmp -> value = vmp -> value | enemax/2;
							tmp -> cooldown = 120;
						}
						//Level 2 tower
						else if( tmp -> level == 2 ) {
							vmp -> value = vmp -> value | enemax/2 + enemax/4 + enemax/8 + enemax/16;
							tmp -> cooldown = 120;
						}
						//Level 3 tower
						else if( tmp -> level == 3 ) {
							vmp -> value = vmp -> value | enemax-1;
							tmp -> cooldown = 120;
						}
					}
					//Xor tower logic
					if(tmp -> type == 5) {
						//Level 1 tower
						if( tmp -> level == 1 ) {
							int curvalue = vmp -> value;
							vmp -> value = vmp -> value ^ (enemax - 1 - enemax/2 - enemax/4);
							bits += (curvalue - vmp -> value);
							tmp -> cooldown = 120;
						}
						//Level 2 tower
						else if( tmp -> level == 2 ) {
							int curvalue = vmp -> value;
							vmp -> value = vmp -> value ^ (enemax - 1 - enemax/2 - enemax/4 - enemax/8 - enemax/16) ;
							bits += (curvalue - vmp -> value);
							tmp -> cooldown = 90;
						}
						//Level 3 tower
						else if( tmp -> level == 3 ) {
							int curvalue = vmp -> value;
							vmp -> value = vmp -> value ^ (vmp -> value + 1);
							bits += (curvalue - vmp -> value);
							tmp -> cooldown = 45;
						}
					}
					//Not tower logic
					if(tmp -> type == 6) {
						vmp -> value = vmp -> value ^ enemax - 1;
						if(tmp -> level == 1) {
							tmp -> cooldown = 120;
						}
						else if(tmp -> level == 2) {
							tmp -> cooldown = 90;
						}
						else if(tmp -> level == 3) {
							tmp -> cooldown = 60;
						}
					}
				}

				tmp = tmp -> next;
			}


			/////////////////////
			// Draw Everything //
			/////////////////////

			//Background
			select_texture(TextureBG);
			select_region(RegionBG);
			draw_region_at( 0, 0 );

			//Cursor
			if(get_frame_counter() % 30 > 15) {
				select_texture(TextureCursor);
				select_region(RegionCursor);
				draw_region_at( 32*cursorX, 32*cursorY+4 );
			}
			else {
				select_texture(TextureCursor);
				select_region(RegionCursor+1);
				draw_region_at( 32*cursorX, 32*cursorY+4 );
			}

			//Selected Unplaced Tower
			select_texture(TextureTowers);
			select_region( RegionTowers + 3*(Constructor -> front -> type - 1));
			draw_region_at( 32*cursorX, 32*cursorY-4 );

			//Placed Towers
			tmp = Towers -> front;
			while( tmp != NULL ) {
				select_texture(TextureTowers);
				select_region( RegionTowers + 3*(tmp -> type - 1) + tmp -> level - 1);
				draw_region_at( 32*tmp -> xpos, 32*tmp -> ypos+2 );
				tmp = tmp -> next;
			}

			//Enemies
			tmp = Bloons -> front;
			while(tmp != NULL) {
				if(tmp -> value > 0) {
					itoa( tmp -> value, textdisplayer, 10 );
					print_at( tmp -> xpos * 8, tmp -> ypos * 8 + 10, textdisplayer );
				}
				tmp = tmp -> next;
			}

			//Tower Menu
			if( menuFlag ) {

				//Currently Selected Tower
				select_texture(TextureTowers);
				select_region(RegionTowers + (3*menuY));
				set_drawing_scale( 2, 2 );
				draw_region_zoomed_at( 576, 148 );
				
				//Previous Tower
				if( menuY > 0 ) {
					select_texture(TextureTowers);
					select_region(RegionTowers + (3*(menuY-1)));
				}
				else {
					select_texture(TextureTowers);
					select_region(RegionTowers + 15);
				}
				draw_region_at( 598, 116);

				//Next Tower
				if( menuY < 5 ) {
					select_texture(TextureTowers);
					select_region(RegionTowers + (3*(menuY+1)));
				}
				else {
					select_texture(TextureTowers);
					select_region(RegionTowers);
				}
				draw_region_at( 598, 212);

				//Info Text
				//L Shift
				if(menuY == 0) {
					//BorderBlock
					select_texture(TextureBlackBlock);
					select_region(RegionBlackBlock);
					draw_region_at( 465, 250 );
					//Text
					print_at( 475, 260, "Left Shift" );
					print_at( 475, 280, "Cost:50 bits" );
					print_at( 475, 300, "Causes overflows" );
				}
				//R Shift
				else if(menuY == 1) {
					//BorderBlock
					select_texture(TextureBlackBlock);
					select_region(RegionBlackBlock);
					draw_region_at( 455, 250 );
					//Text
					print_at( 465, 260, "Right Shift" );
					print_at( 465, 280, "Cost:30 bits" );
					print_at( 465, 300, "Causes underflows" );
				}
				//And
				else if(menuY == 2) {
					//BorderBlock
					select_texture(TextureBlackBlock);
					select_region(RegionBlackBlock);
					draw_region_at( 465, 250 );
					//Text
					print_at( 475, 260, "And" );
					print_at( 475, 280, "Cost:75 bits" );
					print_at( 475, 300, "Does Bitwise And" );
				}
				//Or
				else if(menuY == 3) {
					//BorderBlock
					select_texture(TextureBlackBlock);
					select_region(RegionBlackBlock);
					draw_region_at( 475, 250 );
					//Text
					print_at( 485, 260, "Or" );
					print_at( 485, 280, "Cost:150 bits" );
					print_at( 485, 300, "Does Bitwise Or" );
				}
				//Xor
				else if(menuY == 4) {
					//BorderBlock
					select_texture(TextureBlackBlock);
					select_region(RegionBlackBlock);
					draw_region_at( 465, 250 );
					//Text
					print_at( 475, 260, "Xor" );
					print_at( 475, 280, "Cost:125 bits" );
					print_at( 475, 300, "Does Bitwise Xor" );
				}
				//Not
				else if(menuY == 5) {
					//BorderBlock
					select_texture(TextureBlackBlock);
					select_region(RegionBlackBlock);
					draw_region_at( 505, 250 );
					//Text
					print_at( 515, 260, "Not" );
					print_at( 515, 280, "Cost:50 bits" );
					print_at( 515, 300, "Inverts Bits" );
				}

			}

			//Display the amount of health bits the player has

			//Health
			itoa( health, textdisplayer, 10 );
			print_at( 640-(10*(7+strlen(textdisplayer))), 0, "Health:");
			print_at( 640-(10*strlen(textdisplayer)), 0, textdisplayer );

			//Bits
			itoa( bits, textdisplayer, 10 );
			print_at( 640-(10*(5+strlen(textdisplayer))), 20, "Bits:");
			print_at( 640-(10*strlen(textdisplayer)), 20, textdisplayer );

			end_frame();
		}

		//determine max enemy wave
		int wave = 0;
		while(enemax > 0) {
			enemax /= 2;
			wave ++;
		}
		wave -= 5;
		while(gamepad_button_b() <= 0) {
			itoa( wave, textdisplayer, 10 );
			clear_screen( color_black );
			print_at(0, 110, " > You're device has been comprimised");
			print_at(0, 130, " > You made it through");
			print_at(230, 130, textdisplayer);
			print_at(230+(10*(strlen(textdisplayer))), 130, " waves");
			print_at(0, 150, " > Try again?");
			if( get_frame_counter() % 60 < 30 ) {
				print_at(0, 290, " > _");
			}
			else if( get_frame_counter() % 60 > 30 ) {
				print_at(0, 290, " > ");
			}
			end_frame();
		}
	}
}
