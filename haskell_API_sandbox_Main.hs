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
import Control.Monad (forM_)
 

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
 deriving (Generic,Show)

instance FromJSON TranslateResponse 
 


data Language = Language {
 code :: Text,
 name :: Text
 }
 deriving (Generic,Show) 

instance FromJSON Language


main :: IO ()
main = do
 languages <- getLanguages
 forM_ languages $ \language -> do
 result <- translateText "en" "Super duper poopy Haskell programmer." (code language)
 T.putStrLn ((name language) <> ": " <> result)

getLanguages :: IO [Language]
getLanguages = do
 response <- asJSON =<< get "https://translate.argosopentech.com/languages"
 pure (response ^. responseBody)

translateText :: Text -> Text -> Text -> IO Text
translateText sourceLanguage text targetLanguage = do
 response <- asJSON =<< post "https://translate.argosopentech.com/translate" (toJSON (TranslateRequest {
  q = text,
  source = sourceLanguage,
  target = targetLanguage,
  format = "text"
 }))
 pure (translatedText (response ^. responseBody))

































