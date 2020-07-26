{-# OPTIONS_GHC -Wall -Werror #-}
{-# LANGUAGE PackageImports #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import "base" System.IO (stdin, stdout)
import "base" Data.Monoid ((<>))
import "base" Data.Char (toUpper)
import qualified "bytestring" Data.ByteString.Char8 as B8
import "resourcet" Control.Monad.Trans.Resource (runResourceT)
import "conduit" Data.Conduit
import qualified "conduit" Data.Conduit.Combinators as CC (map)
import qualified "conduit-extra" Data.Conduit.Binary as CB
import "QuickCheck" Test.QuickCheck.Gen ()
import "hint" Language.Haskell.Interpreter ()
import "brick" Brick ()
import "tree-sitter" TreeSitter.Parser ()
import "tree-sitter" TreeSitter.Tree ()
import "tree-sitter" TreeSitter.Language ()
import "tree-sitter-haskell" TreeSitter.Haskell ()
import "tree-sitter-python" TreeSitter.Python ()
import "amazonka" Network.AWS ()
import "amazonka-s3" Network.AWS.S3 ()

main :: IO ()
main = runResourceT . runConduit
     $ CB.sourceHandle stdin
    .| CB.lines
    .| CC.map (B8.map toUpper)
    .| CC.map (<> "\n")
    .| CB.sinkHandle stdout

