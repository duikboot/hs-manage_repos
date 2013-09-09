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


tests ::  Test
tests = TestList $ map TestCase
  [assertEqual "add tests here" 1 (1::Int)
  ,assertEqual "Test isEmptyLine" (isEmptyLine "") True
  ,assertEqual "Test not isEmptyLine" (isEmptyLine "Arjen") False
  ,assertEqual "Test stripLeadingSpaces" (stripLeadingSpaces "  Arjen") "Arjen"
  ,assertEqual "Test stripLeadingSpaces" (stripLeadingSpaces "Arjen") "Arjen"
  ,assertEqual "Test ignoreComments" (ignoreComments ["# a", "b", "# c"]) ["b"]
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
