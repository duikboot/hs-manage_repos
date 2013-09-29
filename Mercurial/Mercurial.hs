module Mercurial where

type Path = String
type Link = String
type Command = String


clone :: (Link, Path) -> Command
clone (link,path) = "hg clone " ++ link ++ " " ++ path


update :: Path -> Command
update path =  "hg pull --cwd " ++ path

