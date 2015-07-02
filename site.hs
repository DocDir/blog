--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import Control.Applicative ((<$>))
import Control.Monad       (forM_)
import Hakyll
import Text.Pandoc


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do

    -- CSS
    match "css/*" $ do
        route idRoute
        compile compressCssCompiler

    -- Pages
    match "*.org" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    -- Templates
    match "templates/*" $ compile templateCompiler