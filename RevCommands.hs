module RevCommands where

import System.Cmd (rawSystem)
import System.Directory (doesDirectoryExist)

data SourceControl = Git
                   | Mercurial
                   | Subversion
                   | Darcs
                   | Bazaar
                   deriving (Show, Eq)

type Path = String
type Link = String
type Command = String

vcMap ::  [(String, SourceControl)]
vcMap = [("git", Git), ("hg", Mercurial), ("svn", Subversion)]

cloneMap :: [(SourceControl, Command)]
cloneMap = undefined

pullMap :: [(SourceControl, Command)]
pullMap = undefined

updateMap :: [(SourceControl, Command)]
updateMap = undefined

-- execute vcs =
--     case vcs of

clone vcs = undefined


pull vcs = undefined

update = undefined


execute = undefined
    -- | otherwise = rawSystem "git" ["clone", "https://github.com/mileszs/ack.vim.git", "test/ack"]
-- check :: (FilePath -> IO Bool) -> FilePath -> IO ()

-- check ::  FilePath -> IO ()
check dir = do
    result <- doesDirectoryExist dir
    return False
    -- putStrLn $ dir ++ if result then " does exist" else " does not exist"


getSourceControl ::  String -> (Maybe SourceControl, Link, Path)
getSourceControl str =
    (vcs, link, path)
    where link = head $ tail words'
          path = last words'
          words' = words str
          key = head words'
          vcs = lookup key vcMap

