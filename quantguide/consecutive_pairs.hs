-- Generate all subsets of a list
subsets :: [a] -> [[a]]
subsets [] = [[]]
subsets (x:xs) = subsets xs ++ map (x:) (subsets xs)

subsetsOf10 :: [[Int]]
subsetsOf10 = subsets [1..10]

--valid :: [Int] -> Bool
--valid [] = False
--valid [a] = False
--valid (x:y:[]) = x + 1 == y
--valid (x:y:z:xs) = (x + 1 == y && z > y + 1 && not (valid (z:xs))) || (y > x+1 && valid (y:z:xs))

valid :: [Int] -> Bool
valid x = count_consecutive x == 1

count_consecutive :: [Int] -> Int
count_consecutive [] = 0
count_consecutive [x] = 0
count_consecutive (x:y:xs)
    | x + 1 == y = 1 + count_consecutive (y:xs)
    | otherwise = count_consecutive (y:xs)

main :: IO ()
main = do
    putStrLn $ "Number of subsets: " ++ show (length subsetsOf10)
    let valid_subsets = [x | x <- subsetsOf10, valid x]
    putStrLn $ "Number of valid subsets: " ++ show (length valid_subsets)
    putStrLn "First 10"
    mapM_ print (take 10 valid_subsets)

