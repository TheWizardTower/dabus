{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Semigroup ((<>))
import qualified Data.Vector as V
import Dhall
import Options.Applicative hiding (auto)

data Arguments = Arguments
  { conf_file     :: Text
  , dry_run       :: Bool
  }

sample :: Parser Arguments
sample = Arguments
  <$> strOption
    (long "file"
    <> short 'f'
    <> showDefault
    <> help "Configuration file to use for dotfiles setup.")
  <*> switch
    (long "dry-run"
    <> help "Dry run mode."
    )

type CleanTargets   = Vector Text
type ExecuteTargets = Vector Text
type LinkTargets    = Vector LinkStruct

data Actions = Clean CleanTargets
             | Execute ExecuteTargets
             | Link LinkTargets
             deriving (Eq, Interpret, Generic, Show)

data LinkStruct = LinkStruct { dest :: Text, src :: Text }
  deriving (Eq, Interpret, Generic, Show)

data DhallConfig = DhallConfig { defaults :: Maybe (Vector Bool), conf :: Vector Actions }
  deriving (Eq, Interpret, Generic, Show)

main :: IO ()
main = do
  greet =<< execParser opts
  where
    opts = info (sample <**> helper)
      ( fullDesc
      <> progDesc "Manage setting up your dotfiles on new systems."
      <> header "dabus -- a config management tool.")


greet :: Arguments -> IO ()
greet (Arguments file _) = do
  let myConfig = DhallConfig {
        defaults = Nothing
        , conf = V.fromList [ Clean $ V.fromList ["~/"]
                 , Execute $ V.fromList ["/bin/false"]
                 , Link $ V.fromList [ LinkStruct { dest = "~/.spacemacs", src = "spacemacs" }
                        ]
                 ]
      }
  print myConfig
  putStrLn "Starting Greet function."
  x <- detailed $ input auto file
  putStrLn "Read file."
  print (x :: DhallConfig)
