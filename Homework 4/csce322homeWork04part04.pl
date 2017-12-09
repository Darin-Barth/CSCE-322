openNeighbors(Maze,(R,C),Answer):-
	NewRow1 is R-1,
	NewRow2 is R+1,
	NewCol1 is C-1,
	NewCol2 is C+1,
	openCount(Maze,(NewRow1,C),Up),
	openCount(Maze,(NewRow2,C),Down),
	openCount(Maze,(R,NewCol1),Left),
	openCount(Maze,(R,NewCol2),Right),
	Answer is Up+Down+Left+Right.
	
openCount(Maze,Space,Count):-
	find2D(Maze,-,Space),
	Count is 1.

openCount(Maze,Space,Count):-
	find2D(Maze,g,Space),
	Count is 1.
	
openCount(Maze,Space,Count):-
	Count is 0.
	
% maybe account for false statements that return 0
	
	