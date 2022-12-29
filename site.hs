{-# LANGUAGE OverloadedStrings #-}
import Hakyll
import System.FilePath
main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["about.md"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" siteCtx
            >>= relativizeUrls

    match "portfolio/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

--    create ["archive.html"] $ do
--        route idRoute
--        compile $ do
--            posts <- recentFirst =<< loadAll "portfolio/*"
--            let archiveCtx =
--                    listField "posts" postCtx (return posts) <>
--                    constField "title" "Archives"            <>
--                    siteCtx
--
--            makeItem ""
--                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
--                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
--                >>= relativizeUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "portfolio/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) <>
                    constField "title" "Home" <>
                    siteCtx

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" <>
    siteCtx 

siteCtx :: Context String
siteCtx =
  defaultContext <>
	activeClassField <>
  modificationTimeField "updated" "%F" <>
  directoryField "dir"

-- https://groups.google.com/forum/#!searchin/hakyll/if$20class/hakyll/WGDYRa3Xg-w/nMJZ4KT8OZUJ 
activeClassField :: Context a 
activeClassField = functionField "activeClass" $ \[p] _ -> do 
	path <- toFilePath <$> getUnderlying 
	return $ if path == p then "active" else "inactive" 

directoryField :: String -> Context a
directoryField = mapContext (dropExtension . indexToHome) . pathField

indexToHome :: FilePath -> FilePath
indexToHome path
  | takeBaseName path == "index" = replaceBaseName path "home"
  | otherwise = path
