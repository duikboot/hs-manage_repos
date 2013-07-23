module RevCommands where

import Data.List (isPrefixOf)

data SourceControl = Git
                   | Mercurial
                   | Subversion
                   deriving (Show)

clone :: SourceControl -> String
clone Git = "git clone"
clone Mercurial = "hg clone"
clone Subversion = undefined

update :: SourceControl -> [String]
update Git = ["git pull"]
update Mercurial = ["hg pull", "hg update"]
update Subversion = undefined

getSourceControl :: String -> SourceControl
getSourceControl str
    | "[git]" `isPrefixOf` str = Git
    | "[hg]" `isPrefixOf` str = Mercurial
    | otherwise = undefined
