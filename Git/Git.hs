{-# LANGUAGE OverloadedStrings #-}
 
module Git where
 
import Data.Text.Lazy (Text)
import qualified Data.Text.Lazy as T
import Prelude hiding (FilePath)
import Shelly
 
git :: [Text] -> Sh Text
git = run "git"
 
git_ :: [Text] -> Sh ()
git_ = run_ "git"
 
gitCommit_ :: [Text] -> Sh ()
gitCommit_ = git_ . (:) "commit"
 
gitInit_ :: [Text] -> Sh ()
gitInit_ = git_ . (:) "init"
 
gitAdd_ :: [Text] -> Sh ()
gitAdd_ = git_ . (:) "add"
