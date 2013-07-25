
import Test.HUnit
import Test.QuickCheck

import RevCommands

hg :: String
hg = "hg https://bitbucket.org/sjl/gundo.vim  test/gundo"

git :: String
git = "git https://github.com/mileszs/ack.vim.git test/ack"

subversion :: String
subversion = "svn https://github.com/mileszs/ack.vim.git test/ack"

tests ::  Test
tests = TestList $ map TestCase
  [assertEqual "add tests here" 1 (1::Int)
  ,assertEqual "Git command" (clone Git) "git clone"
  ,assertEqual "Mercurial clone command" (clone Mercurial) "hg clone"
  ,assertEqual "Git update" (update Git) ["git pull"]
  ,assertEqual "Mercurial update command" (update Mercurial) ["hg pull", "hg update"]
  ,assertEqual "test SourceControl"
                (getSourceControl git)
                (Just Git, "https://github.com/mileszs/ack.vim.git", "test/ack")
  ,assertEqual "test SourceControl"
                (getSourceControl hg)
                (Just Mercurial, "https://bitbucket.org/sjl/gundo.vim", "test/gundo")
  ,assertEqual "test SourceControl"
                (getSourceControl subversion)
                (Just Subversion, "https://github.com/mileszs/ack.vim.git", "test/ack")
  ]

-- temporary placeholder for some real property tests
prop_empty ::  Int -> Bool
prop_empty c1 = (c1::Int) == c1

runTests ::  IO ()
runTests = do
  runTestTT tests
  quickCheck prop_empty

-- | For now, main will run our tests.
main :: IO ()
main = runTests
