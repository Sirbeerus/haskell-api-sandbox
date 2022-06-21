{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-} 

module Main where

import Network.Wreq
import Data.Text (Text)
import Data.Aeson
import GHC.Generics

data TranslateRequest = TranslateRequest {
 q :: Text,
 source :: Text,
 target :: Text,
 format :: Text
 }
 deriving (Generic,Show)

instance ToJSON TranslateRequest

main :: IO ()
main = do
 response <- post "https://translate.argosopentech.com/translate" (toJSON (TranslateRequest {
 q = "Poopy Haskell Programmer -Bob Bobo",
 source = "en",
 target = "es",
 format = "text"
 }))  
 print response 






























