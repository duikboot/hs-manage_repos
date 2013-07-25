module RevCommands where

import Data.List (isPrefixOf)

data SourceControl = Git
                   | Mercurial
                   | Subversion
                   | Darcs
                   | Bazaar
                   deriving (Show, Eq)

vcMap ::  [(String, SourceControl)]
vcMap = [("git", Git), ("hg", Mercurial), ("svn", Subversion)]

clone :: SourceControl -> String
clone Git = "git clone"
clone Mercurial = "hg clone"
clone _ = error "Not implemented yet"

update :: SourceControl -> [String]
update Git = ["git pull"]
update Mercurial = ["hg pull", "hg update"]
update _ = error "Not implemented yet"

getSourceControl ::  String -> (Maybe SourceControl, String, String)
getSourceControl str =
    (vcs, link, path)
    where link = head $ tail words'
          path = last words'
          words' = words str
          s = head words'
          vcs = lookup s vcMap
