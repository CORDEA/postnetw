module Main where

import Data.Char(digitToInt)
import Codec.Picture

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

output :: String
output = "code.png"

white :: PixelRGB8
white = PixelRGB8 0xff 0xff 0xff

saveImage :: Image PixelRGB8 -> IO ()
saveImage img =
    savePngImage output $ ImageRGB8 img

asImage :: Image PixelRGB8
asImage =
    generateImage (\_ _ -> white) width height
    where
        width = 200
        height = 100

splitQuery :: String -> [Int] -> [Int]
splitQuery "" arr = arr
splitQuery (f:q) arr =
    splitQuery q $ arr ++ (digitToInt f):[]

asCode :: [Int] -> [Int] -> [Int]
asCode [] arr = arr
asCode (f:q) arr =
    asCode q $ arr ++ c
    where
        c = table !! (f - 1)

build :: String -> [Int]
build str =
    fb ++ code ++ fb
    where
        query = splitQuery str []
        code = asCode query []
        fb = 1:[]

main :: IO ()
main =
    putStrLn $ show code
    where
        code = build "12345"
