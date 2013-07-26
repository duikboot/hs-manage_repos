module Main where

-- import System.Environment (getArgs)
import RevCommands
import System.Cmd (system)

main ::  IO ()
main = do
    -- TODO: let user decide to do a update or clone
    -- action <- getArgs
    file <- readFile "modules"
    let sourcecontrol = map getSourceControl $ lines file
    print sourcecontrol
    let a = map clone sourcecontrol
    
    -- execute the vcs commands
    mapM_ system a
    return ()

