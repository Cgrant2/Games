//Include libraries
#include "audio.h"
#include "video.h"
#include "input.h"
#include "time.h"
#include "math.h"
#include "misc.h"
#include "string.h"

struct Node {
	Node *next;        //pointer to the next enemy in the list
	Node *prev;        //pointer to the previous enemy in the list
	int xpos;                //x position of the object
	int ypos;                //y position of the object
};

struct List {
	Node *start;       //pointer to the start of the list
	Node *end;         //pointer to the end of the list
	int length;              //length of the list
};

//make an enemy node
Node *mknode ( int x, int y ) {
	Node *node = NULL;
	node = (Node *)malloc(sizeof(Node));
	node -> next = NULL;
	node -> prev = NULL;
	node -> xpos = x;
	node -> ypos = y;
	return (node);
}

//remove a node
Node *rmnode (Node *node) {
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
List *insert (List *list, Node *location, Node *node) {
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
List *append (List *list, Node *location, Node *node) {
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
List *obtain (List *list, Node **node) {
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
	Node *temp = list -> start;
	Node *temp2 = temp -> next;
	Node **temp3 = &temp;
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
