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

//Queue Struct Declaration
struct Queue {
    GameObject *front;      //front node of the queue
    GameObject *back;       //back node of the queue
    List *data;             //list the queue uses
    Queue *next;            //next queue
    Queue *prev;            //previous queue
    int size;               //maximum size of the list
	int amount;             //amount of items currently in the queue
};

/////////////////////
// Queue Functions //
/////////////////////


Queue *mkqueue ( int size ) {
    Queue *queue = NULL;
    queue = (Queue *) malloc(sizeof(Queue));
    queue -> data = mklist( );
    queue -> front = queue -> data -> start;
	queue -> back = queue -> data -> end;
    queue -> size = size;
	queue -> amount = 0;
    queue -> next = NULL;
    queue -> prev = NULL;
    return queue;
}

Queue *dequeue ( Queue *queue, GameObject **node ) {
    if( queue -> amount != 0 ); {
        if( (*node) != NULL ) {
            obtain ( queue -> data, node );
            queue -> front = queue -> data -> start;
			queue -> back = queue -> data -> end;
        }
    }
	queue -> amount --;
    return queue;
}

Queue *enqueue ( Queue *queue, GameObject *node ) {
    if( node != NULL && queue -> amount < queue -> size ) {
        queue -> data = append( queue -> data, queue -> data -> end, node);
        queue -> back = queue -> data -> end;
		queue -> front = queue -> data -> start;
		queue -> amount ++;
    }
    return queue;
}

Queue *clearqueue( Queue *queue ) {
	GameObject *tmp = queue -> front;
	while(tmp != NULL) {
		queue = dequeue( queue, &tmp );
		tmp = queue -> front;
	}
	return queue;
}

Queue *rmqueue ( Queue *queue ) {
    queue -> data = clearlist( queue -> data );
    queue -> data = rmlist( queue -> data );
    free( queue );
    queue = NULL;
    return queue;
}

//Queue-Queuelist Declaration

struct Queuelist {
    Queue *start;           //first queue in the list
    Queue *end;             //last queue in the list
    int length;             //amount of queues in the list
};

/////////////////////////
// Queuelist Functions //
/////////////////////////

//make a list
Queuelist *mkqueuelist () {
	Queuelist *list = NULL;
	list = (Queuelist *)malloc(sizeof(Queuelist));
	list -> start = NULL;
	list -> end = NULL;
	list -> length = 0; 
	return (list);

}

//insert a queue into a list
Queuelist *queueinsert (Queuelist *list, Queue *location, Queue *queue) {
	if(list -> start == NULL) {
		list -> start = queue;
		list -> end = queue;
	}
	else if(location == list -> start) {
		queue -> next = location;
		location -> prev = queue;
		list -> start = queue;
	}
	else {
		queue -> next = location;
		location -> prev -> next = queue;
		queue -> prev = location -> prev;
		location -> prev = queue;
	}
	list -> length ++;
	return list;
}

//append a queue into a list
Queuelist *queueappend (Queuelist *list, Queue *location, Queue *queue) {
	if(list -> start == NULL) {
		list -> start = queue;
		list -> end = queue;
	}
	else if(location == list -> end) {
		location -> next = queue;
		queue -> prev = location;
		list -> end = queue;
	}
	else {
		queue -> prev = location;
		location -> next -> prev = queue;
		queue -> next = location -> next;
		location -> next = queue;
	}
	list -> length ++;
	return list;
}

//obtain a queue from a list
Queuelist *queueobtain (Queuelist *list, Queue **queue) {
	if( (*queue) != NULL ) {
		if( (*queue) == list -> start ) {
			list -> start = (*queue) -> next;
			if(list -> start != NULL) {
				list -> start -> prev = NULL;
			}
			else {
				list -> end = NULL;
			}
		}
		if ( (*queue) == list -> end ) {
			list -> end = (*queue) -> prev;
			list -> end -> next = NULL;
		}
		if ( (*queue) -> prev != NULL ) {
			(*queue) -> prev -> next = (*queue) -> next;
		}
		if ( (*queue) -> next != NULL ) {
			(*queue) -> next -> prev = (*queue) -> prev;
		}
		(*queue) -> next = NULL;
		(*queue) -> prev = NULL;
		list -> length --;
	}
	return list;
}

//clear a list
Queuelist *clearqueuelist (Queuelist *list) {
	Queue *temp = list -> start;
	Queue *temp2 = temp -> next;
	Queue **temp3 = &temp;
	while( temp != NULL ) {
		list = queueobtain(list, temp3);
		temp = rmqueue(temp);
		temp = temp2;
		if(temp != NULL ) {
			temp2 = temp -> next;
			temp3 = &temp;
		}
	}
	return list;
}

//remove a list
Queuelist *rmqueuelist (Queuelist *list) {
	list = clearqueuelist(list);
	free(list);
	list = NULL;
	return list;
}
