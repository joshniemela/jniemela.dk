{-# LANGUAGE OverloadedStrings #-}

import Control.Monad (forM_)
import Data.List (isPrefixOf, isSuffixOf)
import Data.Maybe (fromMaybe)
import Hakyll
import Hakyll.Web.Paginate
import qualified Data.Text as T
import qualified Data.Text.Slugger as Slugger
import System.FilePath (takeFileName)
import Text.Pandoc
  ( Extension (Ext_fenced_code_attributes, Ext_footnotes, Ext_gfm_auto_identifiers, Ext_implicit_header_references, Ext_smart),
    Extensions,
    ReaderOptions,
    WriterOptions (writerHighlightStyle),
    extensionsFromList,
    githubMarkdownExtensions,
    readerExtensions,
    writerExtensions,
  )
import Text.Pandoc.Highlighting (Style, breezeDark, styleToCss)
import System.FilePath
import Data.List (isInfixOf)
import Colours (colours)
--------------------------------------------------------------------------------
-- PERSONALIZATION

mySiteName :: String
mySiteName = "My Site Name"

mySiteRoot :: String
mySiteRoot = "https://jniemela.dk"


--------------------------------------------------------------------------------
-- CONFIG

-- Default configuration: https://github.com/jaspervdj/hakyll/blob/cd74877d41f41c4fba27768f84255e797748a31a/lib/Hakyll/Core/Configuration.hs#L101-L125
config :: Configuration
config =
  defaultConfiguration
    { destinationDirectory = "dist"
    , ignoreFile = ignoreFile'
    , previewHost = "127.0.0.1"
    , previewPort = 8000
    , providerDirectory = "src"
    , storeDirectory = "ssg/_cache"
    , tmpDirectory = "ssg/_tmp"
    }
  where
    ignoreFile' path
      | "."    `isPrefixOf` fileName = False
      | "#"    `isPrefixOf` fileName = True
      | "~"    `isSuffixOf` fileName = True
      | ".swp" `isSuffixOf` fileName = True
      | otherwise = False
      where
        fileName = takeFileName path

--------------------------------------------------------------------------------
-- BUILD

main :: IO ()
main = hakyllWith config $ do
  forM_
    [ "CNAME"
    , "favicon.ico"
    , "robots.txt"
    , "_config.yml"
    , "images/*"
    , "js/*"
    , "fonts/*"
    ]
    $ \f -> match f $ do
      route idRoute
      compile copyFileCompiler

  match "css/*" $ do
    route idRoute
    compile compressCssCompiler


  -- Compile projects twice, to avoid a dependency cycle
  match "projects/*" $ do
    route $ metadataRoute titleRoute
    compile getResourceBody

  match "projects/*" $ version "final" $ do
    let ctx = constField "type" "article" <> projectCtx <> projectsCtx

    route $ metadataRoute titleRoute
    compile $
      pandocCompilerCustom
        >>= loadAndApplyTemplate "templates/project.html" ctx
        >>= saveSnapshot "content"
        >>= loadAndApplyTemplate "templates/default.html" ctx

  match "index.html" $ do
    route idRoute
    compile $ do

      let indexCtx =
              constField "root" mySiteRoot
              <> constField "siteName" mySiteName
              <> siteCtx

      getResourceBody
        >>= applyAsTemplate indexCtx
        >>= loadAndApplyTemplate "templates/default.html" indexCtx

  match "projects.md" $ do
    route $ setExtension "html"
    compile $ do
      let projCtx =
            constField "root" mySiteRoot
              <> constField "siteName" mySiteName
              <> projectsCtx
              <> siteCtx

      pandocCompilerCustom
        >>= loadAndApplyTemplate "templates/default.html" projCtx

  match (fromList ["about.md", "contact.md", "cv.md"]) $ do
    route $ setExtension "html"
    compile $
      pandocCompilerCustom
        >>= loadAndApplyTemplate "templates/default.html" siteCtx

  match "templates/*" $
    compile templateBodyCompiler

  create ["sitemap.xml"] $ do
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAll "projects/*"

      let pages = posts
          sitemapCtx =
            constField "root" mySiteRoot
              <> constField "siteName" mySiteName
              <> listField "pages" projectCtx (return pages)

      makeItem ("" :: String)
        >>= loadAndApplyTemplate "templates/sitemap.xml" sitemapCtx

  create ["css/code.css"] $ do
    route idRoute
    compile (makeStyle pandocHighlightStyle)

--------------------------------------------------------------------------------
-- COMPILER HELPERS

makeStyle :: Style -> Compiler (Item String)
makeStyle =
  makeItem . compressCss . styleToCss

--------------------------------------------------------------------------------
-- CONTEXT


projectCtx :: Context String
projectCtx =
  constField "root" mySiteRoot
    <> constField "siteName" mySiteName
    <> dateField "date" "%Y-%m-%d"
    <> siteCtx

titleCtx :: Context String
titleCtx =
  field "title" updatedTitle

siteCtx :: Context String
siteCtx =
  constField "root" mySiteRoot
    <> constField "siteName" mySiteName
    <> defaultContext
    <> activeClassField
    <> directoryField "dir"
    <> paletteCtx



--------------------------------------------------------------------------------
-- TITLE HELPERS

replaceAmp :: String -> String
replaceAmp =
  replaceAll "&" (const "&amp;")

replaceTitleAmp :: Metadata -> String
replaceTitleAmp =
  replaceAmp . safeTitle

safeTitle :: Metadata -> String
safeTitle =
  fromMaybe "no title" . lookupString "title"

updatedTitle :: Item a -> Compiler String
updatedTitle =
  fmap replaceTitleAmp . getMetadata . itemIdentifier

--------------------------------------------------------------------------------
-- PANDOC

pandocCompilerCustom :: Compiler (Item String)
pandocCompilerCustom =
  pandocCompilerWith pandocReaderOpts pandocWriterOpts

pandocExtensionsCustom :: Extensions
pandocExtensionsCustom =
  githubMarkdownExtensions
    <> extensionsFromList
      [ Ext_fenced_code_attributes
      , Ext_gfm_auto_identifiers
      , Ext_implicit_header_references
      , Ext_smart
      , Ext_footnotes
      ]

pandocReaderOpts :: ReaderOptions
pandocReaderOpts =
  defaultHakyllReaderOptions
    { readerExtensions = pandocExtensionsCustom
    }

pandocWriterOpts :: WriterOptions
pandocWriterOpts =
  defaultHakyllWriterOptions
    { writerExtensions = pandocExtensionsCustom
    , writerHighlightStyle = Just pandocHighlightStyle
    }

pandocHighlightStyle :: Style
pandocHighlightStyle =
  breezeDark -- https://hackage.haskell.org/package/pandoc/docs/Text-Pandoc-Highlighting.html

--------------------------------------------------------------------------------
-- CUSTOM ROUTE

fileNameFromTitle :: Metadata -> FilePath
fileNameFromTitle =
  T.unpack . (`T.append` ".html") . Slugger.toSlug . T.pack . safeTitle

titleRoute :: Metadata -> Routes
titleRoute =
  constRoute . fileNameFromTitle



-- Active link for navbar
-- https://groups.google.com/forum/#!searchin/hakyll/if$20class/hakyll/WGDYRa3Xg-w/nMJZ4KT8OZUJ 




directoryField :: String -> Context a
directoryField = mapContext (dropExtension . indexToHome) . pathField

activeClassField :: Context a
activeClassField = functionField "activeClass" $ \[p] _ -> do
  -- if direcoryField contains "home" then "active" else "inactive"
  path <- toFilePath <$> getUnderlying
  return $ if p `isInfixOf` path then "active" else "inactive"

indexToHome :: FilePath -> FilePath
indexToHome path
  | takeBaseName path == "index" = replaceBaseName path "home"
  | otherwise = path

-- This adds the listfield "projects" to the context of the page
projectsCtx :: Context String
projectsCtx = listField "projects" projectCtx (loadAll ("projects/*" .&&. hasNoVersion))

paletteCtx :: Context String
paletteCtx = foldr1 (<>) $ map (uncurry constField) colours
