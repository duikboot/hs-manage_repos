
module Main where

main ::  IO ()
main = do
    file <- readFile "modules"
    putStrLn file

