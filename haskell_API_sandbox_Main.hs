{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-} 

module Main where

import Network.Wreq
import Data.Text (Text)
import Data.Aeson
import GHC.Generics
import Language.Haskell.TH
import Control.Lens
import qualified Data.Text.IO as T

data TranslateRequest = TranslateRequest {
 q :: Text,
 source :: Text,
 target :: Text,
 format :: Text
 }
 deriving (Generic,Show)

instance ToJSON TranslateRequest



data TranslateResponse = TranslateResponse {
 translatedText :: Text
 }
 deriving (Generic)

instance FromJSON TranslateResponse 
 


main :: IO ()
main = do
 response <- asJSON =<< post "https://translate.argosopentech.com/translate" (toJSON (TranslateRequest {
 q = "Poopy Haskell Programmer -Bob Bobo",
 source = "en",
 target = "ru",
 format = "Text"
 }))
 T.putStrLn (translatedText (response ^. responseBody )) 






























