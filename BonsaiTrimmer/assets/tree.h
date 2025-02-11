//Include libraries
#include "audio.h"
#include "video.h"
#include "input.h"
#include "time.h"
#include "math.h"
#include "misc.h"
#include "string.h"

struct Node {
	Node *right;         //pointer to the next greater node in the tree
	Node *left;          //pointer to the next lesser node in the tree
	Node *parent;        //pointer to the parent/previous node in the tree
	int value;           //value of the node
	int depth;           //depth of the node in the tree; ie root -> depth = 0, root -> left -> depth = 1;
	int x;               //x coordinate
	int y;               //y coordinate
};

struct Tree {
	Node *root;          //root node of the tree
	int length;          //length of the list
};

//make a node
Node *mkleaf (int number) {
	Node *node = NULL;
	node = (Node *)malloc(sizeof(Node));
	node -> right = NULL;
	node -> left = NULL;
	node -> parent = NULL;
	node -> value = number;
	node -> depth = 0;
	node -> x = 0;
	node -> y = 0;
	return (node);
}

//remove a node
Node *rmleaf (Node *node) {
	free(node);
	node = NULL;
	return (node);	
}

//make a tree
Tree *mktree (int size) {
	Tree *tree = NULL;
	tree = (Tree *)malloc(sizeof(Tree));
	tree -> length = size; 
	tree -> root = NULL;
	return (tree);

}

//insert a node into a list
Tree *treeinsert (Tree *tree, Node *node) {
	//Initialize a tmp pointer
	Node *tmp = NULL;
	tmp = (Node *)malloc(sizeof(Node));
	tmp = tree -> root;
	//Attempt to insert when the node is an orphan
	//check if the tree is empty
	if( tmp == NULL ) {
		tree -> root = node;
		node -> depth = 0;
	}
	//insert node when root exists
	else {
		while(node -> parent == NULL) {
			//Node is less than case
			if( node -> value < tmp -> value ) {
				if(tmp -> left == NULL) {
					tmp -> left = node;
					node -> parent = tmp;
					node -> depth ++;
				}
				else {
					tmp = tmp -> left;
					node -> depth ++;
				}
			}
			//Node is Greater/Equal case
			else {
				if(tmp -> right == NULL) {
					tmp -> right = node;
					node -> parent = tmp;
					node -> depth ++;
				}
				else {
					tmp = tmp -> right;
					node -> depth ++;
				}
			}
		}
	}
	return (tree);
}

//obtain a node from a list
Tree *treeobtain (Tree *tree, Node **node) {
	//Initialize a tmp pointer
	Node *tmp = NULL;
	tmp = (Node *)malloc(sizeof(Node));
	tmp = (*node);

	//Find the replacement node if applicable
	if( tmp -> left != NULL) {
		tmp = tmp -> left;
		while(tmp -> right != NULL) {
			tmp = tmp -> right;
		}
	}
	else if( tmp -> right != NULL) {
		tmp = tmp -> right;
	}
	else {
		tmp = (*node);
	}
	

	if( (*node) == tree -> root && tmp == (*node)) {
		//if you are obtaining the last node remove all connections
		tree -> root = NULL;
	}
	else if( (*node) == tree -> root && tmp == (*node) -> right) {
		//if root is being removed, and has no left branch make its right child the new root
		(*node) -> right = NULL;
		tmp -> parent = NULL;
		tree -> root = tmp;
		tmp -> depth = 0;
	}
	else {
		//Reset all of the repleacement nodes relations
		if(tmp -> left != NULL) {
			tmp -> left -> parent = tmp -> parent;
		}
		if(tmp == tmp -> parent -> right) {
			tmp -> parent -> right = tmp -> left;
		}
		else if(tmp == tmp -> parent -> left) {
			tmp -> parent -> left = tmp -> left;
		}
		tmp -> left = NULL;
		tmp -> parent = NULL;

		//Set all of the replacement nodes relations to be the removed nodes
		//Parent
		if((*node) -> parent != NULL) {
			if((*node) == (*node) -> parent -> left) {
				tmp -> parent = (*node) -> parent;
				(*node) -> parent -> left = tmp;
			}
			else {
				tmp -> parent = (*node) -> parent;
				(*node) -> parent -> right = tmp;
			}
		}
		(*node) -> parent = NULL;
		//Children
		if((*node) -> left != NULL) {
			tmp -> left = (*node) -> left;
			(*node) -> left -> parent = tmp;
			(*node) -> left = NULL;
		}
		if((*node) -> right != NULL) {
			tmp -> right = (*node) -> right;
			(*node) -> right -> parent = tmp;
			(*node) -> right = NULL;
		}
		tmp -> depth = (*node) -> depth;
		(*node) -> depth = 0;
		if((*node) == tree -> root) {
			tree -> root = tmp;
		}
	}
		
	return (tree);
}

//clear a list
Tree *cleartree (Tree *tree) {
	//Initialize a tmp pointer
	Node *tmp = NULL;
	tmp = (Node *)malloc(sizeof(Node));
	//Clear the tree
	while(tree -> root != NULL) {
		tmp = tree -> root;
		tree = treeobtain(tree, &tmp);
		tmp = rmleaf(tmp);
	}
	return (tree);
}

//remove a list
Tree *rmtree (Tree *tree) {
	tree = cleartree(tree);
	free(tree);
	tree = NULL;
	return (tree);
}
