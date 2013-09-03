module Main where

import System.Environment (getArgs)
import Control.Monad (filterM, liftM)
import RevCommands

main ::  IO ()
main = do
    (infile:action:_) <- getArgs
    file <- readFile infile
    let f = ignoreComments $ map stripLeadingSpaces $ stripEmptyLines (lines file)
    let sourcecontrol = map (getSourceControl . (++) (action ++ " ")) f
    print sourcecontrol
    if action == "clone"
        then do
            -- If path exists, don't clone it again
            list <- filterM (liftM not . getPath) sourcecontrol
            mapM_ execute (map createCommandString list)
        else mapM_ execute (map createCommandString sourcecontrol)
    return ()
