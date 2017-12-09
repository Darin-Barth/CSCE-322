module Helpers
( readElaborateMazeFile
, printMaze
) where

import Prelude
import Data.Char
import Data.List
import Debug.Trace

readElaborateMazeFile :: String -> IO ([Char],[[Char]])
readElaborateMazeFile = readIO

printMaze :: [[Char]] -> IO ()
printMaze [] = do
	       print ""
printMaze (ro:ros) = do
	  	     print ro
		     printMaze ros
