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

black :: PixelRGB8
black = PixelRGB8 0x00 0x00 0x00

saveImage :: Image PixelRGB8 -> IO ()
saveImage img =
    savePngImage output $ ImageRGB8 img

asImage :: [[PixelRGB8]] -> Image PixelRGB8
asImage pixels =
    generateImage (\x y -> pixels !! x !! y) width height
    where
        width = length pixels
        height = length $ pixels !! 0

padding :: (Int, Int) -> [[PixelRGB8]]
padding (width, height) =
    map (\_ -> map (\_ -> white) [1..height]) [1..width]

bar :: (Int, Int) -> [[PixelRGB8]]
bar (height, v) =
    pad ++ bar ++ pad
    where
        pad = padding (horizontalPadding, height)
        offset = if (v == 0)
            then height - halfBarHeight - verticalPadding
            else verticalPadding
        yfn = \y -> if (y > offset && y <= height - verticalPadding) then black else white
        bar = map(\_ -> map yfn [1..height]) [1..barWidth]

asPixels :: [Int] -> [[PixelRGB8]]
asPixels code =
    foldl (\l v -> l ++ (bar (height, v))) [] code
    where
        height = barHeight + verticalPadding * 2

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

checkDigit :: [Int] -> Int
checkDigit arr =
    10 - (rem s 10)
    where
        s = sum arr

build :: String -> [Int]
build str =
    fb ++ code ++ cd ++ fb
    where
        query = splitQuery str []
        code = asCode query []
        fb = 1:[]
        cd = table !! (checkDigit query - 1)

main :: IO ()
main =
    saveImage image
    where
        code = build "12345"
        image = asImage $ asPixels code
