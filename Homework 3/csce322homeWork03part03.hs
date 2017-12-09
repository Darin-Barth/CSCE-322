import Prelude
import System.Environment ( getArgs )
import Data.List
import Helpers

-- The main method that will be used for testing / comgand line access
main = do
     args <- getArgs
     filename <- readFile (head args)
     (moves,maze) <- readElaborateMazeFile filename
     print "Result"
     printMaze (manyPlayersOneMove maze (head moves))

-- YOUR CODE SHOULD COME AFTER THIS POINT
manyPlayersOneMove :: [[Char]] -> Char -> [[Char]]
manyPlayersOneMove maze mo = onePlayerHelper maze mo '1'

onePlayerHelper :: [[Char]] -> Char  -> Char -> [[Char]]
onePlayerHelper [[]] _ _  = [[]]
onePlayerHelper maze nextDirec player 
	| (nextDirec == 'n') = maze
	| (find2D 'g' maze == []) = maze 
	| (checkPath maze player nextDirec == 0) = maze 
	| otherwise = onePlayerHelper newMaze nextMove player
	-- general thought process here is that I'm replacing my initial player spot with a dash and then replacing the new spot with the player
	-- hence, buffMaze is an intermediate in these swaps. Might need to include previous direction as a function argument for 2nd player search
		where 
		newMaze 		= replaceCharAtIndex buffMaze newCoord player 
		buffMaze 		= replaceCharAtIndex maze prevCoord '-'
		prevCoord 		= h
		(h:t) 			= find2D player maze 
		nextMove 		= dir
		(numPaths,dir) 	= continuePath newMaze player prevDir
		prevDir 		= nextDirec --check issues here, nextDirec has to be coordinates
		newCoord 		= coordinatesOfPath nextDirec prevCoord


checkPath :: [[Char]] -> Char -> Char -> Int
checkPath maze player direction = isEmptSpace maze coords 
			where 
			coords = coordinatesOfPath direction prevcoord
			prevcoord=h
			(h:t)=find2D player maze

coordinatesOfPath :: Char -> (Int,Int) -> (Int,Int)
coordinatesOfPath path (x,y) 
	| path == 'u' = (x-1,y)
	| path == 'd' = (x+1,y)						  
	| path == 'l' = (x,y-1)
	| path == 'r' = (x,y+1)


continuePath :: [[Char]] -> Char -> Char -> (Int,Char)
continuePath maze player prevDir = (numPaths,path)
	where 
	numPaths 	= (isEmptSpace maze up)+(isEmptSpace maze down)+(isEmptSpace maze left)+(isEmptSpace maze right)
	path 			= pathHelper numPaths maze player prevDir
	up 				= (x-1,y)
	down 			= (x+1,y)
	left 			= (x,y-1)
	right 			= (x,y+1)
	(x,y) 			= h
	(h:t) 			= find2D player maze

										  
pathHelper :: Int -> [[Char]] -> Char -> Char -> Char
pathHelper numPaths maze player prevDir
	| numPaths == 2 = nextPath maze player prevDir
	| otherwise = 'n'
	
nextPath :: [[Char]] -> Char -> Char -> Char										  
nextPath maze player prevDir 
					| prevDir == 'u' && (isEmptSpace maze up == 1) = 'u'
					| prevDir == 'u' && (isEmptSpace maze left == 1) = 'l'
					| prevDir == 'u' && (isEmptSpace maze right == 1) = 'r'
					| prevDir == 'd' && (isEmptSpace maze down == 1) = 'd'
					| prevDir == 'd' && (isEmptSpace maze left == 1) = 'l'
					| prevDir == 'd' && (isEmptSpace maze right == 1) ='r'
					| prevDir == 'l' && (isEmptSpace maze left == 1) = 'l'
					| prevDir == 'l' && (isEmptSpace maze up == 1) = 'u'
					| prevDir == 'l' && (isEmptSpace maze down == 1) = 'd'
					| prevDir == 'r' && (isEmptSpace maze right == 1) = 'r'
					| prevDir == 'r' && (isEmptSpace maze up == 1) = 'u'
					| prevDir == 'r' && (isEmptSpace maze down == 1) = 'd'
					where 
					up 	= (x-1,y)
					down 		= (x+1,y)
					left 		= (x,y-1)
					right 		= (x,y+1)
					(x,y)		= h
					(h:t) 		= find2D player maze	--extract first item of list
								
mazeRows :: [[Char]] -> Int
mazeRows [] = 0
mazeRows (row:rows) = 1 + (mazeRows rows)

mazeCols :: [[Char]] -> Int
mazeCols [] = 0
mazeCols (row:rows) = length row													
								
isEmptSpace :: [[Char]] -> (Int,Int) -> Int										  														
-- consider index out of bounds here	
isEmptSpace maze (x,y) 
		| (x >= mazeRows maze || x<0) = 0 
		| (y >= mazeCols maze || y<0) = 0
		| otherwise = isEmptSpaceHelper maze (x,y)
		
isEmptSpaceHelper :: [[Char]] -> (Int,Int) -> Int										  														
isEmptSpaceHelper maze coordinates
			| (getCharac2D maze coordinates 0 == '-' || getCharac2D maze coordinates 0 == 'g') = 1
			| otherwise = 0
								
getCharac2D :: [[Char]] -> (Int,Int) -> Int -> Char
getCharac2D (row:rows) (x,y) currentRow 
    | x == currentRow = getCharac row y 0
    | otherwise = getCharac2D rows (x,y) newCurrRow
        where newCurrRow=currentRow+1

getCharac :: [Char] -> Int -> Int ->  Char
getCharac (h:t) index currIndex
    | index == currIndex = h
    | otherwise = getCharac t index newCurrInd
        where newCurrInd = currIndex+1
								
replaceCharAtIndex :: [[Char]] -> (Int,Int) -> Char -> [[Char]]								
replaceCharAtIndex maze (x,y) newChar=replace2D maze (x,y) 0 newChar


replace2D :: [[Char]] -> (Int,Int) -> Int ->Char -> [[Char]]
replace2D (row:rows) (x,y) currX newChar 
        | currX == x = (replace row y 0 newChar):rows
        | otherwise = row:(replace2D rows (x,y) newX newChar)
            where newX = currX+1

replace :: [Char] -> Int -> Int -> Char -> [Char]
replace (h:t) index currentIndex newChar
			| index == currentIndex = newChar:t
			| otherwise = h:(replace t index newIndex newChar)
			    where newIndex=currentIndex+1
		
		
								
find2D :: Eq a => a -> [[a]] -> [(Int,Int)]
find2D _ [] = []
find2D el (row:rows) = this ++ those
       where thisRowPositions  = finder el row
       	     this	       = [(0,c)|c<-thisRowPositions]
	     thoseRowPositions = find2D el rows
	     those	       = map incrementRow thoseRowPositions
	     
incrementRow :: (Int,Int) -> (Int,Int)
incrementRow (a,b) = ((a+1),b)


finder :: Eq a => a -> [a] -> [Int]
finder el list = findHelper el list 0

findHelper :: Eq a => a -> [a] -> Int -> [Int]
findHelper _ [] _ = []
findHelper el (h:t) pos
	   | (el == h) = pos:(findHelper el t (pos+1))
	   | otherwise = findHelper el t (pos+1)