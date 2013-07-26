module RevCommands where


data SourceControl = Git
                   | Mercurial
                   | Subversion
                   | Darcs
                   | Bazaar
                   deriving (Show, Eq)

type Path = String
type Link = String

vcMap ::  [(String, SourceControl)]
vcMap = [("git", Git), ("hg", Mercurial), ("svn", Subversion)]

clone :: (Maybe SourceControl, Link, Path) -> String
clone vcs =
    case vcs of
        (Just Git, link, path) ->  "git clone " ++ " " ++ link ++ " " ++ path
        (Just Mercurial, link, path) -> "hg clone " ++ " " ++ link ++ " " ++ path
        _ -> error "Not implemeted yet"

getUpdates ::  [(SourceControl, String)]
getUpdates = [(Mercurial, "hg pull")]

update ::  [(SourceControl, String)]
update = [(Git, "git pull"), (Mercurial, "hg update")]


getSourceControl ::  String -> (Maybe SourceControl, Link, Path)
getSourceControl str =
    (vcs, link, path)
    where link = head $ tail words'
          path = last words'
          words' = words str
          key = head words'
          vcs = lookup key vcMap

