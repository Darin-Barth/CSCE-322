grammar csce322homeWork01part02;

@members{
boolean up=false;
boolean down=false;
boolean left=false;
boolean right=false;
boolean valid=true;
int players=0;
int barriers=0;
int mazeTokens=0;
int directions=0;
}


//rules
elaborate: maze directions semantics EOF|directions maze semantics EOF;

directions: section sectionBegin direcBegin direcTokens direcEnd sectionEnd; 
direcTokens: direcSym ASTERISK direcSym ASTERISK direcSym ASTERISK direcSym ASTERISK direcSym;
direcSym: moveToken ASTERISK direcSym | moveToken;
moveToken:moveUp 
| moveDown
| moveLeft
| moveRight
;

maze: section sectionBegin mazeBegin validRows mazeEnd sectionEnd;
validRows: row endRow row endRow row endRow row endRow row endRow row;
//potential fix here, with an additional pipe to account for last column ending
row: validColumns endRow row | validColumns;
validColumns:  column column column column column column;
column: mazeToken column | mazeToken;
mazeToken: maze1 
|maze2
|maze3
|maze4
;

section: TITLE;
sectionBegin: BEGIN;
sectionEnd: END;
direcBegin: MOVEBEGIN;
direcEnd: MOVEEND;
mazeBegin: MAZEBEGIN;
mazeEnd: MAZEEND;
moveUp: UP{directions++;up=true;};
moveDown: DOWN{directions++;down=true;};
moveLeft: LEFT{directions++;left=true;};
moveRight: RIGHT{directions++;right=true;};

maze1: MAZET1{mazeTokens++;barriers++;};
maze2: MAZET2{mazeTokens++;};
maze3: MAZET3{mazeTokens++;};
maze4: MAZET4{mazeTokens++;players++;};
endRow: ROWEND;
semantics: {

	if(players<2 || players >4){
		System.out.println("ALERT: Violation of Semantic Rule 1");
		valid=false;
	}
	if(directions  <= 2*players ){
		System.out.println("ALERT: Violation of Semantic Rule 2");
		valid=false;
	}
	if(!(up && down && left && right)){
		System.out.println("ALERT: Violation of Semantic Rule 3");
		valid=false;
	}
	if((barriers/mazeTokens)>0.7){
		System.out.println("ALERT: Violation of Semantic Rule 4");
		valid=false;
	}
	if(valid==true){
		System.out.println("Your maze has "+players+" players.");
	}
};

//tokens

BEGIN: '/*';
END: '*/';
TITLE: '@maze'|'@directions';
UP:'u';
DOWN:'d';
LEFT:'l';
RIGHT:'r';
MAZET1:'x';
MAZET2:'-';
MAZET3:'g';
MAZET4:[0-9];
ROWEND: '|';
MAZEBEGIN: '<<';
MAZEEND: '>>';
MOVEBEGIN: '//';
MOVEEND: '-->';
ASTERISK: '*';



WS : [ \t\r\n]+ { skip(); };
