module Main where

table :: [[Int]]
table =
    [
        [0, 0, 0, 1, 1],
        [0, 0, 1, 0, 1],
        [0, 0, 1, 1, 0],
        [0, 1, 0, 0, 1],
        [0, 1, 0, 1, 0],
        [0, 1, 1, 0, 0],
        [1, 0, 0, 0, 1],
        [1, 0, 0, 1, 0],
        [1, 0, 1, 0, 0],
        [1, 1, 0, 0, 0]
    ]

barHeight :: Int
barHeight = 23

halfBarHeight :: Int
halfBarHeight = 8

barWidth :: Int
barWidth = 3

verticalPadding :: Int
verticalPadding = 2

horizontalPadding :: Int
horizontalPadding = 2

quietZone :: Int
quietZone = 25 - horizontalPadding

main :: IO ()
main = putStrLn "Hello, Haskell!"
