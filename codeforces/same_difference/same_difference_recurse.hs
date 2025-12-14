module Main where

readInt :: IO Int
readInt = readLn

readInts :: IO [Int]
readInts = map read . words <$> getLine

readList :: Read a => IO [a]
readList = map read . words <$> getLine

readString :: IO String
readString = getLine

readWords :: IO [String]
readWords = words <$> getLine

solve 0 = return ()
solve n = do
  k <- readInt
  text <- readString
  putStrLn $ show $ length [x | x <- text, x /= last text]
  solve (n-1)


main :: IO ()
main = do
  n <- readInt
  solve n

