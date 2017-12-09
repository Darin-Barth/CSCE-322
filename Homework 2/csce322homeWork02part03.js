module.exports = {
    manyPlayersOneMove: manyPlayersOneMove
}

var helpers = require( './helpers' );

function manyPlayersOneMove( maze ){
    
    function whatever( move ){
		
	maze=updateMaze(maze,'1',move);	
	
	return maze;
    }

    return whatever;
}

function updateMaze(maze, player, direction){
	
	
	var currentLocation = playerLocation(player,maze);
	var x=currentLocation[0];
	var y=currentLocation[1];
	var rows=maze.length;
	var columns=maze[0].length;
	var newDirection='';

	
		if(!hasPaths(maze,x,y,direction,rows,columns)){
			return maze;
		}
	
		if(direction=='u'){
				var info=makeMove(maze,x,y,'u'); //fix all occurences
				maze=info[0];
				x=info[1];
				y=info[2];
				newDirection=continuePath(maze,x,y,direction,rows,columns);
				while(newDirection!='?' && playerLocation('g',maze)!=-1){
					info=makeMove(maze,x,y,newDirection); //fix all occurences
					maze=info[0];
					x=info[1];
					y=info[2];
					newDirection=continuePath(maze,x,y,newDirection,rows,columns);
				}


		}else if(direction=='d'){
				var info=makeMove(maze,x,y,'d'); //fix all occurences
				maze=info[0];
				x=info[1];
				y=info[2];
				newDirection=continuePath(maze,x,y,direction,rows,columns);
				while(newDirection!='?' && playerLocation('g',maze)!=-1){
					info=makeMove(maze,x,y,newDirection); //fix all occurences
					maze=info[0];
					x=info[1];
					y=info[2];
					newDirection=continuePath(maze,x,y,newDirection,rows,columns);
				}

		
				
		}else if(direction=='l'){
				var info=makeMove(maze,x,y,'l'); //fix all occurences
				maze=info[0];
				x=info[1];
				y=info[2];
				newDirection=continuePath(maze,x,y,direction,rows,columns);
				while(newDirection!='?' && playerLocation('g',maze)!=-1){
					info=makeMove(maze,x,y,newDirection); //fix all occurences
					maze=info[0];
					x=info[1];
					y=info[2];
					newDirection=continuePath(maze,x,y,newDirection,rows,columns);
				}
		
				
		}else if(direction=='r'){
				var info=makeMove(maze,x,y,'r'); //fix all occurences
				maze=info[0];
				x=info[1];
				y=info[2];
				newDirection=continuePath(maze,x,y,direction,rows,columns); 
				while(newDirection!='?' && playerLocation('g',maze)!=-1){
					info=makeMove(maze,x,y,newDirection); //fix all occurences
					maze=info[0];
					x=info[1];
					y=info[2];
					newDirection=continuePath(maze,x,y,newDirection,rows,columns);
				}
		}

return maze;	
}
	
	
	
function continuePath(maze,x,y,prevDirection,rows,columns){
	var newDirection='?';
	var numOfPaths=0;
	var currentAvailPath='';
	if(prevDirection=='u'){
		if(x-1>=0 && (maze[x-1][y]=='-' || maze[x-1][y]=='g' )){
			numOfPaths=numOfPaths+1;
			currentAvailPath='u';
		}
		if(y-1>=0 && ( maze[x][y-1]=='-' || maze[x][y-1]=='g' )){
			numOfPaths=numOfPaths+1;
			currentAvailPath='l';
		}
		if(y+1<columns && ( maze[x][y+1]=='-' || maze[x][y+1]=='g' )){
			numOfPaths=numOfPaths+1;
			currentAvailPath='r';
		}
		if(numOfPaths==1){
			return currentAvailPath;
		}
	}
	else if(prevDirection=='d'){
		if(x+1<rows && (maze[x+1][y]=='-'|| maze[x+1][y]=='g' )){
			numOfPaths=numOfPaths+1;
			currentAvailPath='d';
		}
		if(y-1>=0 && (maze[x][y-1]=='-' || maze[x][y-1]=='g')){
			numOfPaths=numOfPaths+1;
			currentAvailPath='l';
		}
		if(y+1<columns && (maze[x][y+1]=='-' || maze[x][y+1]=='g')){
			numOfPaths=numOfPaths+1;
			currentAvailPath='r';
		}
		if(numOfPaths==1){
			return currentAvailPath;
		}		
	}
	else if(prevDirection=='l'){
		if(x+1<rows && (maze[x+1][y]=='-' || maze[x+1][y]=='g')){
			numOfPaths=numOfPaths+1;
			currentAvailPath='d';
		}
		if(x-1>=0 && (maze[x-1][y]=='-' || maze[x-1][y]=='g' )){
			numOfPaths=numOfPaths+1;
			currentAvailPath='u';
		}
		if(y-1>=0 && (maze[x][y-1]=='-' || maze[x][y-1]=='g')){
			numOfPaths=numOfPaths+1;
			currentAvailPath='l';
		}
		if(numOfPaths==1){
			return currentAvailPath;
		}		
	}
	else if(prevDirection=='r'){
		if(x+1<rows && (maze[x+1][y]=='-' || maze[x+1][y]=='g' )){
			numOfPaths=numOfPaths+1;
			currentAvailPath='d';
		}
		if(y+1<columns && (maze[x][y+1]=='-' || maze[x][y+1]=='g' )){
			numOfPaths=numOfPaths+1;
			currentAvailPath='r';
		}
		if(x-1>=0 && (maze[x-1][y]=='-' || maze[x-1][y]=='g' )){
			numOfPaths=numOfPaths+1;
			currentAvailPath='u';
		}
		if(numOfPaths==1){
			return currentAvailPath;
		}		
	}
	return newDirection;
}

function hasPaths(maze,x,y,direction,rows,columns){
	var up='';
	var down='';
	var left='';
	var right='';
	
	if(y-1>=0){
		left=maze[x][y-1];
	}
	if(y+1<columns){
		right=maze[x][y+1];
	}
	if(x-1>=0){
		up=maze[x-1][y];
	}
	if(x+1<rows){
		down=maze[x+1][y];
	}
	
	if(direction=='u' && (up=='-'||up=='g') ){
		return true;
	}
	else if(direction=='d' && (down=='-' || down=='g')){
		return true;
	}
	else if(direction=='l' && (left=='-' || left=='g')  ){
		return true;
	}
else if(direction=='r' && (right=='-' || right=='g')){
		return true;
	}
	else{
		return false;
	}
}

function makeMove(maze,x,y,direction){
	
	if(direction=='u'){
		maze[x-1][y]=maze[x][y];
		maze[x][y]='-';
		x=x-1;
		return [maze,x,y];
	}
	else if(direction=='d'){
		maze[x+1][y]=maze[x][y];
		maze[x][y]='-';
		x=x+1;
		return [maze,x,y];
	}
	else if(direction=='l'){
		maze[x][y-1]=maze[x][y];
		maze[x][y]='-';
		y=y-1;
		return [maze,x,y];
	}
	else if(direction=='r'){
		maze[x][y+1]=maze[x][y];
		maze[x][y]='-';
		y=y+1;
		return [maze,x,y];
	}	
	else {
		return -1;
	}
}


function playerLocation(player,maze){
	for(var i=0;i<maze.length;i++){
		for(var j=0;j<maze[0].length;j++){
			if(maze[i][j]==player){
				return [i,j];
			}
		}
	}
	return -1;
}