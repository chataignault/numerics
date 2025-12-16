-- Generate all subsets of a list
subsets :: [a] -> [[a]]
subsets [] = [[]]
subsets (x:xs) = subsets xs ++ map (x:) (subsets xs)

-- Generate subsets of [1..10] for the example
subsetsOf10 :: [[Int]]
subsetsOf10 = subsets [1..10]

-- First method: keep count of consecutive occurrences
valid :: [Int] -> Bool
valid x = count_consecutive x == 1

count_consecutive :: [Int] -> Int
count_consecutive [ ] = 0
count_consecutive [x] = 0
count_consecutive (x:y:xs)
    | x + 1 == y = 1 + count_consecutive (y:xs)
    | otherwise = count_consecutive (y:xs)

-- Second method: using a boolean accumulator
-- which informs about the presence of a unique consecutive pair, before the current step
valid' :: [Int] -> Bool -> Bool
valid' [ ] acc      = acc
valid' [a] acc      = acc
valid' (x:y:xs) acc
    | x + 1 == y = not acc && valid' (y:xs) True
    | otherwise  = valid' (y:xs) acc

main :: IO ()
main = do
    putStrLn $ "Number of subsets: " ++ show (length subsetsOf10)
    let valid_subsets = [x | x <- subsetsOf10, valid x]
    putStrLn "First method: counting consecutive pairs"
    putStrLn $ "Number of valid subsets: " ++ show (length valid_subsets)
    putStrLn "First 10"
    mapM_ print (take 10 valid_subsets)
    putStrLn ""
    putStrLn "Second method: using a boolean accumulator"
    let valid_subsets' = [x | x <- subsetsOf10, valid' x False]
    putStrLn $ "Number of valid subsets: " ++ show (length valid_subsets')

