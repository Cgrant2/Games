//Include libraries
#include "audio.h"
#include "video.h"
#include "input.h"
#include "time.h"
#include "math.h"
#include "misc.h"
#include "string.h"
#include "assets/draw_primitives.h"

//Include header for tree and stack functionality
#include "assets/tree.h"
#include "assets/stacks.h"

//Define sounds
#define SoundBG 0
#define SoundLeaf 1

//////////
// Main //
//////////

void PrintInOrder(Tree *tree, Node *refroot, int xprev) {

	if(refroot == NULL) {
		return;
	}

	int[10] numprinter;
	int color = color_green;
	if( refroot != tree -> root ) {
		refroot -> x = 360/(refroot -> depth);
	}
	refroot -> y = 25 + 30 * refroot -> depth;

	if(refroot == tree -> root) {
		color = color_brown;
		refroot -> x = 320;
	}
	else if(refroot == refroot -> parent -> right) {
		refroot -> x = xprev + 100 / (refroot -> depth);
	}
	else {
		refroot -> x = xprev - 100 / (refroot -> depth);
	}
	set_multiply_color(color);
	itoa(refroot -> value, numprinter, 10);
	print_at( refroot -> x, refroot -> y, numprinter);
	draw_circle(refroot -> x + 5, refroot -> y + 10, 12);

	PrintInOrder(tree, refroot -> left, refroot -> x);
	PrintInOrder(tree, refroot -> right, refroot -> x);
	set_multiply_color(color_white);
}
void main() {
	//Seed the RNG
	srand( get_time() );

	//Initialize variables
	int i;
	int randy = rand() % 9;
	int number;
	int number2;
	int[10] numprinter;
	int points = 5;
	int maxGuesses = 5;
	int guesses = 0;
	bool chosenFlag = false;
	bool correctFlag = false;

	//Initialize a tree
	Tree *spruce = mktree(6);

	//Initialize tmp nodes for trees
	Node *tmp = NULL;
	tmp = (Node *)malloc(sizeof(Node));

	Node *tmp2 = NULL;
	tmp2 = (Node *)malloc(sizeof(Node));

	Node *correctNode = NULL;
	correctNode = (Node *)malloc(sizeof(Node));

	//Initialize a stack
	Stack *reverser = mkstack(10);

	//Initialize a tmp node for stacks
	GameObject *vmp = NULL;
	vmp = (GameObject *)malloc(sizeof(GameObject));

	select_sound( SoundBG );
	set_sound_loop( true );
	play_sound_in_channel( SoundBG, 1 );
	select_channel( 1 );
	set_channel_volume(0.75);

	while(true) {
	points = 5;
	maxGuesses = 5;
	guesses = 0;
	chosenFlag = false;
	correctFlag = false;

		while(gamepad_button_b() != 2) {
			clear_screen(color_black);
			set_multiply_color(color_green);
			print_at(200, 20, "Press B to select a node");
			print_at(110, 40, "Press Left and Right to move down a branch");
			print_at(145, 60, "Press Up to move to a previous node");
			set_multiply_color(color_brown);
			print_at(295, 80,  "|||||");
			print_at(295, 100, "|||||");
			print_at(295, 120, "|||||");
			print_at(295, 140, "|||||");
			print_at(295, 160, "|||||");
			print_at(295, 180, "|||||");
			print_at(295, 200, "|||||");
			print_at(295, 220, "|||||");
			print_at(295, 240, "|||||");
			print_at(295, 260, "|||||");
			print_at(295, 280, "|||||");
			print_at(295, 300, "|||||");
			print_at(295, 320, "|||||");
			print_at(295, 340, "|||||");
			set_multiply_color(color_white);
			end_frame();
		}
		while(points > 0) {
			//Randomizing the number
			for(i=0; i<randy; i++) {
				number = ( (rand() % 900000000) + 100000000 );
			}
			number2 = number;
			//Putting the number into a stack
			while(number > 0) {
				i = number % 10;
				number = (number - i) / 10;
				vmp = mknode(i);
				reverser = push(reverser, vmp);
			}
			//inserting each digit into the tree
			while(reverser -> amount > 0) {
				vmp = reverser -> top;
				reverser = pop(reverser, &vmp);
				tmp = mkleaf(vmp -> value);
				spruce = treeinsert(spruce, tmp);
				//Selecting one correct node
				if(rand() % 4 == 0 && !chosenFlag && tmp != spruce -> root) {
					correctNode = tmp;
					chosenFlag = true;
				}
				else if( !chosenFlag && reverser -> amount == 0 ) {
					correctNode = tmp;
					chosenFlag = true;
				}
			}
			tmp = spruce -> root;
			while(correctFlag != true && guesses <= maxGuesses && points >= 0) {
				clear_screen(color_black);
				if(spruce -> root != NULL) {
					//Choose a node per press
					if(gamepad_left() == 1 && tmp -> left != NULL) {
						tmp = tmp -> left;
					}
					if(gamepad_right() == 1 && tmp -> right != NULL) {
						tmp = tmp -> right;
					}
					if(gamepad_up() == 1 && tmp -> parent != NULL) {
						tmp = tmp -> parent;
					}

					//Choose a node hold
					if(gamepad_left() > 30 && tmp -> left != NULL) {
						tmp = tmp -> left;
					}
					if(gamepad_right() > 30 && tmp -> right != NULL) {
						tmp = tmp -> right;
					}
					if(gamepad_up() > 30 && tmp -> parent != NULL) {
						tmp = tmp -> parent;
					}

					if(gamepad_button_b() == 1) {
						select_sound( SoundLeaf );
						play_sound_in_channel( SoundLeaf, 2 );
						select_channel( 2 );
						guesses++;
						points --;


						if(tmp -> value <= correctNode -> value && tmp != correctNode) {
							while(tmp -> left != NULL) {
								tmp2 = tmp -> left;
								spruce = treeobtain(spruce, &tmp2);
								tmp2 = rmleaf(tmp2);
							}
						}

						else if(tmp -> value > correctNode -> value && tmp != correctNode) {
							while(tmp -> right != NULL) {
								tmp2 = tmp -> right;
								spruce = treeobtain(spruce, &tmp2);
								tmp2 = rmleaf(tmp2);
							}
						}
						else if(tmp -> value == correctNode -> value && tmp != spruce -> root) {
							correctFlag = true;
						}
					}
				}

				//Printing everything
				//Printing the amount of guesses left
				itoa(maxGuesses-guesses, numprinter, 10);
				print_at( 10, 10, "Guesses Left:");
				print_at( 140, 10, numprinter );
				//Print the points number
				itoa(points, numprinter, 10);
				print_at( 10, 30, "Points:");
				print_at( 80, 30, numprinter);


				//Print every node
				tmp2 = spruce -> root;
				if(spruce -> root != NULL) {
					PrintInOrder(spruce, tmp2, 0);
				}
				
				//Draw the cursor
				if(get_frame_counter() % 60 < 30) {
					set_multiply_color(color_yellow);
				}
				else {
					set_multiply_color(color_orange);
				}
				if(spruce -> root != NULL) {
					draw_circle(tmp -> x + 5, tmp -> y + 10, 12);
					set_multiply_color(color_white);
				}

				end_frame();
			}
			if(correctFlag) {
				points += maxGuesses;
			}
			spruce = cleartree(spruce);
			chosenFlag = false;
			correctFlag = false;
			guesses = 0;
		}
		while(gamepad_up() != 1) {
			clear_screen(color_black);
			set_multiply_color(color_brown);
			print_at(295, 40,  " | / ");
			print_at(295, 60,  "/||| ");
			print_at(295, 80,  " |||\\");
			print_at(295, 100, "|||||");
			print_at(295, 120, "|||||");
			print_at(295, 140, "|||||");
			print_at(295, 160, "|||||");
			print_at(295, 180, "|||||");
			print_at(295, 200, "|||||");
			print_at(295, 220, "|||||");
			print_at(295, 240, "|||||");
			print_at(295, 260, "|||||");
			print_at(295, 280, "|||||");
			set_multiply_color(color_orange);
			print_at(215, 300, "Your tree has died =(");
			print_at(225, 320, "Press Up to restart");
			set_multiply_color(color_white);
			end_frame();
		}
	}

}
