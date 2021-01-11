module TemplateType exposing (TemplateType(..), decoder)

import Data.Author
import Date
import Json.Decode as Decode exposing (Decoder)
import Metadata exposing (Article, PageMetadata)
import Pages
import Pages.ImagePath as ImagePath


type TemplateType
    = Page PageMetadata
    | Article Metadata.Article
    | BlogIndex ()


decoder : Decoder TemplateType
decoder =
    Decode.field "type" Decode.string
        |> Decode.andThen
            (\pageType ->
                case pageType of
                    "page" ->
                        Decode.field "title" Decode.string
                            |> Decode.map (\title -> Page { title = title })

                    "blog-index" ->
                        Decode.succeed (BlogIndex ())

                    "blog" ->
                        Decode.map6 Metadata.Article
                            (Decode.field "title" Decode.string)
                            (Decode.field "description" Decode.string)
                            (Decode.field "published"
                                (Decode.string
                                    |> Decode.andThen
                                        (\isoString ->
                                            case Date.fromIsoString isoString of
                                                Ok date ->
                                                    Decode.succeed date

                                                Err error ->
                                                    Decode.fail error
                                        )
                                )
                            )
                            (Decode.field "author" Data.Author.decoder)
                            (Decode.field "image" imageDecoder)
                            (Decode.field "draft" Decode.bool
                                |> Decode.maybe
                                |> Decode.map (Maybe.withDefault False)
                            )
                            |> Decode.map Article

                    _ ->
                        Decode.fail ("Unexpected page type " ++ pageType)
            )


imageDecoder : Decoder (ImagePath.ImagePath Pages.PathKey)
imageDecoder =
    Decode.succeed (ImagePath.external "TODO")
