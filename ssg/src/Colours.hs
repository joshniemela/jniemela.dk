module Colours (
    colours
)
where

-- import color package
import Data.Colour (Colour, darken)
import Data.Colour.SRGB (sRGB24read, sRGB24show)

brand = sRGB24read "#402F65"
important = sRGB24read "#D16328"
neutral = sRGB24read "#5E5E5E"

generateColours :: String -> Colour Double -> [(String, String)]
generateColours name colour =
  [ (name ++ show i, sRGB24show $ darken (0.2 * fromIntegral i) colour)
  | i <- [0..10]
  ]

-- Colour map
colours :: [(String, String)]
colours =
  generateColours "brand" brand
  ++ generateColours "important" important
  ++ generateColours "neutral" neutral
