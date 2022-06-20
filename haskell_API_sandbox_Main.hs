module Main where

import Network.Wreq

main :: IO ()
main = do
 response <- get "https://libretranslate.com/languages"
 print response 






























