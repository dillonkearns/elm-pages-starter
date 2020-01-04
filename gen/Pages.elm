port module Pages exposing (PathKey, allPages, allImages, internals, images, isValidRoute, pages, buildTime)

import Color exposing (Color)
import Pages.Internal
import Head
import Html exposing (Html)
import Json.Decode
import Json.Encode
import Mark
import Pages.Platform
import Pages.Manifest exposing (DisplayMode, Orientation)
import Pages.Manifest.Category as Category exposing (Category)
import Url.Parser as Url exposing ((</>), s)
import Pages.Document as Document
import Pages.ImagePath as ImagePath exposing (ImagePath)
import Pages.PagePath as PagePath exposing (PagePath)
import Pages.Directory as Directory exposing (Directory)
import Time


buildTime : Time.Posix
buildTime = 
    Time.millisToPosix 1578096231

type PathKey
    = PathKey


buildImage : List String -> ImagePath PathKey
buildImage path =
    ImagePath.build PathKey ("images" :: path)



buildPage : List String -> PagePath PathKey
buildPage path =
    PagePath.build PathKey path


directoryWithIndex : List String -> Directory PathKey Directory.WithIndex
directoryWithIndex path =
    Directory.withIndex PathKey allPages path


directoryWithoutIndex : List String -> Directory PathKey Directory.WithoutIndex
directoryWithoutIndex path =
    Directory.withoutIndex PathKey allPages path


port toJsPort : Json.Encode.Value -> Cmd msg


internals : Pages.Internal.Internal PathKey
internals =
    { applicationType = Pages.Internal.Browser
    , toJsPort = toJsPort
    , content = content
    , pathKey = PathKey
    }
        



allPages : List (PagePath PathKey)
allPages =
    [ (buildPage [ "blog", "draft" ])
    , (buildPage [ "blog", "hello" ])
    , (buildPage [ "blog" ])
    , (buildPage [  ])
    ]

pages =
    { blog =
        { draft = (buildPage [ "blog", "draft" ])
        , hello = (buildPage [ "blog", "hello" ])
        , index = (buildPage [ "blog" ])
        , directory = directoryWithIndex ["blog"]
        }
    , index = (buildPage [  ])
    , directory = directoryWithIndex []
    }

images =
    { articleCovers =
        { hello = (buildImage [ "article-covers", "hello.jpg" ])
        , mountains = (buildImage [ "article-covers", "mountains.jpg" ])
        , directory = directoryWithoutIndex ["articleCovers"]
        }
    , author =
        { dillon = (buildImage [ "author", "dillon.jpg" ])
        , directory = directoryWithoutIndex ["author"]
        }
    , elmLogo = (buildImage [ "elm-logo.svg" ])
    , github = (buildImage [ "github.svg" ])
    , iconPng = (buildImage [ "icon-png.png" ])
    , icon = (buildImage [ "icon.svg" ])
    , directory = directoryWithoutIndex []
    }

allImages : List (ImagePath PathKey)
allImages =
    [(buildImage [ "article-covers", "hello.jpg" ])
    , (buildImage [ "article-covers", "mountains.jpg" ])
    , (buildImage [ "author", "dillon.jpg" ])
    , (buildImage [ "elm-logo.svg" ])
    , (buildImage [ "github.svg" ])
    , (buildImage [ "icon-png.png" ])
    , (buildImage [ "icon.svg" ])
    ]


isValidRoute : String -> Result String ()
isValidRoute route =
    let
        validRoutes =
            List.map PagePath.toString allPages
    in
    if
        (route |> String.startsWith "http://")
            || (route |> String.startsWith "https://")
            || (route |> String.startsWith "#")
            || (validRoutes |> List.member route)
    then
        Ok ()

    else
        ("Valid routes:\n"
            ++ String.join "\n\n" validRoutes
        )
            |> Err


content : List ( List String, { extension: String, frontMatter : String, body : Maybe String } )
content =
    [ 
  ( []
    , { frontMatter = """{"title":"elm-pages-starter - a simple blog starter","type":"page"}
""" , body = Nothing
    , extension = "md"
    } )
  ,
  ( ["blog", "draft"]
    , { frontMatter = """{"type":"blog","author":"Dillon Kearns","title":"A Draft Blog Post","description":"I'm not quite ready to share this post with the world","image":"/images/article-covers/mountains.jpg","draft":true,"published":"2019-09-21"}
""" , body = Nothing
    , extension = "md"
    } )
  ,
  ( ["blog", "hello"]
    , { frontMatter = """{"type":"blog","author":"Dillon Kearns","title":"Hello `elm-pages`! 🚀","description":"Here's an intro for my blog post to get you interested in reading more...","image":"/images/article-covers/hello.jpg","published":"2019-09-21"}
""" , body = Nothing
    , extension = "md"
    } )
  ,
  ( ["blog"]
    , { frontMatter = """{"title":"elm-pages blog","type":"blog-index"}
""" , body = Nothing
    , extension = "md"
    } )
  
    ]
