module Main where

import RevCommands

main ::  IO ()
main = do
    file <- readFile "modules"
    let sourcecontrol = map getSourceControl $ lines file
    print sourcecontrol
    return ()

