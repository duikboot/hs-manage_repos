module Git where
 
import System.Environment (getArgs)
import System.Process (createProcess, waitForProcess, shell)
import System.Exit (ExitCode(..))
import System.IO (hPutStrLn, stderr, stdout)
import System.Directory (doesDirectoryExist, getCurrentDirectory, setCurrentDirectory) --, getHomeDirectory)


git :: String -> IO ()
git s = do
    (_, _, _, ph) <- createProcess $ shell $ "git " ++ s
    print ("git " ++ s)
    exit <- waitForProcess ph
    case exit of
        ExitSuccess -> do hPutStrLn stdout $ s
        ExitFailure code -> do hPutStrLn stderr $ "git " ++ s ++ " script failed with exitcode: " ++ show code


clone :: String -> String -> IO ()
clone link target = do
        exists <- doesDirectoryExist target
        let s = link ++ " " ++ target
        if (not exists)
            then (git . (++) "clone ") s
            else putStrLn "Directory exists"

pull :: String -> String -> IO ()
pull link target = do
        cwd <- getCurrentDirectory
        setCurrentDirectory target
        git "pull"
        setCurrentDirectory cwd

actions :: String -> String -> String -> IO ()
actions "clone" = clone
actions "update" = pull

main ::  IO ()
main = do
    (link:action:path:_) <- getArgs
    actions action link path
