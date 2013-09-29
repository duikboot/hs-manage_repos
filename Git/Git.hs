module Git where
 
import System.Process (createProcess, waitForProcess, shell)
import System.Exit (ExitCode(..))
import System.IO (hPutStrLn, stderr, stdout)


git :: String -> IO ()
git s = do
    (_, _, _, ph) <- createProcess $ shell $ "git " ++ s
    exit <- waitForProcess ph
    case exit of
        ExitSuccess -> do hPutStrLn stdout $ "cloned " ++ s
        ExitFailure code -> do hPutStrLn stderr $ "git " ++ s ++ " script failed with exitcode: " ++ show code

main ::  IO ()
main = do
    let temp = "clone http://github.com/duikboot/dorfiles"
    git temp
