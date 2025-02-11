//Include libraries
#include "audio.h"
#include "video.h"
#include "input.h"
#include "time.h"
#include "math.h"
#include "misc.h"
#include "string.h"

//Include header for list functionality
#include "doublelist.h"

//Stack Struct Declaration
struct Stack {
    GameObject *top;        //top node of the stack
    List *data;             //list the stack uses
    Stack *next;            //next stack
    Stack *prev;            //previous stack
    int size;               //maximum size of the list
	int amount;             //amount of items currently in the stack
};

/////////////////////
// Stack Functions //
/////////////////////


Stack *mkstack ( int size ) {
    Stack *stack = NULL;
    stack = (Stack *) malloc(sizeof(Stack));
    stack -> data = mklist( );
    stack -> top = stack -> data -> end;
    stack -> size = size;
    stack -> next = NULL;
    stack -> prev = NULL;
	stack -> amount = 0;
    return stack;
}

Stack *rmstack ( Stack *stack ) {
    stack -> data = clearlist( stack -> data );
    stack -> data = rmlist( stack -> data );
    free( stack );
    stack = NULL;
    return stack;
}

Stack *pop ( Stack *stack, GameObject **node ) {
    if( stack -> data -> length != 0 ); {
        if( (*node) != NULL ) {
            obtain ( stack -> data, node );
            stack -> top = stack -> data -> end;
        }
    }
	stack -> amount --;
    return stack;
}

Stack *push ( Stack *stack, GameObject *node ) {
    if( node != NULL && stack -> data -> length < stack -> size ) {
        stack -> data = append( stack -> data, stack -> data -> end, node);
        stack -> top = stack -> data -> end;
    }
	stack -> amount ++;
    return stack;
}

//Stack-Stacklist Declaration

struct Stacklist {
    Stack *start;           //first stack in the list
    Stack *end;             //last stack in the list
    int length;             //amount of stacks in the list
};

/////////////////////////
// Stacklist Functions //
/////////////////////////

//make a list
Stacklist *mkstacklist () {
	Stacklist *list = NULL;
	list = (Stacklist *)malloc(sizeof(Stacklist));
	list -> start = NULL;
	list -> end = NULL;
	list -> length = 0; 
	return (list);

}

//insert a stack into a list
Stacklist *stackinsert (Stacklist *list, Stack *location, Stack *stack) {
	if(list -> start == NULL) {
		list -> start = stack;
		list -> end = stack;
	}
	else if(location == list -> start) {
		stack -> next = location;
		location -> prev = stack;
		list -> start = stack;
	}
	else {
		stack -> next = location;
		location -> prev -> next = stack;
		stack -> prev = location -> prev;
		location -> prev = stack;
	}
	list -> length ++;
	return list;
}

//append a stack into a list
Stacklist *stackappend (Stacklist *list, Stack *location, Stack *stack) {
	if(list -> start == NULL) {
		list -> start = stack;
		list -> end = stack;
	}
	else if(location == list -> end) {
		location -> next = stack;
		stack -> prev = location;
		list -> end = stack;
	}
	else {
		stack -> prev = location;
		location -> next -> prev = stack;
		stack -> next = location -> next;
		location -> next = stack;
	}
	list -> length ++;
	return list;
}

//obtain a stack from a list
Stacklist *stackobtain (Stacklist *list, Stack **stack) {
	if( (*stack) != NULL ) {
		if( (*stack) == list -> start ) {
			list -> start = (*stack) -> next;
			if(list -> start != NULL) {
				list -> start -> prev = NULL;
			}
			else {
				list -> end = NULL;
			}
		}
		if ( (*stack) == list -> end ) {
			list -> end = (*stack) -> prev;
			list -> end -> next = NULL;
		}
		if ( (*stack) -> prev != NULL ) {
			(*stack) -> prev -> next = (*stack) -> next;
		}
		if ( (*stack) -> next != NULL ) {
			(*stack) -> next -> prev = (*stack) -> prev;
		}
		(*stack) -> next = NULL;
		(*stack) -> prev = NULL;
		list -> length --;
	}
	return list;
}

//clear a list
Stacklist *clearstacklist (Stacklist *list) {
	Stack *temp = list -> start;
	Stack *temp2 = temp -> next;
	Stack **temp3 = &temp;
	while( temp != NULL ) {
		list = stackobtain(list, temp3);
		temp = rmstack(temp);
		temp = temp2;
		if(temp != NULL ) {
			temp2 = temp -> next;
			temp3 = &temp;
		}
	}
	return list;
}

//remove a list
Stacklist *rmstacklist (Stacklist *list) {
	list = clearstacklist(list);
	free(list);
	list = NULL;
	return list;
}
