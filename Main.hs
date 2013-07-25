module Main where

import System.Environment (getArgs)
import RevCommands
import System.Cmd
import Control.Monad

main ::  IO ()
main = do
    action <- getArgs
    file <- readFile "modules"
    let sourcecontrol = map getSourceControl $ lines file
    print sourcecontrol
    let a = map clone sourcecontrol
    mapM_ system a
    return ()

