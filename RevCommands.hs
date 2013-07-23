module RevCommands where

data SourceControl = Git
                   | Mercurial
                   | Subversion
                   deriving (Show)

clone :: SourceControl -> String
clone Git = "git clone"
clone Mercurial = "hg clone"

update :: SourceControl -> [String]
update Git = ["git pull"]
update Mercurial = ["hg pull", "hg update"]
update Subversion = undefined

