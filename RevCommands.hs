module RevCommands where

import System.Process
import Data.Maybe
import GHC.IO.Exception (ExitCode)
import Data.Char (isSpace)
import Data.List (isPrefixOf)
import System.Directory (doesDirectoryExist) --, getHomeDirectory)
-- import System.FilePath (joinPath, splitPath)


data SourceControl = Git
                   | Mercurial
                   | Subversion
                   | Darcs
                   | Bazaar
                   deriving (Eq, Read)

instance Show SourceControl where
        show Git        = "Git --> git"
        show Mercurial  = "Mercurial --> hg"
        show Subversion = "Subversion --> svn"
        show Darcs      = "Darcs --> darcs"
        show Bazaar     = "Bazaar --> bzr"

type Path = String
type Link = String
type Command = String

vc :: String -> SourceControl
vc "git" = Git
vc "svn" = Subversion
vc "hg"  = Mercurial
vc _     = error "not implemented"

actionMap :: String -> [(SourceControl, Command)]
actionMap "clone"  = cloneMap
actionMap "update" = updateMap
actionMap "pull"   = pullMap
actionMap  _       = error "not implemented"

vcrev :: SourceControl -> String
vcrev Git        = "git"
vcrev Subversion = "svn"
vcrev Mercurial  = "hg"
vcrev _          = error "Not yet implemented"

cloneMap :: [(SourceControl, Command)]
cloneMap = [(Git, "clone"), (Mercurial, "clone"), (Subversion, "checkout")]

pullMap :: [(SourceControl, Command)]
pullMap = [(Mercurial, "clone")]

updateMap :: [(SourceControl, Command)]
updateMap = [(Git, "pull"), (Mercurial, "update")]


execute ::  [String] -> IO GHC.IO.Exception.ExitCode
execute commandstring = 
    rawSystem command args
    where command = head commandstring
          args    = tail commandstring

createCommandString :: (SourceControl, Command, Link, Path) -> [String]
createCommandString (vcs, action', link, path) =
    vcs' : args 
    where command = lookup vcs $ actionMap action'
          vcs'    = vcrev vcs
          action  = fromMaybe "echo" command
          args    = [action , link , path]

getSourceControl :: String -> (SourceControl, Command, Link, Path)
getSourceControl str =
    (vcs, action, link, path)
     where words'  = words str
           action  = head words'
           path    = last words'
           link    = last $ init words'
           key     = head $ tail words'
           vcs     = vc key

getPath ::  (t, t1, t2, FilePath) -> IO Bool
getPath (_,_,_,x) = doesDirectoryExist x

stripLeadingSpaces :: String -> String
stripLeadingSpaces s
    | isSpace (head s) = stripLeadingSpaces (tail s)
    | otherwise        = s

ignoreComments :: [String] -> [String]
ignoreComments = filter (not . isComment)

isComment :: String -> Bool
isComment = isPrefixOf "#" 

isEmptyLine :: String -> Bool
isEmptyLine [] = True
isEmptyLine x
    | all isSpace x = True
    | otherwise     = False

stripEmptyLines :: [String] -> [String]
stripEmptyLines = filter (not . isEmptyLine)

stripEverything :: [String] -> [String]
stripEverything l = ignoreComments $ map (dropWhile (== ' ')) $ stripEmptyLines l

-- getFullPath ::  FilePath -> IO FilePath
-- getFullPath s = do
--     homeDir <- getHomeDirectory
--     return $ case splitPath s of
--         ("~" : t) -> joinPath $ homeDir : t
--         _ -> s
