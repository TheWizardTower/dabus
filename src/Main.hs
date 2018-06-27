{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Semigroup ((<>))
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

data Actions = Clean (Vector Text)
             | Execute (Vector Text)
             | Link (Vector LinkStruct)
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
  putStrLn "Starting Greet function."
  x <- input auto file
  putStrLn "Read file."
  print (x :: DhallConfig)
