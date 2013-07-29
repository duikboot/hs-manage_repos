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

actionMap "clone" = cloneMap
actionMap "update" = updateMap
actionMap "pull" = pullMap

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

execute commandstring = 
    rawSystem command args
    where command = head commandstring
          args    = tail commandstring

createCommandString (vcs, action', link, path) =
    -- rawSystem vcs' args 
    vcs' : args 
    -- createProcess (proc vcs' args) 
    -- vcs' : args 
    -- action
    where command = lookup vcs $ actionMap action'
          vcs' = vcrev vcs
          action = fromMaybe "echo" command
          -- args = action : link : path : []
          args = [action , link , path]

getSourceControl ::  String -> (SourceControl, String, String, String)
getSourceControl str =
    (vcs, action, link, path)
     where words'  = words str
           action  = head words'
           path    = last words'
           link    = last $ init words'
           key     = head $ tail words'
           vcs     = vc key

