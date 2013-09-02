module Main where

import System.Environment (getArgs)
import RevCommands

main ::  IO ()
main = do
    -- TODO: let user decide to do a update or clone
    -- action <- getArgs
    (infile:action:_) <- getArgs
    file <- readFile infile
    let f = ignoreComments (map stripLeadingSpaces (lines file))
    print f
    -- let sourcecontrol = map getSourceControl $ map ((++) (action ++ " ")) $ lines file
    let sourcecontrol = map (getSourceControl . (++) (action ++ " ")) f
    print sourcecontrol
    let a = map createCommandString sourcecontrol
    print a
    mapM_ execute a
    -- execute the vcs commands
    -- mapM_ system a
    return ()

-- main = do
--   check doesFileExist "input.txt"
--   check doesDirectoryExist "docs"
--   check doesFileExist "/input.txt"
--   check doesDirectoryExist "/docs"
