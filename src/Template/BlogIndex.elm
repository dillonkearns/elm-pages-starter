module Template.BlogIndex exposing (Model, Msg, template)

import Element
import Head
import Index
import Pages
import Pages.PagePath exposing (PagePath)
import Shared
import Template exposing (StaticPayload, Template)
import TemplateMetadata exposing (BlogIndex)
import TemplateType exposing (TemplateType)


type alias Model =
    ()


type alias Msg =
    Never


type alias StaticData =
    ()


template : Template BlogIndex StaticData
template =
    Template.noStaticData { head = head }
        |> Template.buildNoState { view = view }


head :
    StaticPayload BlogIndex StaticData
    -> List (Head.Tag Pages.PathKey)
head { metadata } =
    []


view :
    List ( PagePath Pages.PathKey, TemplateType )
    -> StaticPayload BlogIndex StaticData
    -> Shared.RenderedBody
    -> Shared.PageView msg
view allMetadata static rendered =
    { title = "elm-pages blog"
    , body =
        [ Element.column [ Element.padding 20, Element.centerX ] [ Index.view allMetadata ]
        ]
    }
