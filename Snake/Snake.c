//Include libraries
#include "audio.h"
#include "video.h"
#include "input.h"
#include "time.h"
#include "math.h"
#include "misc.h"
#include "string.h"
#include "assets/draw_primitives.h"
#include "assets/doublelist.h"

//////////
// Main //
//////////

void main() {

	//Seed the RNG
	srand( get_time() );

	//Variables
	int i;
	int [5] numprinter;
	bool deathFlag;
	int direction;              //current facing direction of the head, 0-R, 1-U, 2-L, 3-D
	int dirFlag;                //current facing direction of the head, 0-R, 1-U, 2-L, 3-D   
	int appleX;
	int appleY;
	int cooldown;

	//Initialize a snake
	List *Snake = mklist();
	Node *tmp = mknode(NULL, NULL);
	
	while(true) {
		deathFlag = false;
		direction = 0;
		dirFlag = 0;
		appleX = 620 - 15*(rand()%42);
		appleY = 345 - 15*(rand()%23);
		cooldown = 20;
		for(i=0; i<3; i++) {
			tmp = mknode(200-15*i, 180);
			Snake = append(Snake, Snake -> end, tmp);
		}
		
		while(gamepad_button_b() != 1) {
			clear_screen(color_black);
			set_multiply_color(color_white);
			print_at(225, 150, "Get all the apples!");
			print_at(215, 170, "Use the D-Pad to move");
			print_at(175, 190, "Hold B to activate turbo mode");
			if(get_frame_counter() % 90 < 45) {
				print_at(240, 210, "Press B to start");
			}
			end_frame();
		}
		//Gameplay Loop
		while(!deathFlag) {
			//Turbo Mode
			if(gamepad_button_b() >= 1 && cooldown <= 9) {
				cooldown -= 3;
			}
			//Decrement cooldown
			cooldown --;

			if(cooldown < 0) {
				//Turn the Snake
				direction = dirFlag;
				//Move all segments to the previous segment's location
				tmp = Snake -> end;
				while(tmp != Snake -> start) {
					tmp -> xpos = tmp -> prev -> xpos;
					tmp -> ypos = tmp -> prev -> ypos;
					tmp = tmp -> prev;
				}
				//Move the head of the snake in the specified direction
				tmp = Snake -> start;
				if(direction == 0) {
					tmp -> xpos += 15;
				}
				else if(direction == 1) {
					tmp -> ypos -= 15;
				}
				else if(direction == 2) {
					tmp -> xpos -= 15;
				}
				else {
					tmp -> ypos += 15;
				}
				cooldown = 9;
			}

			//Change direction when the corresponding button is pressed
			if(gamepad_right() == 1 && direction != 2) {
				dirFlag = 0;
			}
			else if(gamepad_up() == 1 && direction != 3) {
				dirFlag = 1;
			}
			else if(gamepad_left() == 1 && direction != 0) {
				dirFlag = 2;
			}
			else if(gamepad_down() == 1 && direction != 1) {
				dirFlag = 3;
			}

			//Apple grab logic
			if(Snake -> start -> xpos == appleX && Snake -> start -> ypos == appleY) {
				appleX = 635 - 15*(rand()%41);
				appleY = 360 - 15*(rand()%24);
				tmp = mknode(-100, -100);
				Snake = append( Snake, Snake -> end, tmp );
			}

			//Death logic
			tmp = Snake -> start -> next;
			while(tmp != NULL) {
				if(Snake -> start -> xpos == tmp -> xpos && Snake -> start -> ypos == tmp -> ypos) {
					deathFlag = true;
				}
				tmp = tmp -> next;
			}
			if(Snake -> start -> xpos < 0 || Snake -> start -> xpos > 640) {
				deathFlag = true;
			}
			if(Snake -> start -> ypos < 0 || Snake -> start -> ypos > 360) {
				deathFlag = true;
			}
		
			//Drawing Everything
			//Drawing Snake
			clear_screen(color_black);
			tmp = Snake -> start;
			set_multiply_color(color_green);
			if(gamepad_button_b() > 0 && cooldown <= 9) {
				set_multiply_color(color_cyan);
			}
			while(tmp != NULL) {
				draw_filled_rectangle(tmp -> xpos - 6, tmp -> ypos - 6, tmp -> xpos + 6, tmp -> ypos + 6);
				tmp = tmp -> next;
			}
			//Drawing Apple
			set_multiply_color(color_red);
			draw_filled_rectangle(appleX-7, appleY-7, appleX+7, appleY+7);
			//Drawing Score
			itoa(Snake -> length - 3, numprinter, 10 );
			set_multiply_color(color_white);
			print_at(0, 0, "Points:");
			print_at(70, 0, numprinter);
			end_frame();
		}
		cooldown = 120;
		while(cooldown > 0) {
			//Drawing Everything
			//Drawing Snake
			clear_screen(color_black);
			tmp = Snake -> start -> next;
			set_multiply_color(color_green);
			while(tmp != NULL) {
				draw_filled_rectangle(tmp -> xpos - 6, tmp -> ypos - 6, tmp -> xpos + 6, tmp -> ypos + 6);
				tmp = tmp -> next;
			}

			tmp = Snake -> start;
			//So, no head?
			if(cooldown % 60 <= 30) {
				set_multiply_color(color_red);
			}
			else {
				set_multiply_color(color_green);
			}
			draw_filled_rectangle(tmp -> xpos - 6, tmp -> ypos - 6, tmp -> xpos + 6, tmp -> ypos + 6);
			tmp = tmp -> next;

			//Drawing Apple
			set_multiply_color(color_red);
			draw_filled_rectangle(appleX-7, appleY-7, appleX+7, appleY+7);
			end_frame();
			cooldown --;

		}
		while(gamepad_button_b() != 2) {
			clear_screen(color_black);
			print_at(275, 170, "You Died!");
			if(get_frame_counter() % 90 < 45) {
				print_at(230, 190, "Press B to restart");
			}
			end_frame();
		}
		Snake = clearlist( Snake );
		deathFlag = false;
	}
}
