movesRowsColumns(Moves,[H|T]):-
	length(Moves,MoveNum),
	length([H|T],ColNum),
	length(H,RowNum),
	0 is mod(MoveNum,2),
	0 is mod(RowNum,2),
	0 is mod(ColNum,2).

movesRowsColumns(Moves,[H|T]):-
	length(Moves,MoveNum),
	length([H|T],ColNum),
	length(H,RowNum),
	1 is mod(MoveNum,2),
	1 is mod(RowNum,2),
	1 is mod(ColNum,2).
	

