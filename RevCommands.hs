module RevCommands where

data SourceControl = Git
                   | Mercurial
                   | Subversion
                   deriving (Show)

clone :: SourceControl -> String
clone Git = "git clone"
clone Mercurial = "hg clone"
