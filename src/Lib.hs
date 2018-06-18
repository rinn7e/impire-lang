module Lib where

import Parser
import Codegen
import Emit

import Control.Monad.Trans

import System.IO
import System.Environment
import System.Console.Haskeline

import qualified LLVM.AST as AST

initModule :: AST.Module
initModule = emptyModule "<blank>" "<blank>"

process :: AST.Module -> String -> IO (Maybe AST.Module)
process modo source = do
  let res = parseToplevel source
  case res of
    Left err -> print err >> return Nothing
    Right ex -> do
      print $ show ex
      ast <- codegen modo ex
      return $ Just ast

processFile :: String -> IO (Maybe AST.Module)
processFile fname = readFile fname >>= (process $ emptyModule "<blank>" fname)

repl :: IO ()
repl = runInputT defaultSettings (loop initModule)
  where
  loop mod = do
    minput <- getInputLine "ready> "
    case minput of
      Nothing -> outputStrLn "Goodbye."
      Just input -> do
        modn <- liftIO $ process mod input
        case modn of
          Just modn -> loop modn
          Nothing -> loop mod
        -- let resultEither = parseToplevel input 
        -- case resultEither of
        --   Right a -> do
        --     print $ show a
        --     loop mod
        --   Left err -> 
        --     loop mod
        

run :: IO ()
run = do
  args <- getArgs
  case args of
    []      -> repl
    [fname] -> processFile fname >> return ()
