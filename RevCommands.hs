module RevCommands where

import Data.List (isPrefixOf)

data SourceControl = Git
                   | Mercurial
                   | Subversion
                   deriving (Show, Eq)

clone :: SourceControl -> String
clone Git = "git clone"
clone Mercurial = "hg clone"
clone Subversion = undefined

update :: SourceControl -> [String]
update Git = ["git pull"]
update Mercurial = ["hg pull", "hg update"]
update Subversion = undefined

getSourceControl :: String -> (SourceControl, String, String)
getSourceControl str
    | "[git]" `isPrefixOf` str = (Git , link, path)
    | "[hg]" `isPrefixOf` str = (Mercurial, link, path)
    | "[subversion]" `isPrefixOf` str = (Subversion, link, path)
    | otherwise = error "Not implemented yet"
    where link = head $ tail w
          path = last w
          w = words str
