percentWalls([H|T]):-
	findall(Where,find2D([H|T],x,Where),Xs),
	length(Xs,Barriers),
	length([H|T],Rows),
	length(H,Cols),
	Spots is Rows * Cols,
	0.7 >= Barriers / Spots.
	

