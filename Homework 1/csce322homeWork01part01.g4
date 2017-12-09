grammar csce322homeWork01part01;

//rules
elaborate: maze directions end EOF|directions maze end EOF;
directions: section sectionBegin direcBegin direcSymb+ direcEnd sectionEnd; 
maze: section sectionBegin mazeBegin mazeSymb+ mazeEnd sectionEnd;
direcSymb: moveToken ASTERISK direcSymb|moveToken;
mazeSymb: mazeToken endRow mazeSymb|mazeToken
|number endRow number|number;

//elaborate: scanner EOF;

//scanner:section|sectionBegin|sectionEnd|direcBegin
//|direcEnd|mazeBegin|mazeEnd|moveToken|mazeToken|endRow|end|scanner;

section: TITLE{System.out.println("Sector: " + $TITLE.text);};
sectionBegin: BEGIN{System.out.println("Section Inception: /*" );};
sectionEnd: END{System.out.println("Section Discontinuation: */" );};
direcBegin: MOVEBEGIN{System.out.println("List Inception: //" );};
direcEnd: MOVEEND{System.out.println("List Discontinuation: -->" );};
mazeBegin: MAZEBEGIN{System.out.println("Maze Inception: <<" );};
mazeEnd: MAZEEND{System.out.println("Maze Discontinuation: >>" );};
moveToken: MOVES{System.out.println("Direction: " + $MOVES.text);};
mazeToken: MAZE{System.out.println("Maze Symbol: " + $MAZE.text);};
endRow: ROWEND{System.out.println("Row Discontinuation: |" );};
end:{System.out.println("File Discontinuation");};
number:  NUM{System.out.println("Number: " + $NUM.text);};

//tokens

BEGIN: '/*';
END: '*/';
TITLE: '@maze'|'@directions';
MOVES: 'u'|'d'|'l'|'r';
MAZE: 'x'|'-'|'g';
NUM: [0-9];
ROWEND: '|';
MAZEBEGIN: '<<';
MAZEEND: '>>';
MOVEBEGIN: '//';
MOVEEND: '-->';
ASTERISK: '*';



WS : [ \t\r\n]+ { skip(); };

