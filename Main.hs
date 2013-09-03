module Main where

import System.Environment (getArgs)
import RevCommands

main ::  IO ()
main = do
    (infile:action:_) <- getArgs
    file <- readFile infile
    let f = ignoreComments (map stripLeadingSpaces (lines file))
    -- fillist <- mfilter (not doesDirectoryExist) (map (!! 3) f)
    let sourcecontrol = map (getSourceControl . (++) (action ++ " ")) f
    print sourcecontrol
    let paths = map getPath sourcecontrol
    print paths
    let a = map createCommandString sourcecontrol

    mapM_ execute a
    return ()
