module Template.Page exposing (Model, Msg, template)

import Head
import Head.Seo as Seo
import Pages exposing (images)
import Pages.PagePath exposing (PagePath)
import Shared
import Site
import Template exposing (StaticPayload, Template)
import TemplateMetadata exposing (Page)
import TemplateType exposing (TemplateType)


type alias Model =
    ()


type alias Msg =
    Never


type alias StaticData =
    ()


template : Template Page StaticData
template =
    Template.noStaticData { head = head }
        |> Template.buildNoState { view = view }


head :
    StaticPayload Page StaticData
    -> List (Head.Tag Pages.PathKey)
head { metadata } =
    Seo.summaryLarge
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages-starter"
        , image =
            { url = images.iconPng
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = Site.tagline
        , locale = Nothing
        , title = metadata.title
        }
        |> Seo.website


view :
    List ( PagePath Pages.PathKey, TemplateType )
    -> StaticPayload Page StaticData
    -> Shared.RenderedBody
    -> Shared.PageView Never
view allMetadata static rendered =
    { title = static.metadata.title
    , body =
        [ rendered
        ]
    }
