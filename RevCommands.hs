module RevCommands where

import System.Cmd (rawSystem, system)
import System.Directory (doesDirectoryExist)
import System.Process
import Control.Monad
import Data.Tuple
import Data.Maybe

data SourceControl = Git
                   | Mercurial
                   | Subversion
                   | Darcs
                   | Bazaar
                   deriving (Show, Eq)

type Path = String
type Link = String
type Command = String

vc :: String -> SourceControl
vc "git" = Git
vc "svn" = Subversion
vc "hg"  = Mercurial

vcrev :: SourceControl -> String
vcrev Git        = "git"  
vcrev Subversion = "svn" 
vcrev Mercurial  = "hg"   

cloneMap :: [(SourceControl, Command)]
cloneMap = [(Git, "clone"), (Mercurial, "clone"), (Subversion, "checkout")]

pullMap :: [(SourceControl, Command)]
pullMap = [(Mercurial, "clone")]

updateMap :: [(SourceControl, Command)]
updateMap = [(Git, "pull"), (Mercurial, "update")]

-- execute vcs =
--     case vcs of


execute (vcs, link, path) =
    rawSystem vcs' args 
    -- createProcess (proc vcs' args) 
    -- vcs' : args 
    -- action
    where command = lookup vcs cloneMap
          vcs' = vcrev vcs
          action = fromMaybe "echo" command
          -- args = action : link : path : []
          args = [action , link , path]


    -- | otherwise = rawSystem "git" ["clone", "https://github.com/mileszs/ack.vim.git", "test/ack"]
-- check :: (FilePath -> IO Bool) -> FilePath -> IO ()

-- check ::  FilePath -> IO ()
check dir = do
    result <- doesDirectoryExist dir
    return False
    -- putStrLn $ dir ++ if result then " does exist" else " does not exist"


getSourceControl ::  String -> (SourceControl, String, String)
getSourceControl str =
    (vcs, link, path)
    where link = head $ tail words'
          path = last words'
          words' = words str
          key = head words'
          vcs = vc key 

