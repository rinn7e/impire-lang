module Lib where

import Parser

import Control.Monad.Trans
import System.Console.Haskeline
import System.Environment
import System.IO

process :: String -> IO ()
process line = do
  let res = parseToplevel line
  case res of
    Left err -> print err
    Right ex -> mapM_ print ex


run :: IO ()
run = do
  args <- getArgs
  case args of
    x:_ -> do
      contents <- readFile x
      process contents
      
    [] -> runRepl


runRepl :: IO ()
runRepl = runInputT defaultSettings loop
  where
    loop = do
      minput <- getInputLine "ready> "
      case minput of
        Nothing -> outputStrLn "Goodbye."
        Just input -> (liftIO $ process input) >> loop
