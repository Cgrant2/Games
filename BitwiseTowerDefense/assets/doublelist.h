//Include libraries
#include "audio.h"
#include "video.h"
#include "input.h"
#include "time.h"
#include "math.h"
#include "misc.h"
#include "string.h"

struct GameObject {
	GameObject *next;        //pointer to the next enemy in the list
	GameObject *prev;        //pointer to the previous enemy in the list
	int value;               //value of the node
	float xpos;              //x position of the object
	float ypos;              //y position of the object
	int tpos;                //time position of the object (parametric)
	int type;                //check if the struct is an enemy or tower, and what type of tower if applicable
	int cooldown;            //if tower, cooldown to shhot projectile
	int level;               //if tower, the level of the tower 1,2,3
	int range;               //if tower, the range a tower can attack
};

struct List {
	GameObject *start;       //pointer to the start of the list
	GameObject *end;         //pointer to the end of the list
	int length;              //length of the list
};

//make an enemy node
GameObject *mkenemy ( int x, int y, int valyou ) {
	GameObject *node = NULL;
	node = (GameObject *)malloc(sizeof(GameObject));
	node -> next = NULL;
	node -> prev = NULL;
	node -> value = valyou;
	node -> xpos = x;
	node -> ypos = y;
	node -> tpos = 0;
	node -> type = 0;
	node -> cooldown = NULL;
	node -> level = NULL;
	node -> range = NULL;
	return (node);
}

//make a tower node
GameObject *mktower ( int x, int y, int tower ) {
	GameObject *node = NULL;
	node = (GameObject *)malloc(sizeof(GameObject));
	node -> next = NULL;
	node -> prev = NULL;
	node -> xpos = x;
	node -> ypos = y;
	node -> tpos = 0;
	node -> type = tower;
	node -> cooldown = 90;
	node -> level = 1;
	node -> range = 5;
	return (node);
}

//remove a node
GameObject *rmnode (GameObject *node) {
	free(node);
	node = NULL;
	return (node);	
}

//make a list
List *mklist () {
	List *list = NULL;
	list = (List *)malloc(sizeof(List));
	list -> length = 0; 
	list -> start = NULL;
	list -> end = NULL;
	return (list);

}

//insert a node into a list
List *insert (List *list, GameObject *location, GameObject *node) {
	if(list -> start == NULL) {
		list -> start = node;
		list -> end = node;
	}
	else if(location == list -> start) {
		node -> next = location;
		location -> prev = node;
		list -> start = node;
	}
	else {
		node -> next = location;
		location -> prev -> next = node;
		node -> prev = location -> prev;
		location -> prev = node;
	}
	list -> length ++;
	return list;
}

//append a node into a list
List *append (List *list, GameObject *location, GameObject *node) {
	if(list -> start == NULL) {
		list -> start = node;
		list -> end = node;
	}
	else if(location == list -> end) {
		location -> next = node;
		node -> prev = location;
		list -> end = node;
	}
	else {
		node -> prev = location;
		location -> next -> prev = node;
		node -> next = location -> next;
		location -> next = node;
	}
	list -> length ++;
	return list;
}

//obtain a node from a list
List *obtain (List *list, GameObject **node) {
	if( (*node) != NULL ) {
		if( (*node) == list -> start ) {
			list -> start = (*node) -> next;
			if(list -> start != NULL) {
				list -> start -> prev = NULL;
			}
			else {
				list -> end = NULL;
			}
		}
		if ( (*node) == list -> end ) {
			list -> end = (*node) -> prev;
			list -> end -> next = NULL;
		}
		if ( (*node) -> prev != NULL ) {
			(*node) -> prev -> next = (*node) -> next;
		}
		if ( (*node) -> next != NULL ) {
			(*node) -> next -> prev = (*node) -> prev;
		}
		(*node) -> next = NULL;
		(*node) -> prev = NULL;
		list -> length --;
	}
	return list;
}

//clear a list
List *clearlist (List *list) {
	GameObject *temp = list -> start;
	GameObject *temp2 = temp -> next;
	GameObject **temp3 = &temp;
	while( temp != NULL ) {
		list = obtain(list, temp3);
		temp = rmnode(temp);
		temp = temp2;
		if(temp != NULL ) {
			temp2 = temp -> next;
			temp3 = &temp;
		}
	}
	return list;
}

//remove a list
List *rmlist (List *list) {
	list = clearlist(list);
	free(list);
	list = NULL;
	return list;
}
