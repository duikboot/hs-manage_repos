module Main where

import System.Environment (getArgs)
import RevCommands

main ::  IO ()
main = do
    -- TODO: let user decide to do a update or clone
    -- action <- getArgs
    (infile:_) <- getArgs
    file <- readFile infile
    let sourcecontrol = map getSourceControl $ lines file
    print sourcecontrol
    let a = map clone sourcecontrol
    let abc = map execute sourcecontrol
    -- print abc
    -- execute the vcs commands
    -- mapM_ system a
    return ()

-- main = do
--   check doesFileExist "input.txt"
--   check doesDirectoryExist "docs"
--   check doesFileExist "/input.txt"
--   check doesDirectoryExist "/docs"
