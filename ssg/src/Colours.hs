module Colours (
    colours
)
where

-- import color package
import Data.Colour (Colour)
import Data.Colour.SRGB (RGB, sRGB24read)

brand :: Colour Double
brand = sRGB24read "#6241C7"


-- Colour map
colours :: [(String, String)]
colours =
  [("red", "#ff0000")
  ,("green", "#00ff00")
  ,("blue", "#0000ff")
  ,("yerro", "#ffff00")
  ,("cyan", "#00ffff")
  ,("magenta", "#ff00ff")
  ,("white", "#ffffff")
  ,("foobar", "#6241c7")]