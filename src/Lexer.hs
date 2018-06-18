module Lexer where

import Text.Parsec.String (Parser)
import Text.Parsec.Language (emptyDef)
import Text.Parsec.Prim (many)

import qualified Text.Parsec.Token as Tok

lexer :: Tok.TokenParser ()
lexer = Tok.makeTokenParser style
  where
    ops = ["+","*","-","/",";","=",",","<",">","|",":"]
    names = ["def","extern","if","then","else","in","for"
            ,"binary", "unary"]
    style = emptyDef {
               Tok.commentLine = "#"
             , Tok.reservedOpNames = ops
             , Tok.reservedNames = names
             }

-- -- 1, -2, 42
-- integer :: Parser Integer
-- integer = Tok.integer lexer

-- -- 3.14, 2.71, 0.0
-- float :: Parser Double
-- float = Tok.float lexer

-- -- a, b, foo, ncc12d
-- identifier :: Parser String
-- identifier = Tok.identifier lexer

-- parens :: Parser a -> Parser a
-- parens = Tok.parens lexer

-- commaSep :: Parser a -> Parser [a]
-- commaSep = Tok.commaSep lexer

-- semiSep :: Parser a -> Parser [a]
-- semiSep = Tok.semiSep lexer


-- reserved :: String -> Parser ()
-- reserved = Tok.reserved lexer

-- reservedOp :: String -> Parser ()
-- reservedOp = Tok.reservedOp lexer

integer    = Tok.integer lexer
float      = Tok.float lexer
parens     = Tok.parens lexer
commaSep   = Tok.commaSep lexer
semiSep    = Tok.semiSep lexer
identifier = Tok.identifier lexer
whitespace = Tok.whiteSpace lexer
reserved   = Tok.reserved lexer
reservedOp = Tok.reservedOp lexer

operator :: Parser String
operator = do
  c <- Tok.opStart emptyDef
  cs <- many $ Tok.opLetter emptyDef
  return (c:cs)