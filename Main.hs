
module Main where

import System.Cmd


main ::  IO ()
main = do
    file <- readFile "modules"
    putStrLn file
