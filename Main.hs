module Main where

import System.Environment (getArgs)
import Control.Monad (filterM, liftM)
import Control.Concurrent.ParallelIO

import RevCommands

main ::  IO ()
main = do
    (infile:action:_) <- getArgs
    file <- readFile infile
    let f = stripEverything (lines file)
    let sourcecontrol = map (getSourceControl . (++) (action ++ " ")) f
    print sourcecontrol
    if action == "clone"
        then do
            -- If path exists, don't clone it again
            list <- filterM (liftM not . getPath) sourcecontrol
            parallel_ $ map (execute . createCommandString) list
            stopGlobalPool
        else mapM_ (execute . createCommandString) sourcecontrol
    -- return ()
