module Metadata exposing (Article, PageMetadata)

import Data.Author
import Date exposing (Date)
import Json.Decode as Decode exposing (Decoder)
import List.Extra
import Pages
import Pages.ImagePath as ImagePath exposing (ImagePath)


type alias Article =
    { title : String
    , description : String
    , published : Date
    , author : Data.Author.Author
    , image : ImagePath Pages.PathKey
    , draft : Bool
    }


type alias PageMetadata =
    { title : String }


type alias BlogIndex =
    ()
