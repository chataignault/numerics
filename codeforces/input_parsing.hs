module Main where

import Control.Monad (replicateM)

-- Parse a single integer from a line
readInt :: IO Int
readInt = readLn

-- Parse a list of integers from a space-separated line
readInts :: IO [Int]
readInts = map read . words <$> getLine

-- Parse a list of any Read-able type from a space-separated line
readList :: Read a => IO [a]
readList = map read . words <$> getLine

-- Parse a single string (entire line)
readString :: IO String
readString = getLine

-- Parse words from a space-separated line
readWords :: IO [String]
readWords = words <$> getLine

-- Main function with examples
main :: IO ()
main = do
  putStrLn "=== Parsing Examples ==="

  -- Example 1: Parse a single integer
  putStrLn "\nEnter a single integer:"
  n <- readInt
  putStrLn $ "Parsed integer: " ++ show n

  -- Example 2: Parse a list of integers
  putStrLn "\nEnter space-separated integers:"
  nums <- readInts
  putStrLn $ "Parsed list: " ++ show nums
  putStrLn $ "Sum: " ++ show (sum nums)

  -- Example 3: Parse a string
  putStrLn "\nEnter a line of text:"
  text <- readString
  putStrLn $ "Parsed string: " ++ text

  -- Example 4: Parse words
  putStrLn "\nEnter space-separated words:"
  words' <- readWords
  putStrLn $ "Parsed words: " ++ show words'
  putStrLn $ "Word count: " ++ show (length words')
