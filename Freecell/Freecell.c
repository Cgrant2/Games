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
#define TextureOutline 2
#define TextureCards 3

//Region Definitions
#define RegionBackground 0
#define RegionCardBack 1
#define RegionOutline 2 
#define RegionCardFace 3

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
	int j;
	int xcoord = 200;
	int ycoord = 300;
	int cooldown = 0;
	int currenttableau = 0;
	int currentcard = 0;
	int freecells = 4;            //Roll Credits
	int hometableau = 0;
	bool topcheck = false;
	bool foundationcheck = false;
	bool validstack = true;
	bool cellhome = false;

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

	//Outlines
	select_texture(TextureOutline);
	define_region_matrix( RegionOutline, 1, 1, 68, 94, 34, 47, 2, 2, 1 );

	//Cards Face
	select_texture(TextureCards);
	define_region_matrix( RegionCardFace, 1, 1, 68, 94, 34, 47, 13, 4, 1 );

	//Create a main card stack for game
	Stack *Cards = mkstack( 52 );

	//Create hand stacks for game
	Stack *Hand = mkstack( 15 );

	//Initialize a deck with all 52 standard cards
	int suit = 0;
	for(i=0; i<52; i++) {
		if( (i % 13) == 0 && i != 0) {
			suit++;
		}
		tmp = mknode( ((i % 13) + 1), suit );
		Cards = push( Cards, tmp );
	}

	//Shuffle the deck
	Cards = shuffle(Cards);

	//Create a stack list with our stacks
	Stacklist *Tableaus = mkstacklist();
	Stacklist *Foundations = mkstacklist();
	Stacklist *Cells = mkstacklist();

	//Initialize the Tableau stack with random cascades
	for(i=0; i<4; i++) {
		stmp = mkstack(21);
		for(j=0; j<6; j++) {
			tmp = Cards -> top;
			Cards = pop(Cards, &tmp);
			stmp = push(stmp, tmp); 
			tmp = Cards -> top;
		}
		Tableaus = stackappend(Tableaus, Tableaus -> end, stmp);
		stmp = stmp -> next;
	}
	for(i=0; i<4; i++) {
		stmp = mkstack(21);
		for(j=0; j<7; j++) {
			tmp = Cards -> top;
			Cards = pop(Cards, &tmp);
			stmp = push(stmp, tmp); 
			tmp = Cards -> top;
		}
		Tableaus = stackappend(Tableaus, Tableaus -> end, stmp);
		stmp = stmp -> next;
	}

	//Initialize the Cells and Foundations lists to be empty
	//Cells
	for(i=0; i<4; i++) {
		stmp=mkstack(1);
		Cells = stackappend( Cells, Cells -> end, stmp);
		stmp = stmp -> next;
	}

	//Foundations
	for(i=0; i<4; i++) {
		stmp=mkstack(13);
		Foundations = stackappend( Foundations, Foundations -> end, stmp);
		stmp = stmp -> next;
	}

	////////////////////////////
	/////                  /////
	/////  Gameplay Loops  /////
	/////                  /////
	////////////////////////////
	while( gamepad_button_b() <= 0 ) {
		select_texture(TextureMat);
        select_region(RegionBackground);
        draw_region_at(0, 0);
		set_drawing_point(240, 90);
		print("Press B to start");
		set_drawing_point(275, 130);
		print("Controls:");
		set_drawing_point(225, 150);
		print("D-Pad - Move cursor");
		set_drawing_point(210, 170);
		print("B - pick up card/stack");
		set_drawing_point(220, 190);
		print("Y - place card/stack");

		cooldown = 30;
	}


	currentcard = 0;
	while(true) {

		stmp = Tableaus -> start;
		for(i=0; i<currenttableau; i++) {
			stmp = stmp -> next;
		}
		foundationcheck = false;
		topcheck = false;
		//Selecting the Tableau
		if( gamepad_left() > 0 && cooldown <= 0 && currenttableau > 0 ) {
			currenttableau --;
			cooldown = 12;
			if( currentcard == stmp -> amount ) {
				stmp = stmp -> prev;
				currentcard = stmp -> amount;
			}
		}
		else if( gamepad_right() > 0 && cooldown <=0 && currenttableau < 7 ) {
			currenttableau ++;
			cooldown = 12;
			if( currentcard == stmp -> amount ) {
				stmp = stmp -> next;
				currentcard = stmp -> amount;
			}
		}
		
		//Selecting the card in the tableau
		if( stmp -> amount > 0 ) {
			if( gamepad_down() > 0 && cooldown <=0 && currentcard > 0 ) {
				currentcard --;
				cooldown = 6;
			}
			if( gamepad_up() > 0 && cooldown <=0 && currentcard < stmp -> amount ) {
				currentcard ++;
				cooldown = 6;
			}
			if( currentcard >= stmp -> amount + 1 ) {
				currentcard --;
			}
		}
		else {
			if( gamepad_up() > 0 && cooldown <=0  ) {
				currentcard = 0;
				cooldown = 6;
			}
			if( gamepad_down() > 0 && cooldown <=0 ) {
				currentcard = 1;
				cooldown=6;
			}
		}
		if( currentcard == stmp -> amount ) {
			topcheck = true;
			if( currenttableau >= 4  ) {
				foundationcheck = true;
			}
		}
		
	
		//Picking up a stack logic

		validstack = true;

		//setting stmp to the current tableau, or Cell/Foundation
		if( !topcheck ) {
			stmp = Tableaus -> start;
			for(i=0; i<currenttableau; i++) {
				if(stmp -> next != NULL) {
					stmp = stmp -> next;
				}
			}
			tmp = stmp -> top;
			if( gamepad_button_b() > 0 && cooldown <= 0 ) {
				if( Hand -> amount == 0 ) {
					for(i=1; i<=currentcard; i++){
						if(tmp -> value + 1 == tmp -> prev -> value && (tmp -> suit + 1) % 2 == tmp -> prev -> suit % 2) {
							tmp = tmp -> prev;
						}
						else {
							validstack = false;
						}
					}
					tmp = stmp -> top;
					if( validstack && currentcard <= freecells ) {
						for(i=0; i<=currentcard; i++) {
							stmp = pop( stmp, &tmp );
							Hand = push( Hand, tmp );
							tmp = stmp -> top;
							hometableau = currenttableau;
						}
					}
					cooldown = 12;
				}
				currentcard = 0;
				if ( stmp -> amount == 0 ) {
					freecells ++;
				}
			}

		}
	else if( !foundationcheck ) {
		stmp = Cells -> start;
		for(i=0; i<currenttableau; i++) {
			if( stmp -> next != NULL ) {
				stmp = stmp -> next;
			}
		}
		tmp = stmp -> top;
		if( gamepad_button_b() > 0 && cooldown <= 0 ) {
			if( Hand -> amount == 0 && stmp -> amount > 0 ) {
				stmp = pop( stmp, &tmp );
				Hand = push( Hand, tmp );
				tmp = stmp -> top;
				freecells ++;
				hometableau = currenttableau;
				cellhome = true;
				cooldown = 12;
			}
		}
	}
		else {
			stmp = Foundations -> start;
			for(i=0; i<currenttableau; i++) {
				if( stmp -> next != NULL ) {
					stmp = stmp -> next;
				}
			}
			tmp = stmp -> top;
			if( gamepad_button_b() > 0 && cooldown <= 0 ) {
				if( Hand -> amount == 0 ) {
					stmp = pop( stmp, &tmp );
					Hand = push( Hand, tmp );
					tmp = stmp -> top;
					hometableau = currenttableau;
					cooldown = 12;
				}
			}
		}


		//Putting down a stack logic

		//setting stmp to be the current tableau, or Cell/Foundation
		if( !topcheck ) {
			stmp = Tableaus -> start;
			for(i=0; i<currenttableau; i++) {
				if(stmp -> next != NULL) {
					stmp = stmp -> next;
				}
			}
			if( gamepad_button_y() > 0 && cooldown <= 0 ) {
				if( (Hand -> top -> suit + 1) % 2 == stmp -> top -> suit % 2 && Hand -> top -> value + 1 == stmp -> top -> value ) {
					while(Hand -> amount > 0) {
						tmp = Hand -> top;
						Hand = pop( Hand, &tmp );
						stmp = push( stmp, tmp );
						cooldown = 12;
						cellhome = false;
					}
				}
				else if( stmp -> amount == 0 ) {
					while(Hand -> amount > 0) {
						tmp = Hand -> top;
						Hand = pop( Hand, &tmp );
						stmp = push( stmp, tmp );
						cooldown = 12;
						cellhome = false;
					}
					freecells --;
				}
				else {
					if(cellhome) {
						stmp = Cells -> start;
						for(i=0; i<hometableau; i++) {
							if(stmp -> next != NULL) {
								stmp = stmp -> next;
							}
						}
						freecells--;
					}
					else {
						stmp = Tableaus -> start;
						for(i=0; i<hometableau; i++) {
							if(stmp -> next != NULL) {
								stmp = stmp -> next;
							}
						}
						if (stmp -> amount == 0) {
							freecells --;
						}
					}
					while(Hand -> amount > 0) {
						tmp = Hand -> top;
						Hand = pop( Hand, &tmp );
						stmp = push( stmp, tmp );
						cooldown = 12;
						cellhome = false;
					}
				}
			}
		}
		else if( !foundationcheck ) {
			stmp = Cells -> start;
			for(i=0; i<currenttableau; i++) {
				if(stmp -> next != NULL) {
					stmp = stmp -> next;
				}
			}
			if( gamepad_button_y() > 0 && cooldown <= 0 ) {
				if( stmp -> amount == 0 && Hand -> amount == 1) {
					tmp = Hand -> top;
					Hand = pop( Hand, &tmp );
					stmp = push( stmp, tmp );
					freecells --;
					cooldown = 12;
					cellhome = false;
				}
				else {
					if(cellhome) {
						stmp = Cells -> start;
						for(i=0; i<hometableau; i++) {
							if(stmp -> next != NULL) {
								stmp = stmp -> next;
							}
						}
						freecells--;
					}
					else {
						stmp = Tableaus -> start;
						for(i=0; i<hometableau; i++) {
							if(stmp -> next != NULL) {
								stmp = stmp -> next;
							}
						}
						if (stmp -> amount == 0) {
							freecells --;
						}
					}
					while(Hand -> amount > 0) {
						tmp = Hand -> top;
						Hand = pop( Hand, &tmp );
						stmp = push( stmp, tmp );
						cooldown = 12;
						cellhome = false;
					}
				}
			}
		}
		else {
			stmp = Foundations -> start;
			for(i=4; i<currenttableau; i++) {
				if(stmp -> next != NULL) {
					stmp = stmp -> next;
				}
			}
			if( gamepad_button_y() > 0 && cooldown <= 0 ) {
				if( stmp -> amount == 0 && Hand -> amount == 1) {
					if(Hand -> top -> value == 1) {
						tmp = Hand -> top;
						Hand = pop( Hand, &tmp );
						stmp = push( stmp, tmp );
						cooldown = 12;
						cellhome = false;
					}
				}
				else if ( Hand -> amount == 1 ) {
					if( Hand -> top -> value - 1 == stmp -> top -> value && Hand -> top -> suit == stmp -> top -> suit ) {
						tmp = Hand -> top;
						Hand = pop( Hand, &tmp );
						stmp = push( stmp, tmp );
						cooldown = 12;
						cellhome = false;
					}
				}
				else {
					if(cellhome) {
						stmp = Cells -> start;
						for(i=0; i<hometableau; i++) {
							if(stmp -> next != NULL) {
								stmp = stmp -> next;
							}
						}
						freecells--;
					}
					else {
						stmp = Tableaus -> start;
						for(i=0; i<hometableau; i++) {
							if(stmp -> next != NULL) {
								stmp = stmp -> next;
							}
						}
						if (stmp -> amount == 0) {
							freecells --;
						}
					}
					while(Hand -> amount > 0) {
						tmp = Hand -> top;
						Hand = pop( Hand, &tmp );
						stmp = push( stmp, tmp );
						cooldown = 12;
						cellhome = false;
					}
				}
			}
		}

		cooldown --;
		////////////////////////
		// Drawing Everything //
		////////////////////////

		//Draw Background
		select_texture(TextureMat);
        select_region(RegionBackground);
        draw_region_at(0, 0);
		xcoord = 75;
        ycoord = 125;

		//Draw the cell and foundation stacks
		xcoord = 47;
		ycoord = 50;
		//Cells
		stmp = Cells -> start;
		tmp = stmp -> top;
		for(i=0; i<4; i++) {
			if(tmp != NULL) {
				select_texture(TextureCards);
				select_region(RegionCardFace + (tmp -> suit * 13) + (tmp -> value - 1) );
				draw_region_at( xcoord, ycoord );
			}
			xcoord += 78;
			if(stmp -> next != NULL) {
				stmp = stmp -> next;
			}
			tmp = stmp -> top;
		}
		//Foundations
		stmp = Foundations -> start;
		tmp = stmp -> top;
		for(i=0; i<4; i++) {
			if(tmp != NULL) {
				select_texture(TextureCards);
				select_region(RegionCardFace + (tmp -> suit * 13) + (tmp -> value - 1) );
				draw_region_at( xcoord, ycoord );
			}
			xcoord += 78;
			if(stmp -> next != NULL) {
				stmp = stmp -> next;
			}
			tmp = stmp -> top;
		}

		//Draw the slots for the cells and foundations
		xcoord = 47;
		ycoord = 50;
		for(i=0; i<4; i++) {
			select_texture(TextureOutline);
			select_region(RegionOutline);
			draw_region_at(xcoord, ycoord);
			xcoord += 78;
		}
		for(i=0; i<4; i++) {
			select_texture(TextureOutline);
			select_region(RegionOutline + 2);
			draw_region_at(xcoord, ycoord);
			xcoord += 78;
		}
		
		//Draw the Tableaus
		xcoord = 47;
		ycoord = 150;
		stmp = Tableaus -> start;
		while( stmp != NULL ) {
			if(stmp -> amount > 0) {
				tmp = stmp -> top;
				while( tmp -> prev != NULL ) {
					tmp = tmp -> prev;
				}
					while( tmp != NULL ) {
						select_texture(TextureCards);
						select_region(RegionCardFace + (tmp -> suit * 13) + (tmp -> value - 1) );
						draw_region_at(xcoord, ycoord);
						ycoord += 15;
						tmp = tmp -> next;
					}
			}
			else {
				ycoord = 150;
				select_texture(TextureOutline);
				select_region(RegionOutline);
				draw_region_at(xcoord, ycoord);
			}
			xcoord += 78;
			ycoord = 150;
			stmp = stmp -> next;
			if ( stmp != NULL ) {
				tmp = stmp -> top;
				while( tmp -> prev != NULL ) {
					tmp = tmp -> prev;
				}
			}
		}

		//Draw an outline to show currently selected Tableau & card/card stack
		if( !topcheck ) {
			stmp = Tableaus -> start;
			for(i=0; i<currenttableau; i++) {
				stmp = stmp -> next;
			}
			xcoord = 47 + ( 78 * currenttableau );
			if(stmp -> amount > 0) {
				ycoord = 150 + ( 15 * (stmp -> amount - currentcard - 1) );
				select_texture(TextureOutline);
				select_region(RegionOutline);
			}
			else {
				ycoord = 150;
				select_texture(TextureOutline);
				select_region(RegionOutline + 1);
			}
		}
		else if( foundationcheck ) {
			xcoord = 47 + (78 * currenttableau);
			ycoord = 50;
			select_texture(TextureOutline);
			select_region(RegionOutline);
		}
		else {
			xcoord = 47 + (78 * currenttableau);
			ycoord = 50;
			select_texture(TextureOutline);
			select_region(RegionOutline + 1);
		}
		if( get_frame_counter() % 60 > 0 && get_frame_counter() % 60 < 45 ) {
			draw_region_at(xcoord, ycoord);
		}

		//Draw the hand
		xcoord = 47 + ( 78 * currenttableau );
		ycoord += 30;
		if( Hand -> top != NULL ) {
			tmp = Hand -> top;
			while( tmp != NULL ) {
				select_texture(TextureCards);
				select_region(RegionCardFace + (tmp -> suit * 13) + (tmp -> value - 1) );
				draw_region_at(xcoord, ycoord);
				ycoord += 15;
				tmp = tmp -> prev;
			}
		}
		//End frame
		end_frame();
	}
}
