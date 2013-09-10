import Test.HUnit
import Test.QuickCheck

import RevCommands

hg :: String
hg = "hg https://bitbucket.org/sjl/gundo.vim  test/gundo"

git :: String
git = "git https://github.com/mileszs/ack.vim.git test/ack"

subversion :: String
subversion = "svn https://github.com/mileszs/ack.vim.git test/ack"

someNonExistantVcs :: String
someNonExistantVcs = "svn https://github.com/mileszs/ack.vim.git test/ack"

lines' :: [String]
lines' = ["hg bla", "# git blaa", "  # git test", "  ", "  hg test"]

tests ::  Test
tests = TestList $ map TestCase
  [assertEqual "add tests here" 1 (1::Int)
  ,assertEqual "Test isEmptyLine" (isEmptyLine "") True
  ,assertEqual "Test not isEmptyLine" (isEmptyLine "BlaDi") False
  ,assertEqual "Test stripLeadingSpaces" (stripLeadingSpaces "  BlaDi") "BlaDi"
  ,assertEqual "Test stripLeadingSpaces" (stripLeadingSpaces "BlaDi") "BlaDi"
  ,assertEqual "Test ignoreComments" (ignoreComments ["# a", "b", "# c"]) ["b"]
  ,assertEqual "test stripEverything" (stripEverything lines') ["hg bla", "hg test"]
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
