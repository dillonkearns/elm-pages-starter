module TemplateMetadata exposing (..)

import Data.Author exposing (Author)
import Date exposing (Date)
import Pages
import Pages.ImagePath exposing (ImagePath)


type alias BlogIndex =
    ()


type alias BlogPost =
    { title : String
    , description : String
    , published : Date
    , author : Author
    , image : ImagePath Pages.PathKey
    , draft : Bool
    }


type alias Page =
    { title : String }
