//Include libraries
#include "audio.h"
#include "video.h"
#include "input.h"
#include "time.h"
#include "math.h"
#include "misc.h"
#include "string.h"

//Texture Definitions
#define TexturePlayer 0
#define TextureEnemy 1
#define TextureFireball 2
#define TextureArrow 3

//Region Definitions
#define RegionPlayerAnim1 0
#define RegionPlayerAnim2 1
#define RegionPlayerAnim3 2
#define RegionEnemyAnim1  3
#define RegionEnemyAnim2  4
#define RegionEnemyAnim3  5
#define RegionFireball 6
#define RegionArrow 7

//Sound Definitions
#define SoundMusic 0
#define SoundPlayerShoot 1
#define SoundEnemyShoot 2

//Gameplay Definitions
#define MoveSpeed 3
#define frames_per_second 60
#define EnemyCount  45

//Structure Declarations

struct GameObject {
	bool active;             //whether or not the object is alive/displayed/in memory
	int X;                   //x coordinate of the object
	int Y;                   //y coordinate of the object
	int hp;                  //amount of hits an object can take, enemy is typically 1, player is typically 3, projectile is 0
	int vector;              //For enemies: + is right, - is left, For projectiles: + is down, - is up, For both: magnitude is speed 
	int shootCooldown;       //Amount of time before enemy can shoot, when 0 shooting is possible
	GameObject *projectile;  //projectile shot by enemies
	GameObject *next;        //pointer to the next enemy in the list
};

struct List {
	GameObject *start;       //pointer to the start of the list
	GameObject *end;         //pointer to the end of the list
	int length;             //length of the list
};

struct Shield {
	int hp;             //amount of hits the shield can take before being destroyed
	int X, Y;           //x and y coordinate of the shield center
	int width;          //width of the shield from center to edge, not full width
};

//List Functions

//make a projectile node
GameObject *mkprojectile (int xpos, int ypos, int vect) {
	GameObject *node = NULL;
	node = (GameObject *)malloc(sizeof(GameObject));
	node -> X = xpos;
	node -> Y = ypos;
	node -> active = false;
	node -> vector = vect;
	node -> hp = NULL;
	node -> shootCooldown = NULL;
	node -> projectile = NULL;
	node -> next = NULL;
	return (node);
}

//make an enemy node
GameObject *mkenemy (int xpos, int ypos) {
	GameObject *node = NULL;
	node = (GameObject *)malloc(sizeof(GameObject));
	node -> X = xpos;
	node -> Y = ypos;
	node -> hp = 1;
	node -> active = true;
	node -> vector = 1;
	node -> shootCooldown = 60 + rand() % 180;
	node -> projectile = mkprojectile(node -> X, node -> Y, 3);
	node -> next = NULL;
	return (node);
}

//remove a node
GameObject *rmnode (GameObject *node) {
	free(node);
	node = NULL;
	return(node);	
}

//make a list
List *mklist () {
	List *list;
	list = (List *)malloc(sizeof(List));
	list -> length = 0; 
	list -> start = NULL;
	list -> end = NULL;
	return(list);

}

//insert a node into a list
List *insert (List *list, GameObject *location, GameObject *node) {
	if(list -> start == NULL) {
		list -> start = node;
		list -> end = node;
	}
	else if(location == list -> start) {
		node -> next = location;
		list -> start = node;
	}
	else {
		GameObject *tmpnode;
		tmpnode = list -> start;
		while( tmpnode -> next != location) {
			tmpnode = tmpnode -> next;
		}
		node -> next = tmpnode -> next;
		tmpnode -> next = node;
	}
	list -> length ++;
	return (list);
}

//append a node into a list
List *append (List *list, GameObject *location, GameObject *node) {
	if(list -> start == NULL) {
		list -> start = node;
		list -> end = node;
	}
	else if(location == list -> end) {
		location -> next = node;
		list -> end = node;
	}
	else {
		node -> next = location -> next;
		location -> next = node;
	}
	list -> length ++;
	return (list);
}

//obtain a node from a list
List *obtain (List *list, GameObject **node) {
	GameObject *temp = list -> start;
	if( list -> start == (*node) ) {
		list -> start = (*node) -> next;
	}
	else {
		while( temp -> next != (*node) ) {
			temp = temp -> next;
		}
		temp -> next = (*node) -> next;
	}
	list -> length --;
	return(list);
}

//clear a list
List *clearlist (List *list) {
	GameObject *temp = list -> start;
	GameObject *temp2 = temp -> next;
	GameObject **temp3 = &temp;
	while( temp != NULL ) {
		obtain(list, temp3);
		rmnode(temp);
		temp = temp2;
		temp2 = temp -> next;
		temp3 = &temp;
	}
	return(list);
}

//remove a list
List *rmlist (List *list) {
	list = clearlist(list);
	free(list);
	list = NULL;
	return(list);
}



//Main function
void main( void ) {

	/////////////////////////////
	//
	//   Defining the textures
	// 
	/////////////////////////////

	//Player Sprites
		//Dragon texture 1
		select_texture( TexturePlayer );
		select_region( RegionPlayerAnim1 );
		define_region_center( 0, 0, 32, 32 );

		//Dragon texture 2
		select_texture( TexturePlayer );
		select_region( RegionPlayerAnim2 );
		define_region_center( 33, 0, 64, 33 );
		
		//Dragon texture 3
		select_texture( TexturePlayer );
		select_region( RegionPlayerAnim3 );
		define_region_center( 0, 33, 33, 64 );
	
	//Enemy Sprites
		//Archer texture 1
		select_texture( TextureEnemy );
		select_region( RegionEnemyAnim1 );
		define_region_center( 0, 0, 32, 32 );
		
		//Archer texture 2
		select_texture( TextureEnemy );
		select_region( RegionEnemyAnim2 );
		define_region_center( 33, 0, 64, 32 );
		
		//Archer texture 3
		select_texture( TextureEnemy );
		select_region( RegionEnemyAnim3 );
		define_region_center( 0, 33, 32, 64 );

	//Projectile Sprites
		//Fireball texture
		select_texture( TextureFireball );
		select_region( RegionFireball );
		define_region_center( 0, 0, 15, 20 );

		//Arrow texture
		select_texture( TextureArrow );
		select_region( RegionArrow );
		define_region_center( 0, 0, 5, 15 );

	//////////////////////////////////
	//
	//   Setting up the load screen
	//
	//////////////////////////////////

	//Variable for mode selection
	int mode;

	//Selecting gamepad
	select_gamepad( 0 );


	//Start Screen
	while( gamepad_button_x() < 0 && gamepad_button_a() < 0 ){
		clear_screen( color_black );
		set_drawing_point( screen_width/4, screen_height/3 );
		print("Use Left/Right to move and Space to shoot");
		set_drawing_point( screen_width/3, screen_height/3 + 30 );
		print("Press E to begin in easy mode =)");
		set_drawing_point( screen_width/3, screen_height/3 + 60 );
		print("Press H to begin in hard mode =)");
		if(gamepad_button_x() > 0) {
			mode=0;
		}
		if(gamepad_button_a() > 0) {
			mode=1;
		}
	}
	
	///////////////////////////////
	//
	//   Initailazing everything
	//
	///////////////////////////////

	//Creaing a changable AmmoCount variable
	int AmmoCount;

	//Creating and initializing the player
	bool playeractive = true;
	int playerX = screen_width/2;
	int playerY = screen_height/1.1;
	int playerhp = 3;
	int playershootCooldown=0;
	
	int index;

	
	//Creating an intial node pointer
	GameObject *tmp = NULL;
	GameObject *emp = NULL;
	tmp = (GameObject *)malloc(sizeof(GameObject));
	emp = (GameObject *)malloc(sizeof(GameObject));

	GameObject *amp = NULL;
	GameObject *vamp = NULL;
	amp = (GameObject *)malloc(sizeof(GameObject));
	vamp = (GameObject *)malloc(sizeof(GameObject));
	
	//Defining a list of enemies
	List *Enemies;
	Enemies = (List *)malloc(sizeof(List));
	Enemies -> length = 0; 

	for( index=0; index<EnemyCount; index++ ) {
		//Enemies = append(Enemies, Enemies -> start, tmp);
		if (index < 15) {
			tmp -> next = mkenemy( 35 * (index+1), 30 );
		}
		else if (index < 30) {
			tmp -> next = mkenemy( 35 * (index - 14), 60 );
		}
		else {
			tmp -> next = mkenemy( 35 * (index - 29), 90 );
		}
		if( index == 0 ) {
			Enemies -> start = tmp;
		}
		tmp = tmp -> next;
		Enemies -> length ++;
		
	}

	//Initializing the player's ammo
	if( mode == 0 ){
		AmmoCount = 4;
	}
	else if( mode == 1 ) {
		AmmoCount = 2;
	}

	//Defining a list of ammo
	List *Ammo = mklist();

	//creating a win condition variable
	bool win;
	win = false;

	//playing the background music
	select_sound( SoundMusic );
	set_sound_loop( SoundMusic );
	play_sound_in_channel( SoundMusic, 15 );

	////////////////////////////////////////
	////////////////////////////////////////
	////                                ////
	////   Starting the gameplay loop   ////
	////                                ////
	////////////////////////////////////////
	////////////////////////////////////////

	//Main Loop
	while( playeractive && ! win ){

		///////////////////////
		//
		//   Player Movement
		//
		///////////////////////

		//Creating and using variables to detect movement
		int DirectionX;
		int DirectionY;
		gamepad_direction( &DirectionX, &DirectionY );
		
		//Moving player based on input
		playerX += MoveSpeed * DirectionX;

		//Boundary collision
		if (playerX > screen_width - 15) {
			playerX = screen_width - 15;
		}
		if (playerX < 15) {
			playerX = 15;
		}

		//Checking the hp of the player, and setting it to inactive if == 0
		if( playerhp == 0 ) {
			playeractive = false;
		}

		///////////////////////////////////
		//
		//   Managing player shoot logic
		//
		//////////////////////////////////

		
		//Activating the first available player projectile and playing the shoot sound
		if( gamepad_button_b() > 0 && playershootCooldown <= 0 && Ammo -> length < AmmoCount ){
			if( mode == 0) {
				playershootCooldown = 20;
			}
			if( mode == 1) {
				playershootCooldown = 40;
			}
			
			amp = mkprojectile(playerX, playerY, -3);
			Ammo = append(Ammo, Ammo -> end, amp);
			select_sound( SoundPlayerShoot );
			play_sound_in_channel( SoundPlayerShoot, 1 );
		}

		//Moving the player projectiles
		playershootCooldown --;
		vamp = Ammo -> start;
		while(vamp != NULL) {
			vamp -> Y += 1 * vamp -> vector;
			//Resetting if a projectile reaches the top of the screen
			if( vamp -> Y <= 0 ) {
				GameObject **obtainer = &vamp;
				Ammo = obtain(Ammo, obtainer);
			//	vamp = rmnode(vamp);
			}
			vamp = vamp -> next;
		}

		////////////////////////////
		//
		//   Managing the Enemies
		//
		////////////////////////////

		tmp = Enemies -> start;

		while( tmp != NULL ) {

			//Checking the hp of the enemy, and removing it if == 0
			if( tmp -> hp == 0 ) {
				GameObject *tmp2 = tmp;
				tmp = tmp -> next;
				Enemies = obtain(Enemies, &tmp2);
				tmp2 = rmnode(tmp2);
				if( tmp == NULL ) {
					break;
				}
			}

			//Enemy shooting
			if( tmp -> shootCooldown <= 0 && ! tmp -> projectile ->  active) {
				tmp -> projectile ->  X = tmp -> X;
				tmp -> projectile ->  Y = tmp -> Y;

				//Turn on the projectile and restart the cooldown with a random wait >1 sec
				tmp -> projectile ->  active = true;

				//Mode selection
				if(mode == 0) {
					//Regular/Easy Mode Enabled
					tmp -> shootCooldown = 300 + (rand( ) % 600);
				}
				else if(mode == 1) {
					//Hard Mode Enabled
					tmp -> shootCooldown = 0;
				}
			}
			else {
				tmp -> shootCooldown --;
			}
			//Enemy moving
			
			//Move enemy across x plane
			if ( get_frame_counter() % 4 == 0 ) {
				tmp -> X += 1 * tmp -> vector;

				if( tmp -> X > screen_width-15  || tmp -> X < 15) {
					emp = Enemies -> start;
					//Move all enemies row down and reverse direction
					while(  emp != NULL ) {
						emp -> Y += 30;
						emp -> vector = -1 * emp -> vector;
						emp = emp -> next;
					}
				}
			}
			/////////////////////////////////
			//
			// Enemy Projectile Management
			//
			/////////////////////////////////

			//Enemy projectile movement
			if( tmp -> projectile ->  active ) {
				tmp -> projectile ->  Y += 1 * tmp -> projectile ->  vector;
			}

			//Reset the projectile when it reaches the bottom of the screen
			if( tmp -> projectile -> Y >= screen_height ) {
				tmp -> projectile -> active = false;
			}

			///////////////////////////////////
			//
			//   Projectile Entity Collision
			//
			///////////////////////////////////

			//Enemy 2 Player projectile collision
			if( tmp -> projectile -> Y == playerY && tmp -> projectile -> active) {
				if ( tmp -> projectile -> X > playerX - 30 && tmp -> projectile -> X < playerX + 30) {
					tmp -> projectile -> active = false;
					playerhp -= 1;
				}
			}

			//Player 2 Enemy projectile collision
			amp = Ammo -> start;
			
			while( amp != NULL ) {
				if( amp -> Y == tmp -> Y && amp != NULL) {
					if ( amp -> X > tmp -> X - 13 && amp -> X < tmp -> X + 13) {
						GameObject *amp2 = amp;
						amp = amp -> next;
						Ammo = obtain(Ammo, &amp2);
						amp2 = rmnode(amp2);
						if (amp == NULL) {
							break;
						}
						tmp -> hp -= 1;
					}
				}
				amp = amp -> next;
			}
			tmp = tmp -> next;
		}

		////////////////////////////////
		//
		//   Drawing all the textures   
		//
		////////////////////////////////

		//Drawing background
		clear_screen( color_black );

		//Selecting player sprite region
		select_texture( TexturePlayer );
		if(get_frame_counter() % 20 < 5 && get_frame_counter() % 20 >= 0) {
			select_region( RegionPlayerAnim1 );
		}
		else if(get_frame_counter() % 20 < 11 && get_frame_counter() % 20 >= 5) {
			select_region( RegionPlayerAnim2 );
		}
		else if(get_frame_counter() % 20 < 21 && get_frame_counter() % 20 >= 15) {
			select_region( RegionPlayerAnim2 );
		}
		else if(get_frame_counter() % 20 < 16 && get_frame_counter() % 20 >= 10) {
			select_region( RegionPlayerAnim3 );
		}
		//Scaling the player sprite
		set_drawing_scale( 2, 2 );

		//Drawing player
		if( playeractive ) {
			draw_region_zoomed_at( playerX, playerY );
		}

		//Selecting projectile sprite region
		select_texture( TextureFireball );
		select_region( RegionFireball );

		//Drawing player projectile
		amp = Ammo -> start;
		while( amp != NULL ) {
			draw_region_at(amp -> X, amp -> Y );
			amp = amp -> next;
		}

		//Drawing every enemy in the list
		tmp = Enemies -> start;
		while(  tmp != NULL ) {	
			//Selecting enemy sprite region

			select_texture( TextureEnemy );

			if( tmp -> shootCooldown > 20){
				select_region( RegionEnemyAnim1 );
			}
			else if( tmp -> shootCooldown > 5 ){
				select_region( RegionEnemyAnim2 );
			}
			else {
				select_region( RegionEnemyAnim3 );
			}
			
			//Drawing enemy
			set_drawing_scale( 2, 2 );
			draw_region_zoomed_at( tmp -> X, tmp -> Y );

			//Selecting projectile sprite region
			select_texture( TextureArrow );
			select_region( RegionArrow );

			//Drawing enemy projectiles
			if( tmp -> projectile -> active ) {
				draw_region_at( tmp -> projectile -> X, tmp -> projectile -> Y );
			}

			tmp = tmp -> next;
		}



		/////////////////////
		//
		//   Win Condition
		//
		/////////////////////

		//Checking to see if all enemies have been killed
		tmp = Enemies -> start;
		if ( Enemies -> length == -1 ) {
			win = true;
		}

		//Ending the frame
		end_frame();
	}

	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	////////////////////////////                      //////////////////////////
	////////////////////////////   End Of Game Loop   //////////////////////////   
	////////////////////////////                      //////////////////////////  
	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////

	
	////////////////////////
	//
	//   Game over screens
	//
	////////////////////////
	while ( true ) {
		if( win ) {
			clear_screen( color_black );
			set_drawing_point( screen_width/2, screen_height/2 );
			print("You are win =)");
		}
		else {
			clear_screen( color_black );
			set_drawing_point( screen_width/2, screen_height/2 );
			print("L bozo");
		}
	}
}
