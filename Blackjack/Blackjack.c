//Include libraries
#include "audio.h"
#include "video.h"
#include "input.h"
#include "time.h"
#include "math.h"
#include "misc.h"
#include "string.h"

//Include header for list functionality
#include "assets/doublelist.h"

//Include header for stack functionality
#include "assets/stacks.h"

//Texture Definitions
#define TextureMat 0
#define TextureCardBack 1
#define TextureCards 2

//Region Definitions
#define RegionBackground 0
#define RegionCardBack 1
#define RegionCardFace 2

//Sound Definitions
#define SoundBG 0


//Gameplay Definitions
#define frames_per_second 60

///////////////
// Functions //
///////////////

Stack *shuffle ( Stack *stack ) {
	//set up some variables
	List *shuffler = NULL;
	shuffler = mklist();
	GameObject *tmp = NULL;
	int randy = 0;

	//move the stack into a list
	tmp = stack -> top;
	while ( tmp != NULL) {
		stack = pop( stack, &tmp );
		shuffler = append(shuffler, shuffler -> end, tmp);
		tmp = stack -> top;
	}

	//randomly choose, obtain, and push nodes to the stack
	while( shuffler -> length > 0 ) {
		tmp = shuffler -> start;
		randy = rand( ) % (shuffler -> length);
		while (randy > 0) {
			tmp = tmp -> next;
			randy--;
		}
		shuffler = obtain(shuffler, &tmp);
		stack = push( stack, tmp );
	}
	return stack;
}

///////////////////////////
/////                 /////
/////  Main Function  /////
/////                 /////
///////////////////////////

void main() {
	//rng
	srand( get_time() );

	//Variables
	int i;
	int cooldown = 0;     
	int xcoord = 200;
	int ycoord = 300;
	int dealerpoints = 0;
	int playerpoints = 0;
	bool playerturn = true;
	bool end = false;
	bool win;
	bool tie = false;
	int[30] points;
	int money = 500;
	int[30] bank;
	int bet = 0;

	//Create node pointers for list traversal
	GameObject *tmp = NULL;
	tmp = (GameObject *) malloc(sizeof(GameObject));
	GameObject *vmp = NULL;
	vmp = (GameObject *) malloc(sizeof(GameObject));

	//Create stack pointers for stacklist traversal
	Stack *stmp = NULL;
	stmp = (Stack *) malloc(sizeof(Stack));
	Stack *svmp = NULL;
	svmp = (Stack *) malloc(sizeof(Stack));

	//Define Regions

	//Background
	select_texture(TextureMat);
	select_region(RegionBackground);
	define_region_topleft( 0, 0, 640, 360 );

	//Card back
	select_texture(TextureCardBack);
	select_region(RegionCardBack);
	define_region_center( 0, 0, 68, 94 );

	//Cards Face
	select_texture(TextureCards);
	define_region_matrix( RegionCardFace, 1, 1, 68, 94, 34, 47, 13, 4, 1 );

	//Define Sounds

	//Background Music
	assign_channel_sound( 1, SoundBG );


	//Create stacks for game
	Stack *Deck = mkstack( 52 );
	Stack *Dealer = mkstack( 12 );
	Stack *Hand = mkstack( 12 ); 

	//Create a stack list with our stacks
	Stacklist *Stackerinos = mkstacklist();
	Stackerinos = stackappend(Stackerinos, Stackerinos -> end, Deck );
	Stackerinos = stackappend(Stackerinos, Stackerinos -> end, Dealer );
	Stackerinos = stackappend(Stackerinos, Stackerinos -> end, Hand );

	//Initialize a deck with all 52 standard cards
	int suit = 0;
	for(i=0; i<54; i++) {
		if( (i % 13) == 0 && i != 0) {
			suit++;
		}
		tmp = mknode( ((i % 13) + 1), suit );
		Deck = push( Deck, tmp );
	}

	////////////////////////////
	/////                  /////
	/////  Gameplay Loops  /////
	/////                  /////
	////////////////////////////
	
	select_channel( 1 );
	set_channel_loop( true );
	play_channel( 1 );
	//Repeat Gameloop
	while(true) {
		playerturn = true;
		end = false;
		tie = false;

		//Start screen
		while( gamepad_button_b() <= 0 && gamepad_button_y() <=0 && gamepad_button_a() <=0 ) {

			//Draw background
			select_texture(TextureMat);
			select_region(RegionBackground);
			draw_region_at(0, 0);
			
			//Print player's balance
			itoa(money, bank, 10);
			set_drawing_point(10, 10);
			print("$");
			set_drawing_point(20, 10);
			print(bank);

			//Start screen text
			set_drawing_point(220, 70);
			print("Welcome to Blackjack");
			set_drawing_point(250, 90);
			print("Press B to hit");
			set_drawing_point(245, 110);
			print("Press Y to stay");

			set_drawing_point(0, 250);
			print("Press A to bet 50");
			set_drawing_point(230, 250);
			print("Press B to bet 100");
			set_drawing_point(460, 250);
			print("Press Y to bet 500");

			end_frame();
		}
		if( gamepad_button_a() > 0) {
			bet = 50;
		}
		else if( gamepad_button_b() > 0) {
			bet = 100;
		}
		else if( gamepad_button_y() > 0) {
			bet = 500;
		}

		//Avoid Auto-Hitting
		cooldown = 30; 
		
		//Shuffle the deck
		Deck = shuffle(Deck);

		//Draw a card from the deck for the player
		tmp = Deck -> top;
		Deck = pop( Deck, &tmp );
		Hand = push( Hand, tmp );
		
		//Draw a card from the deck for the dealer
		tmp = Deck -> top;
		Deck = pop( Deck, &tmp );
		Dealer = push( Dealer, tmp );
		tmp -> faceup = false;
		
		//Draw a card from the deck for the player
		tmp = Deck -> top;
		Deck = pop( Deck, &tmp );
		Hand = push( Hand, tmp );
		
		//Draw a card from the deck for the dealer
		tmp = Deck -> top;
		Deck = pop( Deck, &tmp );
		Dealer = push( Dealer, tmp );
		
	
		//Main Gameloop
		while( !end ) {
			
			//Draw background
			select_texture(TextureMat);
			select_region(RegionBackground);
			draw_region_at(0, 0);

			//Print player's balance
			itoa(money, bank, 10);
			set_drawing_point(10, 10);
			print("$");
			set_drawing_point(20, 10);
			print(bank);

			////////////////////////
			//Calculate the points//
			////////////////////////

			//Calculate the amount of points the player has
			tmp = Hand -> top;
			playerpoints = 0;
			while( tmp != NULL) {
				int realvalue;
				if( tmp -> value > 1 && tmp -> value < 11 ) {
					realvalue = tmp -> value;
				}
				else if( tmp -> value > 10) {
					realvalue = 10;
				}
				else if( playerpoints < 10 ) {
					realvalue = 11;
				}
				else {
					realvalue = 1;
				}
				playerpoints += realvalue;
				tmp = tmp -> prev;
			}
			if(playerpoints == 21) {
				playerturn=false;
				while(tmp != NULL) {
					tmp -> faceup = true;
					tmp = tmp -> prev;
				}
			}
			if(playerpoints > 21) {
				while(tmp != NULL) {
					tmp -> faceup = true;
					tmp = tmp -> prev;
				}
				end = true;
			}

			//Player Stay
			if( gamepad_button_y() > 0 && cooldown <= 0 && playerturn ) {
				playerturn = false;
				tmp = Dealer -> top;
				while(tmp != NULL) {
					tmp -> faceup = true;
					tmp = tmp -> prev;
				}
			}

			//Calculate the amount of points the dealer has
			tmp = Dealer -> top;
			dealerpoints = 0;
			while( tmp != NULL) {
				int realvalue;
				if( tmp -> faceup ) {
					if( tmp -> value > 1 && tmp -> value < 11 ) {
						realvalue = tmp -> value;
					}
					else if( tmp -> value > 10) {
						realvalue = 10;
					}
					else if( dealerpoints < 10 ) {
						realvalue = 11;
					}
					else {
						realvalue = 1;
					}
					dealerpoints += realvalue;
				}
				tmp = tmp -> prev;
			}
			//Dealer Stay
			if( !playerturn && dealerpoints > 16 ) {
				end = true;
			}

			/////////////
			//Hit Logic//
			/////////////

			//Player Hit
			if( gamepad_button_b() > 0 && cooldown <= 0 && playerturn ) {
				tmp = Deck -> top;
				Deck = pop( Deck, &tmp );
				Hand = push( Hand, tmp );
				cooldown = 10;
			}
			//Decrement the cooldown
			cooldown--;

			//Dealer Hit
			if( !playerturn && dealerpoints < 17 && get_frame_counter() % 40 == 0 ) {
				tmp = Deck -> top;
				Deck = pop( Deck, &tmp );
				Dealer = push( Dealer, tmp );
			}


			//draw the dealer's cards
			xcoord = 320;
			ycoord = 50;
			vmp = Dealer -> top; 

			while(vmp != NULL) {
				if(! vmp -> faceup) {
					select_texture(TextureCardBack);
					select_region(RegionCardBack);
				}
				else {
					select_texture(TextureCards);
					select_region(RegionCardFace + (vmp -> suit * 13) + (vmp -> value - 1));
				}
				set_drawing_scale( 1, -1 );
				draw_region_zoomed_at(xcoord, ycoord);
				xcoord += 20;
				vmp = vmp -> prev;
			}
			xcoord += 100;
			itoa(dealerpoints, points, 10);
			print_at(xcoord, ycoord, points);

			//draw the player's cards
			xcoord = 320;
			ycoord = 310;
			vmp = Hand -> top; 

			while(vmp != NULL) {
				select_texture(TextureCards);
				select_region(RegionCardFace + (vmp -> suit * 13) + (vmp -> value - 1));
				draw_region_at(xcoord, ycoord);
				xcoord += 20;
				vmp = vmp -> prev;
			}
			xcoord += 100;
			itoa(playerpoints, points, 10);
			print_at(xcoord, ycoord, points);

			end_frame();
		}

		cooldown = 180;

		while( cooldown > 0 ) {
			cooldown --;
			//Draw background
			select_texture(TextureMat);
			select_region(RegionBackground);
			draw_region_at(0, 0);

			//Print player's balance
			itoa(money, bank, 10);
			set_drawing_point(10, 10);
			print("$");
			set_drawing_point(20, 10);
			print(bank);

			//Print the result
			if(playerpoints > 21) {
				set_drawing_point(265, 155);
				print("Player Bust");
				set_drawing_point(280, 175);
				print("You Lose");
				win = false;
			}
			else if(dealerpoints > 21){
				set_drawing_point(265 ,155);
				print("Dealer Bust");
				set_drawing_point(285, 175);
				print("You Win");
				win = true;
			}
			else if(dealerpoints > playerpoints ) {
				set_drawing_point(255 ,155);
				print("Dealer Higher");
				set_drawing_point(280, 175);
				print("You Lose");
				win = false;
			}
			else if(playerpoints > dealerpoints){
				set_drawing_point(255 ,155);
				print("Player Higher");
				set_drawing_point(285, 175);
				print("You Win");
				win = true;
			}
			else if(playerpoints == dealerpoints) {
				set_drawing_point(270 ,155);
				print("Same Value");
				set_drawing_point(305, 175);
				print("Tie");
				tie = true;
			}
			else if(playerpoints == 21) {
				set_drawing_point(260 ,155);
				print("BlackJack!!!");
				set_drawing_point(285, 175);
				print("You Win");
				win = true;
			}
			
			//Print the time until restart
			itoa(cooldown/60, points, 10);
			print_at(screen_width/2-5, 200, points);


			//draw the dealer's cards
			xcoord = 320;
			ycoord = 50;
			vmp = Dealer -> top; 

			while(vmp != NULL) {
				select_texture(TextureCards);
				select_region(RegionCardFace + (vmp -> suit * 13) + (vmp -> value - 1));
				set_drawing_scale( 1, -1 );
				draw_region_zoomed_at(xcoord, ycoord);
				xcoord += 20;
				vmp = vmp -> prev;
			}
			xcoord += 100;
			itoa(dealerpoints, points, 10);
			print_at(xcoord, ycoord, points);

			//draw the player's cards
			xcoord = 320;
			ycoord = 310;
			vmp = Hand -> top; 

			while(vmp != NULL) {
				select_texture(TextureCards);
				select_region(RegionCardFace + (vmp -> suit * 13) + (vmp -> value - 1));
				draw_region_at(xcoord, ycoord);
				xcoord += 20;
				vmp = vmp -> prev;
			}
			xcoord += 100;
			itoa(playerpoints, points, 10);
			print_at(xcoord, ycoord, points);

			end_frame();
		}

		//Put all of the cards back into the deck
		tmp = Hand -> top;
		while( tmp != NULL ) {
			Hand = pop( Hand, &tmp );
			Deck = push( Deck, tmp);
			tmp = Hand -> top;
		}
		tmp = Dealer -> top;
		while( tmp != NULL ) {
			Dealer = pop( Dealer, &tmp );
			Deck = push( Deck, tmp);
			tmp = Dealer -> top;
		}
		if( !tie ) {
			if( win ) {
				money += bet;
			}
			else if( !win ) {
				money -= bet;
			}
		}
	}
}
